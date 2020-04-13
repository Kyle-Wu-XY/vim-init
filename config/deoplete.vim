let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_refresh_always = 1

" call deoplete#custom#source('_', 'converters', ['converter_auto_paren'])

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>") 
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"

" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<bs>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

if 0
	let g:deoplete#sources = {}
	let g:deoplete#sources._ = ['buffer', 'dictionary']
	let g:deoplete#sources.cpp = ['clang']
	" let g:deoplete#sources.python = ['jedi']
	let g:deoplete#sources.cpp = ['omni']
endif

set shortmess+=c
let g:echodoc#enable_at_startup = 1
" smart case不解释
let g:deoplete#enable_smart_case = 1

" 用户输入至少两个字符时再开始提示补全
" call deoplete#custom#source('LanguageClient',
"             \ 'min_pattern_length',
"             \ 2)

" 字符串中不补全
" call deoplete#custom#source('_',
"             \ 'disabled_syntaxes', ['String']
"             \ )

" 补全结束或离开插入模式时，关闭预览窗口
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" 为每个语言定义completion source
" 是的vim script和zsh script都有，这就是deoplete
" call deoplete#custom#option('sources', {
"             \ 'cpp': ['LanguageClient'],
"             \ 'c': ['LanguageClient'],
"             \ 'vim': ['vim'],
"             \ 'zsh': ['zsh']
"             \})

" 忽略一些没意思的completion source。
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer', 'around']
