"======================================================================
"
" init_coc.vim - 
"
" Created by skywind on 2020/03/01
" Last Modified: 2020/03/01 00:51:37
"
"======================================================================

" TextEdit might fail if hidden is not set.
set hidden

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

""""""""""""""""""""""""""""""""""""""""
" => completion
" Use <m-/> to trigger completion.
inoremap <silent><expr> <m-/> coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif


""""""""""""""""""""""""""""""""""""""""
" => autocmd
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


""""""""""""""""""""""""""""""""""""""""
" => custom functions
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


""""""""""""""""""""""""""""""""""""""""
" => custom command
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


"======================================================================
" => patches - https://zhuanlan.zhihu.com/p/76033635
" 解决coc.nvim大文件卡死状况 - 超过0.5m的文件，禁用coc补全，比如打开log文件，tag文件
let g:trigger_size = 0.5 * 1048576

augroup hugefile
	autocmd!
	autocmd BufReadPre *
			\ let size = getfsize(expand('<afile>')) |
			\ if (size > g:trigger_size) || (size == -2) |
			\   echohl WarningMsg | echomsg 'WARNING: altering options for this huge file!' | echohl None |
			\   exec 'CocDisable' |
			\ else |
			\   exec 'CocEnable' |
			\ endif |
			\ unlet size
augroup END

"======================================================================
" => keymaps
" Use (default is <C-j>) for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<C-j>'
" Use (default is <C-k>) for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<C-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

""""""""""""""""""""
" => diagnostic
" Show all diagnostics.
nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

""""""""""""""""""""
" => coc inner command
" Manage extensions.
nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <leader>cl  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>

""""""""""""""""""""
" => codeAction
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nnoremap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""""""""""""""""""""""""""""""""""""""""
" => ccls
silent! call mkdir($HOME . '/.cache/ccls', 'p')
silent! call coc#config('languageserver.ccls.initializationOptions.cache.directory', expand('~/.cache/ccls'))

" base class
nn <silent> <leader>xb :call CocLocations('ccls','$ccls/inheritance')<cr>
" bases of up to 3 levels
nn <silent> <leader>xB :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>
" derived
nn <silent> <leader>xd :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
" derived of up to 3 levels
nn <silent> <leader>xD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>

" caller
nn <silent> <leader>xc :call CocLocations('ccls','$ccls/call')<cr>
" callee
nn <silent> <leader>xC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>

" member
" member variables / variables in a namespace
nn <silent> <leader>xm :call CocLocations('ccls','$ccls/member')<cr>
" member functions / functions in a namespace
nn <silent> <leader>xf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
" nested classes / types in a namespace
nn <silent> <leader>xs :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>
nn <silent> <leader>xv :call CocLocations('ccls','$ccls/vars')<cr>
nn <silent> <leader>xV :call CocLocations('ccls','$ccls/vars',{'kind':1})<cr>

" typo correct xx -> x
nn xx x

" ccls/navigate - https://github.com/MaskRay/ccls/wiki/LSP-Extensions#cclsnavigate
nn <silent><buffer> <C-l> :call CocLocations('ccls','$ccls/navigate',{'direction':'D'})<cr>
nn <silent><buffer> <C-k> :call CocLocations('ccls','$ccls/navigate',{'direction':'L'})<cr>
nn <silent><buffer> <C-j> :call CocLocations('ccls','$ccls/navigate',{'direction':'R'})<cr>
nn <silent><buffer> <C-h> :call CocLocations('ccls','$ccls/navigate',{'direction':'U'})<cr>
