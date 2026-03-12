<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

const category = computed(() => route.params.category as string)

const categoryTitleMap: Record<string, string> = {
  anime: 'Anime 🌸',
  asmr: 'ASMR 🎧',
  emo: '深夜 EMO ☁️🌙',
  game: 'Game 🎮',
  music: 'Music 🎵',
  paint: 'Paint 🎨',
  snap: 'Snap 📸',
  study: 'Study 📚'
}

const pageTitle = computed(() => categoryTitleMap[category.value] || category.value)

interface Post {
  id: string
  title: string
  date: string
  categories: string[]
  tags: string[]
  excerpt: string
}

const allPosts = ref<Post[]>([])
const loading = ref(true)

// Filters
const activeYear = ref('all')
const activeTags = ref<string[]>([])
const isYearOptionsOpen = ref(false)
const isMoreTagsOpen = ref(false)

const years = computed(() => {
  const y = new Set<string>()
  allPosts.value.forEach(p => {
    if (p.date) {
      y.add(new Date(p.date).getFullYear().toString())
    }
  })
  return Array.from(y).sort().reverse()
})

const allSortedTags = computed(() => {
  const counts: Record<string, number> = {}
  allPosts.value.forEach(p => {
    (p.tags || []).forEach(t => {
      counts[t] = (counts[t] || 0) + 1
    })
  })
  return Object.keys(counts).map(name => ({
    name, count: counts[name] || 0
  })).sort((a, b) => b.count - a.count || a.name.localeCompare(b.name))
})

const hotTags = computed(() => allSortedTags.value.slice(0, 10))
const remainingTags = computed(() => allSortedTags.value.slice(10))

const currentTagPage = ref(1)
const tagsPerTagPage = 12
const totalTagPages = computed(() => Math.ceil(remainingTags.value.length / tagsPerTagPage))
const pagedRemainingTags = computed(() => {
  const start = (currentTagPage.value - 1) * tagsPerTagPage
  return remainingTags.value.slice(start, start + tagsPerTagPage)
})

const changeTagPage = (delta: number) => {
  const newPage = currentTagPage.value + delta
  if (newPage >= 1 && newPage <= totalTagPages.value) {
    currentTagPage.value = newPage
  }
}

const selectYear = (y: string) => {
  activeYear.value = y
  isYearOptionsOpen.value = false
  currentPage.value = 1
}

const selectTag = (t: string) => {
  if (t === 'all') {
    activeTags.value = []
  } else {
    const idx = activeTags.value.indexOf(t)
    if (idx > -1) activeTags.value.splice(idx, 1)
    else activeTags.value.push(t)
  }
  currentPage.value = 1
}

const filteredPosts = computed(() => {
  return allPosts.value.filter(p => {
    const pYear = p.date ? new Date(p.date).getFullYear().toString() : ''
    const matchesYear = activeYear.value === 'all' || pYear === activeYear.value
    
    const pTags = p.tags || []
    const matchesTag = activeTags.value.length === 0 || activeTags.value.every(t => pTags.includes(t))
    
    return matchesYear && matchesTag
  })
})

// Pagination
const itemsPerPage = 8
const currentPage = ref(1)
const totalPages = computed(() => Math.ceil(filteredPosts.value.length / itemsPerPage))
const pagedPosts = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage
  return filteredPosts.value.slice(start, start + itemsPerPage)
})

const changePage = (delta: number) => {
  const newPage = currentPage.value + delta
  if (newPage >= 1 && newPage <= totalPages.value) {
    currentPage.value = newPage
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }
}

const fetchPosts = async () => {
  loading.value = true
  try {
    const res = await fetch(`http://localhost:3000/api/posts?category=${category.value}`)
    if (res.ok) {
      allPosts.value = await res.json()
    }
  } catch (e) {
    console.error(e)
  }
  loading.value = false
}

const formatDate = (d: string) => {
  if (!d) return ''
  const date = new Date(d)
  return `${date.getFullYear()}-${String(date.getMonth()+1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`
}

watch(category, () => {
  activeYear.value = 'all'
  activeTags.value = []
  currentPage.value = 1
  fetchPosts()
})

onMounted(() => {
  fetchPosts()
  
  document.addEventListener('click', (e: Event) => {
    const target = e.target as HTMLElement
    if (!target.closest('#year-custom-select')) {
      isYearOptionsOpen.value = false
    }
    if (!target.closest('#more-tags-wrapper')) {
      isMoreTagsOpen.value = false
    }
  })
})

const toggleYearOptions = () => {
    isYearOptionsOpen.value = !isYearOptionsOpen.value
    isMoreTagsOpen.value = false
}

const toggleMoreTags = () => {
    isMoreTagsOpen.value = !isMoreTagsOpen.value
    isYearOptionsOpen.value = false
}
</script>

<template>
  <div v-if="loading" style="text-align: center; padding: 50px;">加载中...</div>
  <div v-else>
    <div style="margin-bottom: 20px;">
        <h2 style="margin:0 0 15px 0; color: #1d508a; border-bottom: 2px solid var(--primary-color); display: inline-block; padding-bottom: 5px;">
            {{ pageTitle }}
        </h2>
        
        <div class="filter-wrapper">
            <div class="year-filter-box">
                <span class="filter-label">年份:</span>
                <div class="custom-select" id="year-custom-select" :class="{ open: isYearOptionsOpen }">
                    <div class="select-trigger" @click.stop="toggleYearOptions">
                        <span id="selected-year-text">{{ activeYear === 'all' ? '全部年份' : activeYear + '年' }}</span>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="custom-options-container" id="year-options">
                        <div class="custom-option" :class="{ active: activeYear === 'all' }" @click="selectYear('all')">全部年份</div>
                        <div v-for="y in years" :key="y" class="custom-option" :class="{ active: activeYear === y }" @click="selectYear(y)">
                            {{ y }}年
                        </div>
                    </div>
                </div>
            </div>

            <div id="tag-pills-container" class="tag-pills-container">
                <span class="tag-pill" :class="{ active: activeTags.length === 0 }" @click="selectTag('all')">全部标签</span>
                <div id="hot-tags-area" style="display: flex; flex-wrap: wrap; gap: 8px;">
                    <span v-for="t in hotTags" :key="t.name" class="tag-pill" :class="{ active: activeTags.includes(t.name) }" @click="selectTag(t.name)">
                        {{ t.name }} <small style="opacity:0.5; font-size:0.8em;">{{ t.count }}</small>
                    </span>
                </div>
                
                <div class="more-tags-wrapper" id="more-tags-wrapper" :class="{ open: isMoreTagsOpen }" v-if="remainingTags.length > 0">
                    <div class="more-btn" id="more-tags-btn" @click.stop="toggleMoreTags">
                        <span>更多标签</span>
                        <i class="fas fa-plus" style="font-size: 0.8em; margin-left: 5px;"></i>
                    </div>
                    <div class="more-tags-dropdown" id="more-tags-dropdown" @click.stop>
                        <div id="dropdown-tags-grid" class="dropdown-tags-grid">
                            <span v-for="t in pagedRemainingTags" :key="t.name" class="tag-pill" :class="{ active: activeTags.includes(t.name) }" @click="selectTag(t.name)">
                                {{ t.name }} <small style="opacity:0.5; font-size:0.8em;">{{ t.count }}</small>
                            </span>
                        </div>
                        <div class="dropdown-pagination">
                            <button @click="changeTagPage(-1)" :disabled="currentTagPage === 1" class="tag-nav-btn"><i class="fas fa-chevron-left"></i></button>
                            <span id="tag-page-info">{{ currentTagPage }}/{{ totalTagPages }}</span>
                            <button @click="changeTagPage(1)" :disabled="currentTagPage === totalTagPages" class="tag-nav-btn"><i class="fas fa-chevron-right"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="post-list" style="margin-top: 30px;">
        <div v-for="(post, index) in pagedPosts" :key="post.id" class="post-item" style="animation: fadeInUp 0.4s ease forwards;">
            <router-link :to="'/post/' + post.slug" style="text-decoration: none; display: block; margin-bottom: 25px;">
                <div class="post-preview-card terminal-style-card">
                    <div class="card-terminal-header">
                        <div class="terminal-buttons">
                            <span class="btn close"></span>
                            <span class="btn min"></span>
                            <span class="btn max"></span>
                        </div>
                    </div>
                    <div class="post-number-side">#{{ String(filteredPosts.length - ((currentPage - 1) * itemsPerPage + index)).padStart(3, '0') }}</div>
                    <div class="post-card-content">
                        <div style="display: flex; justify-content: space-between; align-items: flex-start; gap: 10px;">
                            <h3 class="post-title">{{ post.title }}</h3>
                            <span style="font-size: 0.85em; color: var(--text-muted); white-space: nowrap;">{{ formatDate(post.date) }}</span>
                        </div>
                        <div v-if="post.tags && post.tags.length > 0" style="margin-top: 10px;">
                            <span v-for="tag in post.tags" :key="tag" class="mini-post-tag"># {{ tag }}</span>
                        </div>
                        <p class="post-excerpt">
                            {{ post.excerpt }}
                        </p>
                    </div>
                </div>
            </router-link>
        </div>
        <div v-if="filteredPosts.length === 0" style="text-align: center; padding: 40px; color: var(--text-muted);">
            没有找到相关文章
        </div>
    </div>

    <div v-if="totalPages > 1" id="pagination-controls" style="text-align: center; margin-top: 40px; display: flex; justify-content: center; gap: 10px;">
        <button @click="changePage(-1)" class="page-btn" :disabled="currentPage === 1">上一页</button>
        <span id="page-info" style="color: #888; align-self: center;">第 {{ currentPage }} 页 / 共 {{ totalPages }} 页</span>
        <button @click="changePage(1)" class="page-btn" :disabled="currentPage === totalPages">下一页</button>
    </div>
  </div>
</template>

<style scoped>
@keyframes fadeInUp {
    from { opacity: 0; transform: translateY(15px); }
    to { opacity: 1; transform: translateY(0); }
}

.filter-wrapper { 
    display: flex; 
    flex-direction: column; 
    gap: 15px; 
    background: var(--glass-bg); 
    padding: 18px; 
    border-radius: 0; 
    border: 1px solid var(--glass-border); 
    box-shadow: var(--shadow);
}

.year-filter-box { display: flex; align-items: center; gap: 12px; }

.custom-select {
    position: relative;
    min-width: 140px;
    user-select: none;
}

.select-trigger {
    background: rgba(255, 255, 255, 0.1);
    border: 1px solid var(--glass-border);
    padding: 8px 15px;
    border-radius: 0;
    cursor: pointer;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: var(--text-main);
    font-size: 0.9em;
    transition: 0.3s;
}

.select-trigger:hover {
    background: rgba(255, 255, 255, 0.2);
    border-color: var(--primary-color);
}

.custom-options-container {
    position: absolute;
    top: calc(100% + 8px);
    left: 0;
    width: 100%;
    background: var(--glass-bg);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    border: 1px solid var(--glass-border);
    border-radius: 0; 
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    z-index: 1000;
    display: none;
    overflow: hidden;
    animation: fadeInDown 0.3s ease;
}

@keyframes fadeInDown {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}

.custom-select.open .custom-options-container {
    display: block;
}

.custom-select.open .select-trigger i {
    transform: rotate(180deg);
}

.select-trigger i {
    transition: transform 0.3s;
    font-size: 0.8em;
    color: var(--primary-color);
}

.custom-option {
    padding: 10px 15px;
    cursor: pointer;
    font-size: 0.9em;
    color: var(--text-main);
    transition: 0.2s;
}

.custom-option:hover {
    background: rgba(29, 80, 138, 0.1);
    color: var(--primary-color);
}

.custom-option.active {
    background: var(--primary-color);
    color: white;
}

.tag-pills-container { 
    display: flex; 
    flex-wrap: wrap; 
    gap: 8px; 
    padding: 15px 5px 5px 0;
    border-top: 1px dashed var(--glass-border);
    align-items: center;
}

/* 更多标签包装器 */
.more-tags-wrapper {
    position: relative;
    display: inline-block;
}

.more-btn {
    display: flex;
    align-items: center;
    padding: 5px 15px;
    background: rgba(127, 178, 216, 0.1);
    color: var(--primary-color);
    border-radius: 0;
    font-size: 0.85em;
    cursor: pointer;
    transition: 0.3s;
    border: 1.5px solid var(--primary-color);
    font-weight: bold;
}

.more-btn:hover {
    background: var(--primary-color);
    color: white;
    transform: scale(1.05);
}

/* 下拉框样式 */
.more-tags-dropdown {
    position: absolute;
    top: calc(100% + 12px);
    right: 0;
    width: 320px;
    background: var(--glass-bg);
    backdrop-filter: blur(25px) saturate(180%);
    -webkit-backdrop-filter: blur(25px) saturate(180%);
    border: 1px solid var(--glass-border);
    border-radius: 0;
    box-shadow: 0 15px 45px rgba(0,0,0,0.25);
    z-index: 1000;
    padding: 15px;
    display: none;
    flex-direction: column;
    gap: 15px;
    animation: fadeInDown 0.3s ease;
}

.more-tags-wrapper.open .more-tags-dropdown {
    display: flex;
}

.dropdown-tags-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    min-height: 100px;
    align-content: flex-start;
}

.dropdown-pagination {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 12px;
    border-top: 1px solid var(--glass-border);
}

.tag-nav-btn {
    background: none;
    border: 1px solid var(--glass-border);
    color: var(--primary-color);
    width: 30px;
    height: 30px;
    border-radius: 0;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: 0.3s;
}

.tag-nav-btn:hover:not(:disabled) {
    background: var(--primary-color);
    color: white;
}

.tag-nav-btn:disabled {
    opacity: 0.3;
    cursor: not-allowed;
}

#tag-page-info {
    font-size: 0.85em;
    color: var(--text-muted);
    font-weight: bold;
}

.tag-pill {
    display: inline-block;
    padding: 5px 15px;
    background: rgba(127, 178, 216, 0.1);
    color: var(--text-muted);
    border-radius: 0;
    font-size: 0.85em;
    cursor: pointer;
    transition: 0.3s;
    border: 1px solid rgba(29, 80, 138, 0.1);
    white-space: nowrap;
}

.tag-pill:hover { background: rgba(127, 178, 216, 0.2); color: var(--primary-color); transform: scale(1.05); }
.tag-pill.active { 
    background: var(--primary-color); 
    color: white !important; 
    font-weight: bold;
    box-shadow: 0 4px 12px rgba(29, 80, 138, 0.3);
    border-color: transparent;
}

.tag-pills-container::-webkit-scrollbar { width: 4px; }
.tag-pills-container::-webkit-scrollbar-thumb { background: var(--primary-color); opacity: 0.3; border-radius: 0; }

.post-preview-card { 
    position: relative; 
    overflow: hidden; 
    background: var(--glass-bg); 
    padding: 25px 25px 25px 60px; 
    border-radius: 0; 
    border: 1px solid var(--glass-border); 
    transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1); 
    box-shadow: var(--shadow); 
}
.post-preview-card:hover { transform: translateY(-8px); box-shadow: 0 15px 45px rgba(0,0,0,0.1); }

.post-title { margin: 0; flex: 1; color: var(--primary-color) !important; font-weight: bold; }
.post-excerpt { margin: 12px 0 0; font-size: 0.95em; line-height: 1.6; color: var(--text-main); opacity: 0.85; }

.post-number-side { 
    position: absolute; 
    left: 15px; top: 50%; 
    transform: translateY(-50%); 
    font-size: 2em; font-weight: 900; 
    color: var(--primary-color); opacity: 0.15; 
    pointer-events: none; writing-mode: vertical-lr; 
    letter-spacing: 2px; font-style: italic;
}

.mini-post-tag { display: inline-block; background: rgba(127, 178, 216, 0.15); color: var(--primary-color); padding: 2px 10px; border-radius: 0; font-size: 0.75em; margin-right: 8px; font-weight: bold; }
.page-btn { background: var(--glass-bg); border: 1px solid var(--primary-color); color: var(--primary-color); padding: 6px 20px; border-radius: 0; cursor: pointer; transition: 0.3s; font-weight: bold; }
.page-btn:hover:not(:disabled) { background: var(--primary-color); color: white; }
.page-btn:disabled { opacity: 0.5; cursor: not-allowed; }

@media (max-width: 768px) {
    .post-preview-card { padding: 35px 20px 20px 50px; }
    .post-number-side { font-size: 1.5em; left: 10px; }
}

/* Terminal Dots for Post Cards */
.terminal-style-card {
    padding-top: 35px !important;
    position: relative;
}

.card-terminal-header {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 25px;
    background: rgba(0, 0, 0, 0.2);
    display: flex;
    align-items: center;
    padding-left: 10px;
    border-bottom: 1px solid var(--glass-border);
}

.terminal-buttons {
    display: flex;
    gap: 6px;
}

.terminal-buttons .btn {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    display: inline-block;
}

.btn.close { background-color: #ff5f56; }
.btn.min { background-color: #ffbd2e; }
.btn.max { background-color: #27c93f; }
</style>