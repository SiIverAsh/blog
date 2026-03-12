<script setup lang="ts">
import { ref, onMounted } from 'vue'

const isTechSubTagsVisible = ref(false)
const recommendations = ref<any>({})

const fetchInitialData = async () => {
  try {
    const postsRes = await fetch('http://localhost:3000/api/posts')
    if (postsRes.ok) {
      const posts = await postsRes.json()
      const recentPosts = posts
        .filter((p: any) => p.date)
        .sort((a: any, b: any) => new Date(b.date).getTime() - new Date(a.date).getTime())
        .slice(0, 5)
      
      const postsHtml = recentPosts.map((post: any) => {
        const dateStr = new Date(post.date).toISOString().split('T')[0]
        return `<li><span class="file-perms">-rw-r--r--</span> <span class="file-user">siiverash</span> <span class="post-date">${dateStr}</span> <a href="/post/${post.slug}" class="post-title">${post.title}</a></li>`
      }).join('')
      
      terminalLines.value = [
        `<p><span class="prompt">siiverash@ubuntu:~$</span> <span class="command">ls -l ./recent_posts/</span></p>
        <ul class="terminal-post-list">
            ${postsHtml}
        </ul>`
      ]
    }

    const recRes = await fetch('http://localhost:3000/api/recommendations')
    if (recRes.ok) {
      recommendations.value = await recRes.json()
    }
  } catch (error) {
    console.error("Failed to fetch initial data", error)
    terminalLines.value = [
        `<p><span class="prompt">siiverash@ubuntu:~$</span> <span class="command">ls -l ./recent_posts/</span></p>
        <p style="color: #ff5f56; margin-top: 10px;">Error: Failed to connect to database server.</p>`
    ]
  }
}

onMounted(() => {
  fetchInitialData()
})

const handleTechClick = () => {
  isTechSubTagsVisible.value = true
  typeCommand('./fetch_recommendation.sh --category tech', () => {
    return `<div class="term-output-box">
      <div style="color: #e5e7eb; line-height: 1.6; font-size: 0.95em;">Please select a specific tech category from the sub-tags above.</div>
    </div>`
  })
}

const showTechDetail = (sub: string) => {
  typeCommand(`./fetch_recommendation.sh --category tech --sub "${sub}"`, () => {
    const items = recommendations.value?.tech?.[sub] || []
    return renderItems(items)
  })
}

const handleCategoryClick = (category: string) => {
  isTechSubTagsVisible.value = false
  typeCommand(`./fetch_recommendation.sh --category ${category}`, () => {
    const items = recommendations.value?.[category] || []
    return renderItems(items)
  })
}

const renderItems = (items: any[]) => {
  if (!items || items.length === 0) {
    return `<div class="term-output-box">
      <div style="color: #e5e7eb; line-height: 1.6; font-size: 0.95em;">No recommendations found for this category yet.</div>
    </div>`
  }
  
  return items.map(item => {
    const tagsHtml = item.tags ? item.tags.map((t: string) => `<span class="term-tag">#${t}</span>`).join('') : ''
    const urlHtml = item.url ? `<div style="margin-top: 8px;"><a href="${item.url}" target="_blank" style="color: #60a5fa; text-decoration: none; font-size: 0.9em;">[🔗 Link]</a></div>` : ''
    // Handle history events which have 'year' and 'event'
    const titleHtml = item.title ? `<div style="color: var(--primary-color); font-weight: bold; font-size: 1.1em; margin-bottom: 8px;">${item.title}</div>` : ''
    const eventYearHtml = item.year ? `<div style="color: var(--primary-color); font-weight: bold; font-size: 1.1em; margin-bottom: 8px;">${item.year}</div>` : ''
    const descHtml = item.desc ? `<div style="color: #e5e7eb; line-height: 1.6; font-size: 0.95em;">${item.desc}</div>` : ''
    const eventDescHtml = item.event ? `<div style="color: #e5e7eb; line-height: 1.6; font-size: 0.95em;">${item.event}</div>` : ''
    
    return `
      <div class="term-output-box" style="margin-bottom: 15px;">
          ${titleHtml || eventYearHtml}
          ${descHtml || eventDescHtml}
          ${tagsHtml ? `<div style="margin-top: 10px;">${tagsHtml}</div>` : ''}
          ${urlHtml}
      </div>
    `
  }).join('')
}

const terminalLines = ref<string[]>([
  `<p><span class="prompt">siiverash@ubuntu:~$</span> <span class="command">ls -l ./recent_posts/</span></p>
  <ul class="terminal-post-list">
      <li><span style="color: #8b949e;">Loading recent posts...</span></li>
  </ul>`
])

const isTyping = ref(false)

const typeCommand = (cmdText: string, getResultHtml: () => string) => {
  if (isTyping.value) return; // Prevent multiple commands running simultaneously
  isTyping.value = true
  terminalLines.value.push(`<p><span class="prompt">siiverash@ubuntu:~$</span> <span class="command">${cmdText}</span></p>`)
  terminalLines.value.push(`<p style="color: #8b949e; margin-top: 5px;" id="loading-line">> Fetching data from database...</p>`)

  setTimeout(() => {
    isTyping.value = false
    terminalLines.value.pop()
    terminalLines.value.push(getResultHtml())
    
    setTimeout(() => {
      const el = document.getElementById('terminal-body')
      if (el) {
        el.scrollTo({
          top: el.scrollHeight,
          behavior: 'smooth'
        })
      }
    }, 50)
  }, 600)
}
</script>

<template>
  <div style="text-align: center; padding: 10px 0;">
    <h1 style="font-size: 2.5em; color: #1d508a; margin-bottom: 20px;">Welcome to My HP!</h1>
    <p style="font-size: 1.1em; line-height: 1.8;">Attention Is All You Need!</p>

    <!-- Categories Cards -->
    <div style="margin-top: 30px; display: flex; justify-content: center; gap: 15px; flex-wrap: wrap; max-width: 900px; margin-left: auto; margin-right: auto;">
      <div class="tech-card" @click="handleTechClick">
        <h3>💻 Tech</h3>
        <p>前沿技术动态</p>
      </div>
      <div class="tech-card" @click="handleCategoryClick('paper')">
        <h3>📄 Paper</h3>
        <p>顶会论文推荐</p>
      </div>
      <div class="tech-card" @click="handleCategoryClick('llm')">
        <h3>🧠 LLM</h3>
        <p>大语言模型进展</p>
      </div>
      <div class="tech-card" @click="handleCategoryClick('algorithm')">
        <h3>📊 Algorithm</h3>
        <p>算法与机器学习</p>
      </div>
      <div class="tech-card" @click="handleCategoryClick('new_project')">
        <h3>🚀 New Project</h3>
        <p>GitHub 最新开源</p>
      </div>
    </div>

    <!-- Tech Sub-tags -->
    <div v-show="isTechSubTagsVisible" id="tech-sub-tags" style="margin-top: 25px; animation: fadeIn 0.5s;">
      <span class="sub-tag" @click="showTechDetail('Computer Vision')">计算机视觉 (CV)</span>
      <span class="sub-tag" @click="showTechDetail('NLP')">自然语言 (NLP)</span>
      <span class="sub-tag" @click="showTechDetail('Audio')">音频处理 (Audio)</span>
      <span class="sub-tag" @click="showTechDetail('Net')">网络协议 (Net)</span>
      <span class="sub-tag" @click="showTechDetail('Lang')">编程语言 (Lang)</span>
      <br>
      <span class="sub-tag" @click="showTechDetail('Arch')">系统架构 (Arch)</span>
      <span class="sub-tag" @click="showTechDetail('GPU')">硬件显卡 (GPU)</span>
      <span class="sub-tag" @click="showTechDetail('CPU')">处理器 (CPU)</span>
      <span class="sub-tag" @click="showTechDetail('News')">科技动态 (News)</span>
    </div>

    <!-- Terminal Box -->
    <div class="terminal-container">
      <div class="terminal-header">
        <div class="terminal-buttons">
          <span class="btn close"></span>
          <span class="btn min"></span>
          <span class="btn max"></span>
        </div>
        <div class="terminal-title">siiverash@ubuntu: ~/workspace</div>
      </div>
      <div class="terminal-body" id="terminal-body">
        <div v-for="(line, index) in terminalLines" :key="index" v-html="line"></div>
        <p style="margin-top: 15px;" v-if="!isTyping">
          <span class="prompt">siiverash@ubuntu:~$</span> 
          <span class="typing-animation">Waiting for input...</span>
          <span class="cursor"></span>
        </p>
      </div>
    </div>
  </div>
</template>

<style>
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.tech-card {
  background: var(--glass-bg, rgba(20, 20, 25, 0.4));
  color: var(--text-main, #d1d5db);
  padding: 15px 10px;
  border-radius: 10px;
  width: calc(20% - 15px);
  min-width: 140px;
  flex-grow: 1;
  cursor: pointer;
  transition: 0.3s;
  border: 1px solid var(--glass-border, rgba(255, 255, 255, 0.1));
  box-shadow: var(--shadow, 0 8px 32px 0 rgba(0, 0, 0, 0.3));
  text-align: center;
  backdrop-filter: blur(10px);
}

.tech-card h3 {
  font-size: 1.1em;
  margin-bottom: 5px;
  color: #1d508a;
  text-shadow: 0 0 10px rgba(29, 80, 138, 0.3);
}

.tech-card p {
  font-size: 0.8em;
  color: var(--text-main, #9ca3af);
}

.tech-card:hover {
  transform: translateY(-5px);
  border-color: #1d508a;
  box-shadow: 0 10px 40px rgba(29, 80, 138, 0.2);
}

.sub-tag {
  display: inline-block;
  padding: 5px 12px;
  margin: 4px;
  background: var(--glass-bg, rgba(20, 20, 25, 0.6));
  border: 1px solid #1d508a;
  color: #1d508a;
  border-radius: 4px;
  font-size: 0.85em;
  cursor: pointer;
  transition: 0.3s;
  font-weight: bold;
}

.sub-tag:hover {
  background: #1d508a;
  color: white;
}

.terminal-container {
  margin: 40px auto;
  max-width: 900px;
  background: rgba(15, 15, 20, 0.85);
  border-radius: 10px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  box-shadow: 0 20px 50px rgba(0,0,0,0.6);
  overflow: hidden;
  backdrop-filter: blur(15px);
  text-align: left;
  font-family: 'Fira Code', 'Consolas', 'Courier New', monospace;
}

.terminal-header {
  background: rgba(30, 30, 35, 0.9);
  padding: 10px 15px;
  display: flex;
  align-items: center;
  border-bottom: 1px solid rgba(0, 0, 0, 0.5);
}

.terminal-buttons {
  display: flex;
  gap: 8px;
}

.terminal-buttons .btn {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  display: inline-block;
}

.btn.close { background-color: #ff5f56; }
.btn.min { background-color: #ffbd2e; }
.btn.max { background-color: #27c93f; }

.terminal-title {
  flex: 1;
  text-align: center;
  color: #8b949e;
  font-size: 0.85em;
  margin-right: 40px;
}

.terminal-body {
  padding: 20px;
  color: #e5e7eb;
  font-size: 0.95em;
  line-height: 1.6;
  max-height: 500px;
  overflow-y: auto;
}

.prompt {
  color: #10b981;
  font-weight: bold;
  margin-right: 8px;
}

.command {
  color: #fcd34d;
}

.terminal-post-list {
  list-style: none;
  padding: 0;
  margin: 15px 0 20px 0;
}

.terminal-post-list li {
  margin-bottom: 8px;
  display: flex;
  flex-wrap: wrap;
  gap: 15px;
  align-items: center;
}

.file-perms { color: #6b7280; }
.file-user { color: #3b82f6; }
.post-date { color: #8b949e; }

.post-title {
  color: #60a5fa;
  text-decoration: none;
  transition: 0.2s;
  cursor: pointer;
}

.post-title:hover {
  color: #93c5fd;
  text-decoration: underline;
  text-underline-offset: 4px;
}

.term-output-box {
  margin-top: 15px;
  padding: 15px;
  border-left: 3px solid #10b981;
  background: rgba(255, 255, 255, 0.03);
}

.term-tag {
  color: #f472b6;
  font-size: 0.85em;
  margin-right: 6px;
}

.typing-animation {
  display: inline-block;
  overflow: hidden;
  white-space: nowrap;
  animation: typing 2s steps(30, end);
}

.cursor {
  display: inline-block;
  width: 8px;
  height: 15px;
  background-color: #e5e7eb;
  margin-left: 2px;
  vertical-align: middle;
  animation: blink 1s step-end infinite;
}

@keyframes blink {
  0%, 100% { opacity: 1; }
  50% { opacity: 0; }
}

@keyframes typing {
  from { width: 0 }
  to { width: 100% }
}
</style>