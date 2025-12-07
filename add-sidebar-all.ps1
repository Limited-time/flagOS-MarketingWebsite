# PowerShell script to add sidebar to all HTML pages

# Define the sidebar HTML structure
$sidebarHtml = @"
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
"@

# Define the sidebar toggle script
$sidebarScript = @"
        // 侧边栏切换功能
        const sidebarToggle = document.getElementById('sidebar-toggle');
        const sidebar = document.getElementById('sidebar');
        
        // 检查本地存储中的侧边栏状态
        if (localStorage.getItem('sidebar') === 'expanded' || 
            (!localStorage.getItem('sidebar') && window.innerWidth > 1024)) {
            document.body.classList.add('sidebar-expanded');
        } else {
            document.body.classList.add('sidebar-collapsed');
        }
        
        // 切换侧边栏
        sidebarToggle.addEventListener('click', () => {
            document.body.classList.toggle('sidebar-expanded');
            document.body.classList.toggle('sidebar-collapsed');
            
            // 保存侧边栏状态到本地存储
            if (document.body.classList.contains('sidebar-expanded')) {
                localStorage.setItem('sidebar', 'expanded');
            } else {
                localStorage.setItem('sidebar', 'collapsed');
            }
        });
        
        // 根据当前页面设置侧边栏激活状态
        const currentPage = window.location.pathname.split('/').pop() || 'index.html';
        const sidebarLinks = document.querySelectorAll('.sidebar-nav li a');
        
        sidebarLinks.forEach(link => {
            const linkPage = link.getAttribute('href');
            if (linkPage === currentPage) {
                link.classList.add('active');
            }
        });
"@

# Get all HTML files except those already having sidebar
$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -File | Where-Object {$_.Name -notin @("about.html", "index.html", "template.html")}

# Process each file
foreach ($file in $htmlFiles) {
    Write-Output "Processing $($file.Name)..."
    
    # Read file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Add sidebar HTML after nav tag
    $updatedContent = $content -replace "    </nav>\r?\n\r?\n    <!-- 主要内容区域 -->", "    </nav>\r\n$sidebarHtml\r\n    <!-- 主要内容区域 -->"
    
    # Add sidebar script before closing body tag
    $updatedContent = $updatedContent -replace "    </script>\r?\n</body>", "    $sidebarScript\r\n    </script>\r\n</body>"
    
    # Save updated content
    Set-Content -Path $file.FullName -Value $updatedContent -Encoding UTF8
    
    Write-Output "Added sidebar to $($file.Name)"
}

Write-Output "All files processed successfully!"