import { prisma } from '../lib/prisma';

export class PostsService {
    static async getAllPosts(category?: string) {
        try {
            const where: any = {};
            if (category) {
                where.categories = {
                    array_contains: category
                };
            }

            return await prisma.post.findMany({
                where: category ? {
                    categories: {
                        path: [],
                        array_contains: category
                    }
                } : {},
                orderBy: {
                    date: 'desc'
                }
            });
        } catch (e) {
            console.error("Error fetching posts from DB:", e);
            return [];
        }
    }

    // Since Prisma Json filtering can be tricky depending on setup, 
    // let's use a simpler approach if array_contains has issues with nested jsonb
    static async getPostsByCategory(category: string) {
        const allPosts = await prisma.post.findMany({
            orderBy: { date: 'desc' }
        });
        return allPosts.filter((p: any) => {
            const cats = p.categories as string[];
            return Array.isArray(cats) && cats.includes(category);
        });
    }

    static async getPostById(id: string) {
        return await prisma.post.findUnique({
            where: { slug: id }
        });
    }

    static async searchPosts(query: string) {
        if (!query) return await this.getAllPosts();
        
        return await prisma.post.findMany({
            where: {
                OR: [
                    { title: { contains: query, mode: 'insensitive' } },
                    { content: { contains: query, mode: 'insensitive' } },
                ]
            },
            orderBy: {
                date: 'desc'
            }
        });
    }

    static async refreshCache() {
        // No cache needed for DB, or implement redis if desired
    }
}
