<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { RouterView } from 'vue-router'
import Sidebar from './components/Sidebar.vue'
import ExtraSidebar from './components/ExtraSidebar.vue'
import Footer from './components/Footer.vue'

const isDarkMode = ref(false)
const isSidebarActive = ref(false)
const isExtraSidebarActive = ref(false)
const isSearchActive = ref(false)

const toggleTheme = () => {
  isDarkMode.value = !isDarkMode.value
  if (isDarkMode.value) {
    document.body.classList.add('dark-mode')
    localStorage.setItem('theme', 'dark')
  } else {
    document.body.classList.remove('dark-mode')
    localStorage.setItem('theme', 'light')
  }
}

const toggleSidebar = () => {
  isSidebarActive.value = !isSidebarActive.value
  isExtraSidebarActive.value = false
}

const toggleExtraSidebar = () => {
  isExtraSidebarActive.value = !isExtraSidebarActive.value
  isSidebarActive.value = false
}

const toggleSearch = () => {
  isSearchActive.value = !isSearchActive.value
}

const closeOverlays = () => {
  isSidebarActive.value = false
  isExtraSidebarActive.value = false
  isSearchActive.value = false
}

onMounted(() => {
  const savedTheme = localStorage.getItem('theme')
  const systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches
  if (savedTheme === 'dark' || (!savedTheme && systemPrefersDark)) {
    isDarkMode.value = true
    document.body.classList.add('dark-mode')
  }
})
</script>

<template>
  <button id="theme-toggle" title="Toggle Dark/Light Mode" @click="toggleTheme">
    <i :class="['fas', isDarkMode ? 'fa-moon' : 'fa-sun']"></i>
  </button>

  <button id="mobile-menu-toggle" title="Toggle Menu" @click="toggleSidebar">
    <i class="fas fa-bars"></i>
  </button>

  <button id="mobile-extra-toggle" title="Toggle Extra Info" @click="toggleExtraSidebar">
    <i class="fas fa-ellipsis-v"></i>
  </button>

  <button id="mobile-search-toggle" title="Search" @click="toggleSearch">
    <i class="fas fa-search"></i>
  </button>

  <div class="sidebar-overlay" :class="{ active: isSidebarActive || isExtraSidebarActive }" @click="closeOverlays"></div>
  
  <div id="mobile-search-overlay" class="search-overlay" :class="{ active: isSearchActive }" @click.self="closeOverlays">
    <div class="search-overlay-content">
      <div id="mobile-search-container"></div>
      <button id="close-search" class="close-search-btn" @click="closeOverlays"><i class="fas fa-times"></i></button>
    </div>
  </div>

  <div class="background"></div>
  
  <div class="wrapper">
    <Sidebar :class="{ active: isSidebarActive }" @close="closeOverlays" />

    <main class="main-content">
      <div class="content-card glass-card">
        <RouterView />
        <Footer />
      </div>
    </main>

    <ExtraSidebar :class="{ active: isExtraSidebarActive }" />
  </div>

  <div id="email-pop-container" style="position: relative; z-index: 2147483647;"></div>
</template>

<style scoped>
/* Scoped styles if needed, most are in main.css */
</style>
