import { PrismaClient } from '@prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import pg from 'pg';
import fs from 'fs';
import path from 'path';
import matter from 'gray-matter';
import { marked } from 'marked';
import yaml from 'js-yaml';
import dotenv from 'dotenv';

dotenv.config();

const connectionString = `${process.env.DATABASE_URL}`;
const pool = new pg.Pool({ connectionString });
const adapter = new PrismaPg(pool as any);
const prisma = new PrismaClient({ adapter });

const postsPath = path.resolve(__dirname, '../../../data/_posts');
const dataPath = path.resolve(__dirname, '../../../data/_data');

async function main() {
  console.log('🚀 Starting data migration from files to PostgreSQL...');

  // 1. Migrate Posts
  if (fs.existsSync(postsPath)) {
    const files = fs.readdirSync(postsPath).filter(f => f.endsWith('.md') && f !== 'BLOG_TEMPLATE.md' && f !== 'COMMIT_LOG_FORMAT.md');
    console.log(`📄 Found ${files.length} posts to migrate.`);

    const validSlugs: string[] = [];

    for (const file of files) {
      const rawContent = fs.readFileSync(path.join(postsPath, file), 'utf8');
      const { data, content } = matter(rawContent);
      
      const processedContent = content
        .replace(/\{\{\s*site\.baseurl\s*\}\}/g, '')
        .replace(/\{%\s*highlight\s+(\w+)\s*%\}/g, '```$1\n')
        .replace(/\{%\s*endhighlight\s*%\}/g, '```\n');

      const htmlContent = marked(processedContent) as string;
      const excerpt = processedContent.replace(/<[^>]*>?/gm, '').substring(0, 120) + '...';
      const slug = file.replace('.md', '');
      validSlugs.push(slug);

      // Normalize categories and tags
      let categories = data.categories || [];
      if (typeof categories === 'string') categories = [categories];
      let tags = data.tags || [];
      if (typeof tags === 'string') tags = [tags];

      await prisma.post.upsert({
        where: { slug },
        update: {
          title: data.title || slug,
          date: data.date ? new Date(data.date) : new Date(),
          last_modified_at: data.last_modified_at ? new Date(data.last_modified_at) : null,
          content: processedContent,
          htmlContent,
          excerpt,
          subject: data.subject || null,
          categories,
          tags,
          layout: data.layout || 'post',
        },
        create: {
          slug,
          title: data.title || slug,
          date: data.date ? new Date(data.date) : new Date(),
          last_modified_at: data.last_modified_at ? new Date(data.last_modified_at) : null,
          content: processedContent,
          htmlContent,
          excerpt,
          subject: data.subject || null,
          categories,
          tags,
          layout: data.layout || 'post',
        },
      });
      console.log(`✅ Migrated post: ${slug} (Synced at: ${new Date().toLocaleTimeString()})`);
    }

    // 清理步骤：删除数据库中存在但磁盘上已删除的文章
    const deleteResult = await prisma.post.deleteMany({
      where: {
        slug: {
          notIn: validSlugs
        }
      }
    });
    if (deleteResult.count > 0) {
      console.log(`🗑️ Pruned ${deleteResult.count} obsolete posts from database.`);
    }
  }

  // 2. Migrate Recommendations
  const recFile = path.join(dataPath, 'recommendations.yml');
  if (fs.existsSync(recFile)) {
    const recData: any = yaml.load(fs.readFileSync(recFile, 'utf8'));
    if (recData && recData.date) {
      await prisma.recommendation.upsert({
        where: { date: recData.date },
        update: {
          tech: recData.tech || {},
          paper: recData.paper || [],
          llm: recData.llm || [],
          algorithm: recData.algorithm || [],
          new_project: recData.new_project || [],
          history: recData.history || [],
          cv_recommend: recData.cv_recommend || {},
        },
        create: {
          date: recData.date,
          tech: recData.tech || {},
          paper: recData.paper || [],
          llm: recData.llm || [],
          algorithm: recData.algorithm || [],
          new_project: recData.new_project || [],
          history: recData.history || [],
          cv_recommend: recData.cv_recommend || {},
        },
      });
      console.log(`✅ Migrated recommendations for date: ${recData.date}`);
    }
  }

  // 3. Migrate History
  const historyFile = path.join(dataPath, 'history.json');
  if (fs.existsSync(historyFile)) {
    const historyData = JSON.parse(fs.readFileSync(historyFile, 'utf8'));
    for (const date in historyData) {
      await prisma.historyLog.upsert({
        where: { date },
        update: { titles: historyData[date] },
        create: { date, titles: historyData[date] },
      });
    }
    console.log('✅ Migrated history logs.');
  }

  // 4. Migrate Me Info
  const meFile = path.join(dataPath, 'me.yml');
  if (fs.existsSync(meFile)) {
    const meData = yaml.load(fs.readFileSync(meFile, 'utf8'));
    await prisma.meInfo.upsert({
      where: { id: 1 },
      update: { content: meData as any },
      create: { id: 1, content: meData as any },
    });
    console.log('✅ Migrated Me Info.');
  }

  console.log('✨ Data migration completed successfully!');
}

main()
  .catch((e) => {
    console.error('❌ Migration failed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
    await pool.end();
  });
