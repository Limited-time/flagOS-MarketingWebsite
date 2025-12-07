import html5lib
import glob

for file in glob.glob('*.html'):
    print('Validating {}...'.format(file))
    try:
        with open(file, 'r', encoding='utf-8') as f:
            html5lib.parse(f.read())
        print('{} is valid'.format(file))
    except Exception as e:
        print('{} is invalid: {}'.format(file, e))
