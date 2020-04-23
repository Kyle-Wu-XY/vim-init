#!/usr/bin/python3
# -*- coding: UTF-8 -*-

import os
rootdir = '.'

header = 'clang\n%c -std=c11\n%cpp -std=c++2a\n'
print(header)

for subdir, dirs, files in os.walk(rootdir):
    print('-I%s' % subdir)
