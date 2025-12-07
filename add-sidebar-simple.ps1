# Simple PowerShell script to add sidebar HTML to HTML files

# HTML files to process
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

# Sidebar HTML content
$sidebarHtml = @'
    <!-- Sidebar toggle button -->
    <button class="sidebar-toggle" id="sidebar-toggle">
        <i class="fas fa-bars"></i>
    </button>
    
    <!-- Sidebar -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <h3>Quick Navigation</h3>
        </div>
        <ul class="sidebar-nav">
            <li><a href="index.html"><i class="fas fa-home"></i> Home</a></li>
            <li><a href="about.html"><i class="fas fa-info-circle"></i> About FlagOS</a></li>
            <li><a href="components.html"><i class="fas fa-cubes"></i> Core Components</a></li>
            <li><a href="ecosystem.html"><i class="fas fa-network-wired"></i> Ecosystem</a></li>
            <li><a href="docs.html"><i class="fas fa-book"></i> Documentation</a></li>
            <li><a href="models.html"><i class="fas fa-brain"></i> Model Repository</a></li>
            <li><a href="community.html"><i class="fas fa-users"></i> Community</a></li>
            <li><a href="partners.html"><i class="fas fa-handshake"></i> Partners</a></li>
            <li><a href="news.html"><i class="fas fa-newspaper"></i> News</a></li>
            <li><a href="contact.html"><i class="fas fa-envelope"></i> Contact</a></li>
        </ul>
    </aside>
'@

foreach ($file in $htmlFiles) {
    if (Test-Path $file) {
        Write-Output "Processing file: $file"
        $content = Get-Content $file -Raw
        
        # Replace main content start with sidebar HTML
        $content = $content -replace '<main class="main-content">', "$sidebarHtml`n    <main class='main-content'>"
        
        Set-Content $file $content -Encoding UTF8
        Write-Output "Added sidebar to $file"
    } else {
        Write-Output "File not found: $file"
    }
}

Write-Output "Done adding sidebar HTML to all files!"