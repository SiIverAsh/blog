<template>
  <div class="about-container">
    <div style="text-align: center; margin-bottom: 30px;">
        <h1 style="color: #1d508a; margin-bottom: 10px;">About Me</h1>
    </div>

    <h2>🎓 教育背景</h2>
    <ul>
        <li><strong>学校专业</strong>: USST、Soft Engineering、Master's Degree</li>
        <li><strong>研究方向</strong>: LLM 、ASR etc.</li>
    </ul>

    <h2>💻 技术栈</h2>
    <ul>
        <li><strong>语言</strong>：Py、Cpp(studing)、 JAVA、 TS(Studing)、JS</li>
        <li><strong>核心领域</strong>：Fullstack、RealtimeASR、AI algorithms。(假如给我三天Vibe)</li>
    </ul>

    <h2>🎨 个人爱好</h2>
    <ul>
        <li><strong>二次元</strong>：看动漫（）。</li>
        <li><strong>绘画</strong>：苦手。</li>
        <li><strong>音乐</strong>：无忌口。（ASMR也算音乐么？！）</li>
        <li><strong>游戏</strong>：FPS、Gal、二次元手游等，无忌口。</li>
        <li><strong>摄影</strong>：I AM NIKON ！</li>
    </ul>

    <h2>📬 联系我</h2>
    <p>如果想与我聊聊、交朋友，欢迎通过侧边栏的社交链接联系我！</p>
  </div>
</template>

<style scoped>
.about-container {
    text-align: center;
}

.about-container h2 {
    display: inline-block; 
    text-align: left;
    width: 100%;
    max-width: 600px;
    border-left: 4px solid var(--primary-color); 
    padding-left: 15px; 
    color: #1d508a;
    margin-top: 30px;
}

.about-container ul {
    display: inline-block; 
    text-align: left; 
    max-width: 600px;
    width: 100%;
    padding-left: 20px; 
    margin: 0 auto;
    list-style-position: inside; 
}

.about-container li {
    line-height: 2; 
    color: var(--text-main);
    margin-bottom: 5px;
}

.about-container p {
    max-width: 600px;
    margin: 10px auto;
    text-align: left;
    color: var(--text-main);
}
</style>
