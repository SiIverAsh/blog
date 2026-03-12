<script setup lang="ts">
import { ref, onMounted, onUnmounted, computed, watch } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

// 搜索逻辑
const searchQuery = ref('')
const searchResults = ref<{id: string, title: string, date: string, slug: string}[]>([])
let searchTimeout: number

const onSearchInput = () => {
  clearTimeout(searchTimeout)
  if (!searchQuery.value.trim()) {
    searchResults.value = []
    return
  }
  searchTimeout = window.setTimeout(async () => {
    try {
      const res = await fetch(`http://localhost:3000/api/posts/search?q=${encodeURIComponent(searchQuery.value)}`)
      if (res.ok) {
        searchResults.value = await res.json()
      }
    } catch (e) {
      console.error("Search failed", e)
    }
  }, 300)
}

const clearSearch = () => {
  searchQuery.value = ''
  searchResults.value = []
}

// 时钟逻辑
const timeStr = ref('00:00:00')
const dateStr = ref('')
const lunarStr = ref('')

let timer: number

const updateClock = () => {
  const now = new Date()
  timeStr.value = now.toLocaleTimeString('zh-CN', { hour12: false })
  dateStr.value = now.toLocaleDateString('zh-CN', { year: 'numeric', month: 'long', day: 'numeric', weekday: 'long' })
  try {
    const lunar = new Intl.DateTimeFormat('zh-u-ca-chinese', { day: 'numeric', month: 'long' }).format(now)
    lunarStr.value = "农历 " + lunar
  } catch(e) {}
}

const historyData = ref<{year: string, event: string}[]>([])
const animeWatching = ref<string[]>([])
const cvRecommend = ref<{name: string, agency: string, hometown: string, intro: string}>({
    name: '', agency: '', hometown: '', intro: ''
})
const musicData = ref<{circles: string[], genres: string[]}>({circles: [], genres: []})
const gameSpecs = ref<{cpu: string, gpu: string, ram: string, storage: string}>({cpu: '', gpu: '', ram: '', storage: ''})
const snapEquipment = ref<{camera: string, lens: string}>({camera: '', lens: ''})

const fetchData = async () => {
    try {
        const meRes = await fetch('http://localhost:3000/api/me')
        if (meRes.ok) {
            const me = await meRes.json()
            if(me.anime?.watching) animeWatching.value = me.anime.watching
            if(me.music) musicData.value = me.music
            if(me.game?.specs) gameSpecs.value = me.game.specs
            if(me.snap?.equipment) snapEquipment.value = me.snap.equipment
        }

        const recRes = await fetch('http://localhost:3000/api/recommendations')
        if (recRes.ok) {
            const rec = await recRes.json()
            if(rec.cv_recommend) cvRecommend.value = rec.cv_recommend
            if(rec.history) historyData.value = rec.history
        }
    } catch(e) {
        console.error("Failed to fetch data", e)
    }
}

onMounted(() => {
  updateClock()
  timer = window.setInterval(updateClock, 1000)
  fetchData()
  
  // 核心：监听来自 PostView 的渲染完成事件
  window.addEventListener('post-rendered', generateTOC)
})

onUnmounted(() => {
  clearInterval(timer)
  window.removeEventListener('post-rendered', generateTOC)
})

// 路由判断
const isHome = computed(() => route.path === '/' || route.path === '/index.html')
const isAnime = computed(() => route.path.includes('/categories/anime'))
const isMusic = computed(() => route.path.includes('/categories/music'))
const isGame = computed(() => route.path.includes('/categories/game'))
const isSnap = computed(() => route.path.includes('/categories/snap'))
const isPost = computed(() => route.path.startsWith('/post/'))

// TOC 目录生成核心逻辑
const tocItems = ref<{id: string, text: string, level: number}[]>([])

const generateTOC = () => {
  // 必须在 DOM 中寻找正文容器
  const content = document.querySelector('.post-content')
  if (!content) {
    tocItems.value = []
    return
  }
  
  const headings = content.querySelectorAll('h2, h3, h4')
  const items: {id: string, text: string, level: number}[] = []
  
  headings.forEach((heading, index) => {
    // 确保每个标题都有 ID，用于锚点跳转
    if (!heading.id) {
      heading.id = 'heading-' + index
    }
    items.push({
      id: heading.id,
      text: heading.textContent || '',
      level: parseInt(heading.tagName.substring(1))
    })
  })
  
  tocItems.value = items
}

// 监听路由变化，清空或尝试生成目录
watch(() => route.path, () => {
  if (isPost.value) {
    tocItems.value = []
    setTimeout(generateTOC, 600)
  } else {
    tocItems.value = []
  }
}, { immediate: true })

</script>

<template>
  <aside class="extra-sidebar">
    <!-- 搜索框 -->
    <div class="extra-box glass-card search-box-card">
      <div class="extra-title"><i class="fas fa-search"></i> 全站搜索</div>
      <div class="search-wrapper" style="position: relative;">
        <input type="text" id="search-input" v-model="searchQuery" @input="onSearchInput" placeholder="少女搜索中...">
        <ul v-if="searchResults.length > 0" class="search-results-dropdown">
          <li v-for="res in searchResults" :key="res.id">
            <router-link :to="'/post/' + res.slug" @click="clearSearch" style="color: var(--text-main); text-decoration: none;">
              {{ res.title }}
            </router-link>
          </li>
        </ul>
      </div>
    </div>

    <!-- 时钟 -->
    <div class="extra-box glass-card clock-box">
      <div id="clock-time">{{ timeStr }}</div>
      <div id="clock-date">{{ dateStr }}</div>
      <div id="clock-lunar">{{ lunarStr }}</div>
    </div>

    <!-- 文章目录 (TOC) - 仅在文章页显示 -->
    <div v-if="isPost && tocItems.length > 0" class="extra-box glass-card toc-card">
      <div class="extra-title"><i class="fas fa-list-ul"></i> 文章目录</div>
      <div class="toc-container">
        <ul class="toc-list">
          <li v-for="item in tocItems" :key="item.id" :style="{ marginLeft: (item.level - 2) * 15 + 'px' }">
            <a :href="'#' + item.id" class="toc-link">{{ item.text }}</a>
          </li>
        </ul>
      </div>
    </div>

    <!-- 首页内容：历史上的今天 -->
    <div v-if="isHome" class="extra-box glass-card">
      <div class="extra-title"><i class="fas fa-history"></i> 历史上的今天</div>
      <div class="history-content">
        <div v-for="item in historyData" :key="item.year" class="history-item">
          <span class="history-year">{{ item.year }}</span>
          <div class="history-event">{{ item.event }}</div>
        </div>
      </div>
    </div>

    <!-- 动漫分类页：追番 -->
    <div v-if="isAnime" class="extra-box glass-card">
      <div class="extra-title"><i class="fas fa-play-circle"></i> 正在追番 (Watching)</div>
      <ul class="watching-list">
        <li v-for="item in animeWatching" :key="item">{{ item }}</li>
      </ul>
    </div>

    <!-- 音乐分类页：社团 -->
    <div v-if="isMusic" class="extra-box glass-card">
      <div class="extra-title"><i class="fas fa-compact-disc"></i> 关注社团 (Circle)</div>
      <div class="tag-flex">
        <span v-for="item in musicData.circles" :key="item" class="circle-tag">{{ item }}</span>
      </div>
      <div class="extra-title" style="margin-top: 25px;"><i class="fas fa-headphones-simple"></i> 曲风偏好 (Genre)</div>
      <div class="genre-list">
        <span v-for="item in musicData.genres" :key="item" class="genre-item">
          <i class="fas fa-hashtag"></i> {{ item }}
        </span>
      </div>
    </div>

    <!-- 游戏分类页：配置 -->
    <div v-if="isGame" class="extra-box glass-card">
      <div class="extra-title"><i class="fas fa-tower-pc"></i> 系统配置 (Specs)</div>
      <div class="specs-list">
        <div>
          <div class="spec-label cpu"><i class="fas fa-microchip"></i> CPU</div>
          <div class="spec-value">{{ gameSpecs.cpu }}</div>
        </div>
        <div>
          <div class="spec-label gpu"><i class="fas fa-video"></i> GPU</div>
          <div class="spec-value">{{ gameSpecs.gpu }}</div>
        </div>
        <div>
          <div class="spec-label ram"><i class="fas fa-memory"></i> RAM</div>
          <div class="spec-value">{{ gameSpecs.ram }}</div>
        </div>
        <div>
          <div class="spec-label storage"><i class="fas fa-hard-drive"></i> Storage</div>
          <div class="spec-value">{{ gameSpecs.storage }}</div>
        </div>
      </div>
    </div>

    <!-- Snap分类页：装备 -->
    <div v-if="isSnap" class="extra-box glass-card">
      <div class="extra-title"><i class="fas fa-camera-retro"></i> 装备 (Equipment)</div>
      <div class="specs-list">
        <div>
          <div class="spec-label cpu"><i class="fas fa-camera"></i> Camera</div>
          <div class="spec-value">{{ snapEquipment.camera }}</div>
        </div>
        <div>
          <div class="spec-label gpu"><i class="fas fa-dot-circle"></i> Lens</div>
          <div class="spec-value">{{ snapEquipment.lens }}</div>
        </div>
      </div>
    </div>

    <!-- 动漫分类页：声优推荐 -->
    <div v-if="isAnime" class="extra-box glass-card">
      <div class="extra-title"><i class="fas fa-microphone-lines"></i> 声优名鉴 · 每日推荐</div>
      <div>
        <h4 class="cv-name">{{ cvRecommend.name }}</h4>
        <div class="cv-meta">
          <span>🏢 {{ cvRecommend.agency }}</span>
          <span>📍 {{ cvRecommend.hometown }}</span>
        </div>
        <p class="cv-intro">{{ cvRecommend.intro }}</p>
        <a :href="'https://zh.moegirl.org.cn/' + encodeURIComponent(cvRecommend.name)" target="_blank" class="moe-btn">查看萌娘百科 📖</a>
      </div>
    </div>
  </aside>
</template>

<style scoped>
.clock-box {
  text-align: center;
}
#clock-time {
  font-size: 2.2em;
  font-weight: bold;
  color: var(--primary-color);
  font-family: 'Courier New', monospace;
  letter-spacing: 2px;
}
#clock-date {
  font-size: 0.9em;
  color: var(--text-muted);
  margin-top: 8px;
}
#clock-lunar {
  font-size: 0.85em;
  color: var(--primary-color);
  margin-top: 5px;
  font-weight: bold;
}

.history-content {
  max-height: 350px;
  overflow-y: auto;
  color: var(--text-main);
  font-size: 0.85em;
  line-height: 1.6;
}
.history-item {
  margin-bottom: 18px;
}
.history-year {
  color: var(--primary-color);
  font-weight: bold;
  display: inline-block;
  margin-bottom: 6px;
}
.history-event {
  margin-top: 2px;
}

.watching-list {
  list-style: none;
  padding: 0;
  margin: 0;
  font-size: 0.85em;
  color: var(--text-main);
}
.watching-list li {
  margin-bottom: 10px;
  border-left: 3px solid #f09199;
  padding-left: 12px;
}

.tag-flex {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}
.circle-tag {
  background: rgba(74, 144, 226, 0.1);
  color: #4a90e2;
  padding: 4px 10px;
  font-size: 0.75em;
  border: 1px solid rgba(74, 144, 226, 0.2);
}
.genre-list {
  font-size: 0.85em;
  color: var(--text-main);
  line-height: 1.8;
}
.genre-item {
  margin-right: 12px;
}
.genre-item i {
  font-size: 0.8em;
  color: var(--text-muted);
}

.specs-list {
  font-size: 0.85em;
  color: var(--text-main);
}
.specs-list > div {
  margin-bottom: 12px;
}
.spec-label {
  font-weight: bold;
  margin-bottom: 4px;
}
.spec-value {
  padding-left: 5px;
}
.spec-label.cpu { color: var(--primary-color); }
.spec-label.gpu { color: #f09199; }
.spec-label.ram { color: var(--text-muted); }
.spec-label.storage { color: var(--primary-color); }

.cv-name {
  color: var(--primary-color);
  margin: 0 0 8px 0;
}
.cv-meta {
  font-size: 0.75em;
  color: var(--text-muted);
  margin-bottom: 10px;
  display: flex;
  gap: 10px;
}
.cv-intro {
  font-size: 0.85em;
  color: var(--text-main);
  line-height: 1.5;
  border-top: 1px dashed var(--glass-border);
  padding-top: 10px;
  margin-bottom: 12px;
}
.moe-btn {
  display: inline-block;
  background: var(--primary-color);
  color: white !important;
  padding: 6px 12px;
  text-decoration: none;
  font-size: 0.8em;
  font-weight: bold;
  transition: 0.3s;
}
.moe-btn:hover {
  filter: brightness(1.1);
  transform: scale(1.05);
}

.history-content::-webkit-scrollbar {
  width: 4px;
}
.history-content::-webkit-scrollbar-thumb {
  background: var(--primary-color);
  opacity: 0.3;
}

#search-input {
  width: 100%;
  padding: 12px 20px;
  border-radius: 0;
  border: 1px solid var(--glass-border);
  background: rgba(255, 255, 255, 0.2);
  color: var(--text-main);
  outline: none;
  box-sizing: border-box;
  font-size: 0.9em;
  transition: 0.3s;
}

.dark-mode #search-input {
  background: rgba(0, 0, 0, 0.3) !important;
  color: white !important;
}

.search-results-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  width: 100%;
  list-style: none;
  padding: 10px 0;
  margin-top: 12px;
  max-height: 350px;
  overflow-y: auto;
  z-index: 2147483647 !important;
  background: var(--glass-bg, rgba(255, 255, 255, 0.85));
  backdrop-filter: blur(20px) saturate(180%);
  -webkit-backdrop-filter: blur(20px) saturate(180%);
  border-radius: 0;
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
  border: 1px solid var(--glass-border);
}

.search-results-dropdown li {
  padding: 0;
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.dark-mode .search-results-dropdown li {
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

.search-results-dropdown li a {
  display: block;
  font-size: 0.95em;
  padding: 12px 20px;
  transition: background 0.2s, color 0.2s;
}

.search-results-dropdown li a:hover {
  background: rgba(29, 80, 138, 0.1);
  color: var(--primary-color) !important;
}

.search-results-dropdown::-webkit-scrollbar {
  width: 6px;
}

.search-results-dropdown::-webkit-scrollbar-track {
  background: transparent;
}

.search-results-dropdown::-webkit-scrollbar-thumb {
  background: rgba(0, 0, 0, 0.1);
  border-radius: 0;
}

.dark-mode .search-results-dropdown::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.1);
}

.search-results-dropdown:hover::-webkit-scrollbar-thumb {
  background: rgba(0, 0, 0, 0.2);
}

.dark-mode .search-results-dropdown:hover::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.2);
}

/* TOC 目录样式 */
.toc-card {
  max-height: 500px;
  display: flex;
  flex-direction: column;
}

.toc-container {
  overflow-y: auto;
  padding-right: 5px;
  margin-top: 15px;
}

.toc-list {
  list-style: none;
  padding: 0;
  margin: 0;
  font-size: 0.9em;
}

.toc-link {
  color: var(--text-main);
  text-decoration: none;
  display: block;
  border-left: 2px solid transparent;
  padding: 5px 8px;
  transition: 0.3s;
  line-height: 1.4;
  font-size: 0.95em;
}

.toc-link:hover {
  color: var(--primary-color) !important;
  border-left: 2px solid var(--primary-color) !important;
  background: rgba(127, 178, 216, 0.1);
}

.extra-title {
  margin-bottom: 18px;
  font-weight: bold;
  color: var(--primary-color);
  display: flex;
  align-items: center;
  gap: 8px;
}

.extra-box {
  margin-bottom: 35px;
}
</style>
