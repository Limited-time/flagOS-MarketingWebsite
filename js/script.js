// 移动端菜单切换
const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
const navMenu = document.querySelector('.nav-menu');

mobileMenuBtn.addEventListener('click', () => {
    mobileMenuBtn.classList.toggle('active');
    navMenu.classList.toggle('active');
});

// 点击导航链接后关闭移动端菜单
navMenu.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', () => {
        mobileMenuBtn.classList.remove('active');
        navMenu.classList.remove('active');
    });
});

// 导航栏滚动效果
window.addEventListener('scroll', () => {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 50) {
        navbar.style.boxShadow = '0 2px 20px rgba(0, 0, 0, 0.1)';
        navbar.style.background = 'rgba(255, 255, 255, 0.95)';
        navbar.style.backdropFilter = 'blur(10px)';
    } else {
        navbar.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.1)';
        navbar.style.background = '#ffffff';
        navbar.style.backdropFilter = 'none';
    }
});

// 平滑滚动到锚点
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        
        const targetId = this.getAttribute('href');
        if (targetId === '#') return;
        
        const targetElement = document.querySelector(targetId);
        if (targetElement) {
            const offsetTop = targetElement.offsetTop - 70; // 考虑导航栏高度
            window.scrollTo({
                top: offsetTop,
                behavior: 'smooth'
            });
        }
    });
});

// 滚动到顶部按钮
const scrollTopBtn = document.createElement('button');
scrollTopBtn.innerHTML = '↑';
scrollTopBtn.className = 'scroll-top-btn';
document.body.appendChild(scrollTopBtn);

// 初始隐藏滚动到顶部按钮
scrollTopBtn.style.display = 'none';

// 滚动事件监听
window.addEventListener('scroll', () => {
    if (window.scrollY > 300) {
        scrollTopBtn.style.display = 'block';
    } else {
        scrollTopBtn.style.display = 'none';
    }
});

// 点击滚动到顶部
scrollTopBtn.addEventListener('click', () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});

// 添加滚动到顶部按钮的 CSS 样式
const style = document.createElement('style');
style.textContent = `
    .scroll-top-btn {
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background-color: #0066cc;
        color: #ffffff;
        border: none;
        font-size: 24px;
        cursor: pointer;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        transition: all 0.3s ease;
        z-index: 999;
    }
    
    .scroll-top-btn:hover {
        background-color: #004499;
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    }
    
    @media (max-width: 768px) {
        .scroll-top-btn {
            bottom: 20px;
            right: 20px;
            width: 45px;
            height: 45px;
            font-size: 20px;
        }
    }
`;
document.head.appendChild(style);

// 为每个 section 添加滚动动画
const sections = document.querySelectorAll('section');

const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

sections.forEach(section => {
    section.style.opacity = '0';
    section.style.transform = 'translateY(30px)';
    section.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
    observer.observe(section);
});

// 高亮当前导航项
window.addEventListener('scroll', () => {
    let current = '';
    sections.forEach(section => {
        const sectionTop = section.offsetTop;
        const sectionHeight = section.clientHeight;
        if (pageYOffset >= sectionTop - 100) {
            current = section.getAttribute('id');
        }
    });

    navMenu.querySelectorAll('a').forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href') === '#' + current) {
            link.classList.add('active');
        }
    });
});

// 为导航项添加高亮样式
const navStyle = document.createElement('style');
navStyle.textContent = `
    .nav-menu li a.active {
        color: #0066cc;
        background-color: #f0f7ff;
    }
`;
document.head.appendChild(navStyle);

// 表单提交处理（如果有表单的话）
document.addEventListener('DOMContentLoaded', () => {
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', (e) => {
            e.preventDefault();
            // 这里可以添加表单提交逻辑
            alert('表单提交成功！我们会尽快与您联系。');
            form.reset();
        });
    });

    // 语言切换功能
    const languageLinks = document.querySelectorAll('.language-switcher a');
    const languageSwitcher = document.querySelector('.language-switcher');
    
    if (languageSwitcher) {
        // 保存当前语言偏好
        const saveLanguagePreference = (lang) => {
            localStorage.setItem('flagos-language', lang);
        };

        // 切换语言
        const switchLanguage = (e) => {
            e.preventDefault();
            
            // 更新活动状态
            languageLinks.forEach(link => {
                link.classList.remove('active');
            });
            
            const clickedLink = e.target;
            clickedLink.classList.add('active');
            
            // 获取语言代码
            const lang = clickedLink.textContent.trim() === '中文' ? 'zh' : 'en';
            saveLanguagePreference(lang);
            
            // 这里可以添加语言切换的实际逻辑，例如加载不同语言的内容
            // 目前只是模拟切换效果
            console.log(`Switched to ${lang} language`);
            
            // 可以添加页面重新加载或内容更新的逻辑
            // window.location.reload();
        };
        
        // 添加点击事件监听器
        languageLinks.forEach(link => {
            link.addEventListener('click', switchLanguage);
        });
        
        // 从localStorage加载语言偏好
        const loadLanguagePreference = () => {
            const savedLang = localStorage.getItem('flagos-language') || 'zh';
            languageLinks.forEach(link => {
                link.classList.remove('active');
                if ((savedLang === 'zh' && link.textContent.trim() === '中文') || 
                    (savedLang === 'en' && link.textContent.trim() === 'English')) {
                    link.classList.add('active');
                }
            });
        };
        
        // 初始化语言偏好
        loadLanguagePreference();
    }
});

// 添加核心数据的动态效果
const stats = document.querySelectorAll('.core-stats span');
stats.forEach(stat => {
    stat.style.opacity = '0';
    stat.style.transform = 'scale(0.8)';
    stat.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
});

// 当 banner 进入视口时，显示核心数据
const bannerObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            stats.forEach((stat, index) => {
                setTimeout(() => {
                    stat.style.opacity = '1';
                    stat.style.transform = 'scale(1)';
                }, index * 150);
            });
        }
    });
}, { threshold: 0.5 });

const banner = document.querySelector('.banner');
if (banner) {
    bannerObserver.observe(banner);
}

// 页面加载动画已经在HTML中处理，移除这里的重复逻辑
// 修复：移除可能导致页面一直显示加载的问题