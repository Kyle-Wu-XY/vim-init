""""""""""""""""""""""""""""""""""""""""
" => Plugin 'vim-multiple-cursors'
""""""""""""""""""""""""""""""""""""""""
if 1
    let g:multi_cursor_start_word_key      = 'gh'
    let g:multi_cursor_select_all_word_key = 'ggh'
    let g:multi_cursor_start_key           = 'g<C-n>'
    let g:multi_cursor_select_all_key      = 'g<A-n>'
    let g:multi_cursor_next_key            = 'j'
    let g:multi_cursor_prev_key            = 'k'
    let g:multi_cursor_skip_key            = 'l'
    let g:multi_cursor_quit_key            = '<Esc>'
else

""""""""""""""""""""""""""""""""""""""""
" => Plugin 'mg979/vim-visual-multi'
""""""""""""""""""""""""""""""""""""""""
let g:VM_mouse_mappings = 1
" let g:VM_custom_remaps = { 'gh': '<C-n>', 'ggh': '\\A', '<m-+>': '\\\', 'j': ']', 'k': 'Q' }
let g:VM_custom_remaps = {'<c-p>': '[', '<c-s>': 'q'}
endif
