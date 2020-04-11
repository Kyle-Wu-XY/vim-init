" 使用 ALT+E 来选择窗口
nmap <m-e> <Plug>(choosewin)

" 默认不显示 startify
let g:startify_disable_at_vimenter = 1
let g:startify_session_dir = '~/.vim/session'

" 使用 <space>ha 清除 errormarker 标注的错误
noremap <silent><space>ha :RemoveErrorMarkers<cr>

" signify 调优
let g:signify_vcs_list = ['git', 'svn']
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = g:signify_sign_change

" git 仓库使用 histogram 算法进行 diff
let g:signify_vcs_cmds = {
        \ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
        \}
