<script setup lang="ts">

const emit = defineEmits(['close'])

const showEmail = (event: MouseEvent, email: string) => {
  event.stopPropagation()
  const oldTip = document.getElementById('email-tooltip')
  if (oldTip) oldTip.remove()
  
  let emailOverlay = null
  if (window.innerWidth <= 768) {
    emailOverlay = document.createElement('div')
    emailOverlay.id = 'email-pop-overlay'
    emailOverlay.style.cssText = 'position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.3);z-index:2147483646;backdrop-filter:blur(2px);'
  }
  
  const tip = document.createElement('div')
  tip.id = 'email-tooltip'
  tip.className = 'glass-card email-pop'
  tip.textContent = email
  
  if (window.innerWidth <= 768) {
    tip.style.left = '50%'
    tip.style.top = '50%'
    tip.style.transform = 'translate(-50%, -50%)'
  } else {
    tip.style.left = (event.clientX + 10) + 'px'
    tip.style.top = (event.clientY + 10) + 'px'
  }
  
  const container = document.getElementById('email-pop-container') || document.body
  if (emailOverlay) container.appendChild(emailOverlay)
  container.appendChild(tip)

  const closeTip = () => {
    tip.classList.add('fade-out')
    if (emailOverlay) {
      emailOverlay.style.opacity = '0'
      emailOverlay.style.transition = '0.3s'
    }
    setTimeout(() => {
      tip.remove()
      if (emailOverlay) emailOverlay.remove()
    }, 300)
    document.removeEventListener('click', closeTip)
  }
  setTimeout(() => document.addEventListener('click', closeTip), 10)
}
</script>

<template>
  <aside class="sidebar glass-card">
    <router-link to="/about">
      <img src="https://github.com/siiverash.png" alt="Avatar" class="avatar" title="Click! About me">
    </router-link>
    <h2>Silverash</h2>
    <div class="social-links">
      <a href="https://github.com/siiverash" target="_blank" title="GitHub"><i class="fab fa-github"></i></a>
      <a href="/feed.xml" target="_blank" title="RSS 订阅"><i class="fas fa-rss"></i></a>
      <a href="https://x.com/Wolfram1907" target="_blank"><i class="fab fa-twitter"></i></a>
      <a href="https://www.pixiv.net/users/55937658" target="_blank"><i class="fas fa-image"></i></a>
      <a style="cursor: pointer;" @click="showEmail($event, 'z1379523665@gmail.com')" title="Click to see Email">
        <i class="fas fa-envelope"></i>
      </a>
    </div>
    <nav class="nav-links">
      <router-link to="/" class="nav-item" @click="emit('close')"><i class="fas fa-home"></i> 首页</router-link>
      <router-link to="/categories/study" class="nav-item" @click="emit('close')"><i class="fas fa-terminal"></i> 学习笔记</router-link>
      <router-link to="/categories/anime" class="nav-item" @click="emit('close')"><i class="fas fa-clapperboard"></i> 动漫记录</router-link>
      <router-link to="/categories/music" class="nav-item" @click="emit('close')"><i class="fas fa-compact-disc"></i> 音乐鉴赏</router-link>
      <router-link to="/categories/paint" class="nav-item" @click="emit('close')"><i class="fas fa-pen-nib"></i> 胡乱涂鸦</router-link>
      <router-link to="/categories/game" class="nav-item" @click="emit('close')"><i class="fas fa-ghost"></i> 游戏荒野</router-link>
      <router-link to="/categories/snap" class="nav-item" @click="emit('close')"><i class="fas fa-camera"></i> 爱慕尼康</router-link>
      <router-link to="/categories/asmr" class="nav-item" @click="emit('close')"><i class="fas fa-moon"></i> 晚间陪睡</router-link>
      <router-link to="/categories/emo" class="nav-item" @click="emit('close')"><i class="fas fa-cloud-moon"></i> 深夜EMO</router-link>
    </nav>
    <div id="mobile-moved-content"></div>
  </aside>
</template>
