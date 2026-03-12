<script setup lang="ts">
import { ref, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'

const route = useRoute()
const router = useRouter()
const postId = route.params.id as string

interface PostDetail {
  id: string
  title: string
  date: string
  last_modified_at?: string
  categories: string[]
  tags: string[]
  content: string
  htmlContent: string
}

const post = ref<PostDetail | null>(null)
const loading = ref(true)

const fetchPost = async () => {
  try {
    const res = await fetch(`http://localhost:3000/api/posts/${postId}`)
    if (res.ok) {
      post.value = await res.json()
    } else {
      router.push('/')
    }
  } catch (e) {
    console.error("Error fetching post", e)
  }
  loading.value = false
}

// Watch for post content changes and apply syntax highlighting & terminal wrappers
watch(() => post.value, (newVal) => {
  if (newVal) {
    setTimeout(() => {
      initCodeBlocks()
      // Notify other components (like Sidebar) that post content is ready
      window.dispatchEvent(new CustomEvent('post-rendered'))
    }, 150) // Small delay to guarantee v-html has finished rendering and attached to DOM
  }
})

const formatDate = (dStr: string) => {
  if (!dStr) return ''
  const d = new Date(dStr)
  return `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')} ${String(d.getHours()).padStart(2, '0')}:${String(d.getMinutes()).padStart(2, '0')}`
}

const goBack = () => {
  router.back()
}

const initCodeBlocks = () => {
  document.querySelectorAll('.post-content pre').forEach((codeBlock) => {
    if (codeBlock.parentElement?.classList.contains('code-terminal-wrapper')) return

    const wrapper = document.createElement('div')
    wrapper.className = 'code-terminal-wrapper'

    const header = document.createElement('div')
    header.className = 'code-terminal-header'
    header.innerHTML = `
        <div class="terminal-buttons">
            <span class="btn close"></span>
            <span class="btn min"></span>
            <span class="btn max"></span>
        </div>
    `

    const button = document.createElement('button')
    button.className = 'copy-code-button'
    button.type = 'button'
    button.innerText = '复制'

    button.addEventListener('click', () => {
      const codeElement = codeBlock.querySelector('code')
      const code = codeElement ? codeElement.innerText : (codeBlock as HTMLElement).innerText
      navigator.clipboard.writeText(code).then(() => {
        button.innerText = '已复制!'
        setTimeout(() => { button.innerText = '复制' }, 2000)
      })
    })

    if (codeBlock.parentNode) {
      codeBlock.parentNode.insertBefore(wrapper, codeBlock)
      wrapper.appendChild(header)
      header.appendChild(button)
      wrapper.appendChild(codeBlock)
    }
  })
}

onMounted(() => {
  fetchPost()
})
</script>

<template>
  <div v-if="loading" style="text-align: center; padding: 50px;">加载中...</div>
  <article v-else-if="post">
    <header style="margin-bottom: 30px; text-align: center;">
      <h1 style="color: var(--primary-color); margin-bottom: 10px;">{{ post.title }}</h1>
      <div style="color: var(--text-muted); font-size: 0.9em; display: flex; justify-content: center; gap: 10px; flex-wrap: wrap;">
        <span title="发布时间"><i class="fas fa-calendar-day"></i> {{ formatDate(post.date) }}</span>
        <template v-if="post.last_modified_at && formatDate(post.date) !== formatDate(post.last_modified_at)">
          <span>|</span>
          <span title="最后更新时间"><i class="fas fa-clock"></i> {{ formatDate(post.last_modified_at) }}</span>
        </template>
        <span v-if="post.categories?.length > 0">
          <span>|</span>
          <i class="fas fa-folder-open"></i>
          <span v-for="(cat, index) in post.categories" :key="cat" style="color: var(--primary-color)">
             {{ cat }}<span v-if="index < post.categories.length - 1">, </span>
          </span>
        </span>
      </div>
      
      <div v-if="post.tags?.length > 0" style="margin-top: 15px;">
        <span v-for="tag in post.tags" :key="tag" class="post-tag"># {{ tag }}</span>
      </div>
      <span id="data-post-tags" style="display:none;">{{ post.tags?.join(',') }}</span>
    </header>

    <div class="post-content" v-html="post.htmlContent"></div>

    <footer style="margin-top: 50px; padding-top: 20px; border-top: 1px dashed rgba(0,0,0,0.1); text-align: center;">
      <a @click="goBack" style="color: var(--primary-color); text-decoration: none; font-weight: bold; cursor: pointer;">
        ← 返回列表
      </a>
    </footer>
  </article>
</template>

<style>
/* Unscoped styles required to style v-html content properly */
.post-tag {
  display: inline-block;
  background: rgba(127, 178, 216, 0.1);
  color: var(--primary-color);
  padding: 2px 10px;
  border-radius: 0;
  font-size: 0.8em;
  margin: 0 3px;
  border: 1px solid var(--glass-border);
}

.post-content { line-height: 1.8; color: var(--text-main); font-size: 1.1em; }
.post-content h2, .post-content h3 { color: var(--primary-color); margin-top: 35px; border-left: 4px solid var(--primary-color); padding-left: 15px; font-weight: 600; }
.post-content img { max-width: 90%; display: block; margin: 25px auto; border-radius: 0; box-shadow: var(--shadow); }
.post-content code { background: var(--code-bg); color: var(--primary-color); padding: 2px 6px; border-radius: 4px; font-family: 'Consolas', monospace; font-size: 0.9em; }

/* 覆盖掉原有的 pre 样式，因为现在外层有 wrapper 负责背景和圆角 */
.post-content pre { 
  background: transparent !important; 
  padding: 15px 20px; 
  border-radius: 0; 
  overflow-x: auto; 
  border: none !important;
  margin: 0;
  color: var(--text-main) !important;
}

/* 代码块终端风格外壳 */
.code-terminal-wrapper {
  position: relative;
  margin: 25px 0;
  border-radius: 8px; /* 圆角外壳 */
  background: var(--code-bg);
  border: 1px solid var(--glass-border);
  box-shadow: var(--shadow);
  overflow: hidden;
}

/* 终端顶部栏 */
.code-terminal-header {
  position: relative;
  background: rgba(0, 0, 0, 0.05);
  padding: 8px 15px;
  display: flex;
  align-items: center;
  border-bottom: none;
}

.dark-mode .code-terminal-header {
  background: rgba(255, 255, 255, 0.05);
}

.code-terminal-wrapper .terminal-buttons {
  display: flex;
  gap: 6px;
}

.code-terminal-wrapper .terminal-buttons .btn {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  display: inline-block;
}

.code-terminal-wrapper .btn.close { background-color: #ff5f56; }
.code-terminal-wrapper .btn.min { background-color: #ffbd2e; }
.code-terminal-wrapper .btn.max { background-color: #27c93f; }

.copy-code-button {
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid var(--glass-border);
  color: var(--text-muted);
  padding: 3px 10px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.75rem;
  transition: 0.3s;
  opacity: 0; 
  z-index: 10;
  font-weight: bold;
}

.code-terminal-wrapper:hover .copy-code-button { opacity: 1; }
.copy-code-button:hover { background: var(--primary-color); color: white; border-color: var(--primary-color); }
</style>
