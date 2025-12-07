# 批量为HTML文件添加侧边栏功能的PowerShell脚本

# 需要处理的HTML文件列表
$htmlFiles = @(
    "community.html",
    "components.html",
    "contact.html",
    "docs.html",
    "ecosystem.html",
    "models.html",
    "news.html",
    "partners.html"
)

# 侧边栏HTML内容
$sidebarHtml = @'
    <!-- 侧边栏切换按钮 -->
    <button class="sidebar-toggle" id="sidebar-toggle">
        <i class="fas fa-bars"></i>
    </button>
    
    <!-- 侧边栏 -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <h3>快速导航</h3>
        </div>
        <ul class="sidebar-nav">
            <li><a href="index.html"><i class="fas fa-home"></i> 首页</a></li>
            <li><a href="about.html"><i class="fas fa-info-circle"></i> 关于 FlagOS</a></li>
            <li><a href="components.html"><i class="fas fa-cubes"></i> 核心组件</a></li>
            <li><a href="ecosystem.html"><i class="fas fa-network-wired"></i> 扩展生态</a></li>
            <li><a href="docs.html"><i class="fas fa-book"></i> 文档中心</a></li>
            <li><a href="models.html"><i class="fas fa-brain"></i> 模型仓库</a></li>
            <li><a href="community.html"><i class="fas fa-users"></i> 社区中心</a></li>
            <li><a href="partners.html"><i class="fas fa-handshake"></i> 合作伙伴</a></li>
            <li><a href="news.html"><i class="fas fa-newspaper"></i> 新闻动态</a></li>
            <li><a href="contact.html"><i class="fas fa-envelope"></i> 联系我们</a></li>
        </ul>
    </aside>
'@

foreach ($file in $htmlFiles) {
    if (Test-Path $file) {
        Write-Host "正在处理文件: $file"
        
        $content = Get-Content $file -Raw
        
        # 添加侧边栏HTML结构
        $newMainContent = $sidebarHtml + "`n    <main class=""main-content"">"
        $content = $content -replace '<main class="main-content">', $newMainContent
        
        # 保存修改后的内容
        Set-Content $file $content -Encoding UTF8
        Write-Host "已成功为 $file 添加侧边栏HTML结构"
    } else {
        Write-Host "文件不存在: $file"
    }
}

Write-Host "所有文件的侧边栏HTML结构添加完成！"