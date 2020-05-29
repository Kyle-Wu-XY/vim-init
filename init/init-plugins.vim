"======================================================================
"
" init-plugins.vim -
"
" Created by skywind on 2018/05/31
" Last Modified: 2018/06/10 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :



"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
    let g:bundle_group = ['basic', 'tags', 'enhanced', 'filetypes', 'textobj']
    let g:bundle_group += ['airline', 'nerdtree', 'ale', 'echodoc']
    let g:bundle_group += ['doxygen', 'snippets', 'asynctasks']
    let g:bundle_group += ['leaderf', 'coc']

    let s:hostname = system('hostname')
    if stridx(s:hostname, 'Android') >= 0
    else
        let g:bundle_group += ['neoformat']
    endif

    " Function dumplicate with coc/leaderf, just for reference in future
    " let g:bundle_group += ['deoplete', 'ncm2', 'lcn']
endif

"----------------------------------------------------------------------
" 在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
call plug#begin(get(g:, 'bundle_home', '~/.vim/bundles'))


"----------------------------------------------------------------------
" 默认插件
"----------------------------------------------------------------------

" 全文快速移动
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
LoadScript config/easymotion.vim

" 多种颜色高亮符号
Plug 'Yggdroot/vim-mark'

" 文件浏览器，代替 netrw
Plug 'justinmk/vim-dirvish'
" Map `t` to open in new tab.
autocmd FileType dirvish
\  nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
\ |xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>

" 窗口快速跳转
Plug 't9md/vim-choosewin'
let g:choosewin_overlay_enable = 1
nmap _ <Plug>(choosewin)

" 表格对齐，使用命令 Tabularize
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" Diff 增强，支持 histogram / patience 等更科学的 diff 算法
Plug 'chrisbra/vim-diff-enhanced'

" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'

" Easily toggle between *.c* and *.h* buffers.
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/alternate-lite'

"----------------------------------------------------------------------
" Dirvish 设置：自动排序并隐藏文件，同时定位到相关文件
" 这个排序函数可以将目录排在前面，文件排在后面，并且按照字母顺序排序
" 比默认的纯按照字母排序更友好点。
"----------------------------------------------------------------------
function! s:setup_dirvish()
    if &buftype != 'nofile' && &filetype != 'dirvish'
        return
    endif
    if has('nvim')
        return
    endif
    " 取得光标所在行的文本（当前选中的文件名）
    let text = getline('.')
    if ! get(g:, 'dirvish_hide_visible', 0)
        exec 'silent keeppatterns g@\v[\/]\.[^\/]+[\/]?$@d _'
    endif
    " 排序文件名
    exec 'sort ,^.*[\/],'
    let name = '^' . escape(text, '.*[]~\') . '[/*|@=|\\*]\=\%($\|\s\+\)'
    " 定位到之前光标处的文件
    call search(name, 'wc')
    noremap <silent><buffer> ~ :Dirvish ~<cr>
    noremap <buffer> % :e %
endfunc

augroup MyPluginSetup
    autocmd!
    autocmd FileType dirvish call s:setup_dirvish()
augroup END


"----------------------------------------------------------------------
" 基础插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'basic') >= 0
    " 展示开始画面，显示最近编辑过的文件
    Plug 'mhinz/vim-startify'

    " 一次性安装一大堆 colorscheme
    Plug 'rafi/awesome-vim-colorschemes'
    " Plug 'flazz/vim-colorschemes'
    " Plug 'qualiabyte/vim-colorstepper'

    " 缩进级别竖线
    Plug 'Yggdroot/indentLine'

    " 下划线当前符号
    Plug 'itchyny/vim-cursorword'

    " 彩虹括号
    Plug 'luochen1990/rainbow'
    let g:rainbow_active = 1

    " 支持库，给其他插件用的函数库
    Plug 'xolox/vim-misc'

    " Quoting/parenthesizing made simple
    Plug 'tpope/vim-surround'
     
    " Pairs of handy bracket mappings
    Plug 'tpope/vim-unimpaired'

    " A simple, easy-to-use Vim alignment plugin
    Plug 'junegunn/vim-easy-align'
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)
    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)

    " 记住你上次所使用的补全方式，下次再补全时，直接使用TAB
    Plug 'metalelf0/supertab'
    let g:SuperTabRetainCompletionType = 2
    let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

    " Enable repeating supported plugin maps with "."
    Plug 'tpope/vim-repeat'

    " easily search for, substitute, and abbreviate multiple variants of a word
    Plug 'tpope/vim-abolish'

    " 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
    Plug 'kshenoy/vim-signature'

    " 用于在侧边符号栏显示 git/svn 的 diff
    Plug 'mhinz/vim-signify'

    " 根据 quickfix 中匹配到的错误信息，高亮对应文件的错误行
    " 使用 :RemoveErrorMarkers 命令或者 <space>ha 清除错误
    Plug 'mh21/errormarker.vim'

    " 使用 ALT+e 会在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
    Plug 't9md/vim-choosewin'

    " 提供基于 TAGS 的定义预览，函数参数预览，quickfix 预览
    Plug 'skywind3000/vim-preview'

    " 支援 vim-preview
    Plug 'skywind3000/vim-quickui'

    " Git 支持
    Plug 'tpope/vim-fugitive'
    LoadScript config/fugitive.vim

    " git commit browser
    Plug 'junegunn/gv.vim'
endif


"----------------------------------------------------------------------
" 增强插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'enhanced') >= 0

    " 用 v 选中一个区域后，ALT_+/- 按分隔符扩大/缩小选区
    Plug 'terryma/vim-expand-region'

    " 快速文件搜索
    Plug 'junegunn/fzf'

    " 给不同语言提供字典补全，插入模式下 c-x c-k 触发
    Plug 'asins/vim-dict'

    " 使用 :FlyGrep 命令进行实时 grep
    Plug 'wsdjeg/FlyGrep.vim'

    " 使用 :CtrlSF 命令进行模仿 sublime 的 grep
    Plug 'dyng/ctrlsf.vim'

    " 配对括号和引号自动补全
    " Plug 'Raimondi/delimitMate'
    Plug 'jiangmiao/auto-pairs'
    LoadScript config/auto-pairs.vim

    " 提供 gist 接口
    Plug 'lambdalisue/vim-gista', { 'on': 'Gista' }

    " ALT_+/- 用于按分隔符扩大缩小 v 选区
    map <m-=> <Plug>(expand_region_expand)
    map <m--> <Plug>(expand_region_shrink)
endif


"----------------------------------------------------------------------
" 自动生成 ctags/gtags，并提供自动索引功能
" 不在 git/svn 内的项目，需要在项目根目录 touch 一个空的 .root 文件
" 详细用法见：https://zhuanlan.zhihu.com/p/36279445
"----------------------------------------------------------------------
if index(g:bundle_group, 'tags') >= 0
    " 提供 ctags/gtags 后台数据库自动更新功能
    Plug 'ludovicchabant/vim-gutentags'

    " 提供 GscopeFind 命令并自动处理好 gtags 数据库切换
    " 支持光标移动到符号名上：<leader>cg 查看定义，<leader>cs 查看引用
    Plug 'skywind3000/gutentags_plus'
    LoadScript config/gutentags.vim
endif


"----------------------------------------------------------------------
" 文本对象：textobj 全家桶
"----------------------------------------------------------------------
if index(g:bundle_group, 'textobj') >= 0
    " 基础插件：提供让用户方便的自定义文本对象的接口
    Plug 'kana/vim-textobj-user'

    " indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
    Plug 'kana/vim-textobj-indent'

    " 语法文本对象：iy/ay 基于语法的文本对象
    Plug 'kana/vim-textobj-syntax'

    " 函数文本对象：if/af 支持 c/c++/vim/java
    Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }

    " 参数文本对象：i,/a, 包括参数或者列表元素
    Plug 'sgur/vim-textobj-parameter'

    " 提供 python 相关文本对象，if/af 表示函数，ic/ac 表示类
    Plug 'bps/vim-textobj-python', {'for': 'python'}

    " 提供 uri/url 的文本对象，iu/au 表示
    Plug 'jceb/vim-textobj-uri'
endif


"----------------------------------------------------------------------
" 文件类型扩展
"----------------------------------------------------------------------
if index(g:bundle_group, 'filetypes') >= 0
    " powershell 脚本文件的语法高亮
    Plug 'pprovost/vim-ps1', { 'for': 'ps1' }

    " lua 语法高亮增强
    Plug 'tbastos/vim-lua', { 'for': 'lua' }

    " C++ 语法高亮增强，支持 11/14/17 标准
    " Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cc', 'h', 'hpp', 'cxx', 'cpp'] }
    Plug 'bfrg/vim-cpp-modern', { 'for': ['c', 'cc', 'h', 'hpp', 'cxx', 'cpp'] }
    LoadScript config/cpp_modern.vim

    " 额外语法文件
    Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

    " python 语法文件增强
    Plug 'vim-python/python-syntax', { 'for': ['python'] }

    " rust 语法增强
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }

    " vim org-mode
    Plug 'jceb/vim-orgmode', { 'for': 'org' }
endif

"----------------------------------------------------------------------
" airline
"----------------------------------------------------------------------
if index(g:bundle_group, 'airline') >= 0
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_powerline_fonts = 0
    let g:airline_exclude_preview = 1
    let g:airline_section_b = '%n'
    let g:airline_theme='deus'
    let g:airline#extensions#branch#enabled = 0
    let g:airline#extensions#syntastic#enabled = 0
    let g:airline#extensions#fugitiveline#enabled = 0
    let g:airline#extensions#csv#enabled = 0
    let g:airline#extensions#vimagit#enabled = 0
endif


"----------------------------------------------------------------------
" NERDTree
"----------------------------------------------------------------------
if index(g:bundle_group, 'nerdtree') >= 0
    Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind'] }
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'jistr/vim-nerdtree-tabs'

    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeDirArrows = 1
    let g:NERDTreeHijackNetrw = 0
    noremap <space>nn :NERDTree<cr>
    noremap <space>no :NERDTreeFocus<cr>
    noremap <space>nm :NERDTreeMirror<cr>
    noremap <space>nt :NERDTreeToggle<cr>
endif


"----------------------------------------------------------------------
" LanguageTool 语法检查
"----------------------------------------------------------------------
if index(g:bundle_group, 'grammer') >= 0
    Plug 'rhysd/vim-grammarous'
    noremap <space>rg :GrammarousCheck --lang=en-US --no-move-to-first-error --no-preview<cr>
    map <space>rr <Plug>(grammarous-open-info-window)
    map <space>rv <Plug>(grammarous-move-to-info-window)
    map <space>rs <Plug>(grammarous-reset)
    map <space>rx <Plug>(grammarous-close-info-window)
    map <space>rm <Plug>(grammarous-remove-error)
    map <space>rd <Plug>(grammarous-disable-rule)
    map <space>rn <Plug>(grammarous-move-to-next-error)
    map <space>rp <Plug>(grammarous-move-to-previous-error)
endif


"----------------------------------------------------------------------
" ale：动态语法检查
"----------------------------------------------------------------------
if index(g:bundle_group, 'ale') >= 0
    Plug 'w0rp/ale'
    LoadScript config/ale.vim
endif


"----------------------------------------------------------------------
" echodoc：搭配 YCM/deoplete 在底部显示函数参数
"----------------------------------------------------------------------
if index(g:bundle_group, 'echodoc') >= 0
    Plug 'Shougo/echodoc.vim'
    set noshowmode
    let g:echodoc#enable_at_startup = 1
endif

"----------------------------------------------------------------------
" LeaderF：CtrlP / FZF 的超级代替者，文件模糊匹配，tags/函数名 选择
"----------------------------------------------------------------------
if index(g:bundle_group, 'leaderf') >= 0
    if has('python') || has('python3')
        " 如果 vim 支持 python 则启用  Leaderf
        Plug 'Yggdroot/LeaderF', { 'do': './install.sh'}
        Plug 'tamago324/LeaderF-filer'
        Plug 'Yggdroot/LeaderF-marks'
    else
        " 不支持 python ，使用 CtrlP 代替
        Plug 'ctrlpvim/ctrlp.vim'
        " 显示函数列表的扩展插件
        Plug 'tacahiroy/ctrlp-funky'
    endif

    LoadScript config/leaderf.vim
endif

if index(g:bundle_group, 'neoformat') >= 0
    Plug 'sbdchd/neoformat'

    " run a formatter on save
    if 0 " many project hasn't auto format settings, this feature not friendly to git diff
    augroup fmt
        autocmd!
        autocmd BufWritePre * undojoin | Neoformat
    augroup END
    endif
endif

if index(g:bundle_group, 'lcn') >= 0
    Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

    LoadScript config/LanguageClient-neovim.vim
endif

if index(g:bundle_group, 'deoplete') >= 0
    if has('nvim')
        Plug 'Shougo/deoplete.nvim'
    else
        Plug 'roxma/vim-hug-neovim-rpc'
        Plug 'roxma/nvim-yarp'
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    endif

    Plug 'Shougo/neosnippet'
    Plug 'Shougo/neosnippet-snippets'
    Plug 'Shougo/neopairs.vim'
    Plug 'zchee/deoplete-clang'
    LoadScript config/deoplete.vim
endif

if index(g:bundle_group, 'ncm2') >= 0
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'

    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'

    LoadScript config/ncm2.vim
endif

if index(g:bundle_group, 'coc') >= 0
    " Use release branch (Recommend)
    Plug 'neoclide/coc.nvim', {'branch': 'release', 'tag': '*', 'do': { -> coc#util#install()}}

    " Or latest tag
    " Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

    " Or build from source code by use yarn: https://yarnpkg.com
    " Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

    " :CocInstall coc-snippets
    " :CocInstall coc-clangd

    " Clang based syntax highlighting for Neovim - python3 only
    " Plug 'arakashic/chromatica.nvim'
    " let g:chromatica#libclang_path='/home/cnkwu/.local/share/llvm9/lib'
    " let g:chromatica#enable_at_startup=1

    LoadScript config/coc.vim
endif

if index(g:bundle_group, 'doxygen') >= 0
    Plug 'vim-scripts/DoxygenToolkit.vim'
    LoadScript config/doxygen.vim
endif

if index(g:bundle_group, 'snippets') >= 0
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'
endif

if index(g:bundle_group, 'asynctasks') >= 0
    Plug 'skywind3000/asynctasks.vim'
    Plug 'skywind3000/asyncrun.vim'

    " quickfix window can be opened automatically
    let g:asyncrun_open = 6
endif

"----------------------------------------------------------------------
" 结束插件安装
"----------------------------------------------------------------------
call plug#end()
