let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" Keep cursor column when JK motion"
let g:EasyMotion_startofline = 0 

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" nmap <leader>sc <Plug>(easymotion-overwin-f)
" Need one more keystroke, but on average, it may be more comfortable.
nmap <leader>sc <Plug>(easymotion-overwin-f2)

" Move to line
map <leader>sl <Plug>(easymotion-bd-jk)
nmap <leader>sl <Plug>(easymotion-overwin-line)

" Move to word
map  <leader>sw <Plug>(easymotion-bd-w)
nmap <leader>sw <Plug>(easymotion-overwin-w)

" Integration with incsearch.vim
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
