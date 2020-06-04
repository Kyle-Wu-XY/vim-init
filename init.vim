"======================================================================
"
" init.vim - initialize config
"
" Created by skywind on 2018/05/30
" Last Modified: 2018/05/30 18:26:34
"
"======================================================================

" 防止重复加载
if get(s:, 'loaded', 0) != 0
    finish
else
    let s:loaded = 1
endif

" => system detection
if has('win32') || has('win64') || has('win95') || has('win16')
    let g:asc_uname = 'windows'
elseif has('win32unix')
    let g:asc_uname = 'cygwin'
elseif has('unix') && (has('mac') || has('macunix'))
    let g:asc_uname = 'darwin'
elseif has('unix')
    let s:uname = substitute(system("uname"), '\s*\n$', '', 'g')
    if v:shell_error == 0 && match(s:uname, 'Linux') >= 0
        let g:asc_uname = 'linux'
    elseif v:shell_error == 0 && match(s:uname, 'FreeBSD') >= 0
        let g:asc_uname = 'freebsd'
    elseif v:shell_error == 0 && match(s:uname, 'Darwin') >= 0
        let g:asc_uname = 'darwin'
    else
        let g:asc_uname = 'posix'
    endif
else
    let g:asc_uname = 'posix'
endif

" => python3 support
if has('nvim')
    if 'windows' == g:asc_uname
        " let g:python3_host_prog ='C:/Python3_x64/python'
    else
        let g:python3_host_prog ='/home/cnkwu/.local/share/python3.8/bin/python3'
    endif
else
    set pythonthreehome=/home/cnkwu/.local/share/python3.8/
    set pythonthreedll=/home/cnkwu/.local/share/python3.8/lib/libpython3.8.so.1.0
endif

" 取得本文件所在的目录
let g:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! Gpath(path)
    let path = expand(g:home . '/' . a:path )
    return substitute(path, '\\', '/', 'g')
endfunc


" 定义一个函数用来加载文件
command! -nargs=1 LoadScript exec 'so '. fnameescape(g:home."/<args>")

" 将 vim-init 目录加入 runtimepath
exec 'set rtp+='.g:home

" 将 ~/.vim 目录加入 runtimepath (有时候 vim 不会自动帮你加入）
set rtp+=~/.vim

function! IsHostNameContain(name)
    let l:hostname = system('hostname')

    if stridx(l:hostname, a:name) >= 0
        return 1
    else
        return 0
    endif
endfunc

"----------------------------------------------------------------------
" 模块加载
"----------------------------------------------------------------------

" 加载基础配置
LoadScript init/init-basic.vim

" 加载扩展配置
LoadScript init/init-config.vim

" 设定 tabsize
LoadScript init/init-tabsize.vim

" 插件加载
LoadScript init/init-plugins.vim

" 界面样式
LoadScript init/init-style.vim

" 自定义按键
LoadScript init/init-keymaps.vim



