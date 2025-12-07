import html5lib
import glob
import os

# 遍历所有HTML文件
for file_path in glob.glob('*.html'):
    print(f'\n=== 检查文件: {file_path} ===')
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            # 尝试解析HTML
            html5lib.parse(content)
            print('✅ HTML 语法正确')
    except Exception as e:
        print(f'❌ HTML 语法错误: {e}')
        # 尝试找出错误位置
        try:
            lines = content.split('\n')
            # 逐行检查
            for i, line in enumerate(lines, 1):
                try:
                    html5lib.parse(f'<html>{line}</html>')
                except Exception as line_e:
                    print(f'   第 {i} 行可能有问题: {line[:100]}...')
        except:
            pass
    print('-' * 50)
