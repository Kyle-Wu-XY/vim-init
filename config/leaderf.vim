""""""""""""""""""""""""""""""""""""""""
" => custom function
function! s:lf_task_source(...)
    let rows = asynctasks#source(&columns * 48 / 100)
    let source = []
    for row in rows
        let name = row[0]
        let source += [name . '  ' . row[1] . '  : ' . row[2]]
    endfor
    return source
endfunc


function! s:lf_task_accept(line, arg)
    let pos = stridx(a:line, '<')
    if pos < 0
        return
    endif
    let name = strpart(a:line, 0, pos)
    let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
    redraw
    if name != ''
        exec "AsyncTask " . name
    endif
endfunc

function! s:lf_task_digest(line, mode)
    let pos = stridx(a:line, '<')
    if pos < 0
        return [a:line, 0]
    endif
    let name = strpart(a:line, 0, pos)
    return [name, 0]
endfunc

function! s:lf_win_init(...)
    setlocal nonumber
    setlocal nowrap
endfunc

let g:Lf_Extensions = get(g:, 'Lf_Extensions', {})
let g:Lf_Extensions.task = {
            \ 'source': string(function('s:lf_task_source'))[10:-3],
            \ 'accept': string(function('s:lf_task_accept'))[10:-3],
            \ 'get_digest': string(function('s:lf_task_digest'))[10:-3],
            \ 'highlights_def': {
            \     'Lf_hl_funcScope': '^\S\+',
            \     'Lf_hl_funcDirname': '^\S\+\s*\zs<.*>\ze\s*:',
            \ },
            \ 'after_enter': string(function('s:lf_win_init'))[10:-3],
        \ }


""""""""""""""""""""""""""""""""""""""""
" => compatible check for python support
if index(g:bundle_group, 'leaderf') >= 0
    if has('python') || has('python3')
        " 如果 vim 支持 python 则启用  Leaderf
        " CTRL+p 打开文件模糊匹配
        let g:Lf_ShortcutF = '<c-o>'

        " ALT+n 打开 buffer 模糊匹配
        let g:Lf_ShortcutB = '<m-b>'

        " CTRL+n 打开最近使用的文件 MRU，进行模糊匹配
        noremap <m-p> :LeaderfMru<cr>

        " ALT+p 打开函数列表
        noremap <m-m> :LeaderfFunction<cr>

        " ALT+SHIFT+p 打开 tag 列表
        noremap <c-m> :LeaderfBufTag<cr>

        " ALT+n 打开 buffer 列表进行模糊匹配
        noremap <m-b> :LeaderfBuffer<cr>

        " ALT+m 全局 tags 模糊匹配
        noremap <m-,> :LeaderfTag<cr>

        " 最大历史文件保存 2048 个
        let g:Lf_MruMaxFiles = 2048

        " ui 定制
        let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

        noremap <m-t> :Leaderf --nowrap task<cr>
        inoremap <m-t> <esc>:Leaderf --nowrap task<cr>

        if has('gui_running')
            noremap <c-f12> :Leaderf --nowrap task<cr>
            inoremap <c-f12> <esc>:Leaderf --nowrap task<cr>
        endif

        " 如何识别项目目录，从当前文件目录向父目录递归知道碰到下面的文件/目录
        let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
        let g:Lf_WorkingDirectoryMode = 'Ac'
        if (exists('*popup_create') && has('patch-8.1.2000')) || has('nvim-0.4')
            let g:Lf_WindowPosition = 'popup'
        endif
        let g:Lf_WindowHeight = 0.40
        let g:Lf_CacheDirectory = expand('~/.cache/vim/')

        " 显示相对路径
        let g:Lf_ShowRelativePath = 1

        " 隐藏帮助
        let g:Lf_HideHelp = 1
        let g:Lf_NoChdir = 1 " ??

        " 模糊匹配忽略扩展名
        let g:Lf_UseVersionControlTool = 0 " 配合此选项才能忽略已经加入git repo的目录
        let g:Lf_WildIgnore = {
                    \ 'dir': ['.svn','.git','.hg', 'reserved-codes'],
                    \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
                    \ }

        " MRU 文件忽略扩展名
        let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
        let g:Lf_StlColorscheme = 'powerline'

        let g:Lf_PreviewInPopup = 1
        " 禁用 function/buftag 的预览功能，可以手动用 p 预览
        let g:Lf_PreviewResult = {'File': 1,'Buffer': 1,'Mru': 1,'Tag': 1,'BufTag': 1,'Function': 1,'Line': 1,'Colorscheme': 1}

        " 使用 ESC 键可以直接退出 leaderf 的 normal 模式
        let g:Lf_NormalMap = {
                \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
                \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
                \ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
                \ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
                \ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
                \ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
                \ }



        " => command list 
        nnoremap <silent><c-m-p> :LeaderfCommand<CR>

        " => helm-swoop
        nnoremap <leader>ss :Leaderf line --cword<CR>
        nnoremap <leader>s, :Leaderf line --all --cword<CR>

        " => ripgrep
        " grep function definition
        nnoremap <m-g> :<C-U><C-R>=printf("Leaderf! rg -F -w %s -t cpp", expand("<cword>"))<CR><CR>
        " grep function reference
        nnoremap <m-r> :<C-U><C-R>=printf("Leaderf! rg -F -w %s -t cpp --iglob !%s.*", expand("<cword>"), expand("<cword>"))<CR><CR>
        " grep symbols
        vnoremap <m-s> :<C-U><C-R>=printf("Leaderf! rg -F %s ", leaderf#Rg#visual())<CR><CR>
        " grep cursor word
        nnoremap <m-f> :Leaderf! rg --cword --stayOpen<CR>

        " grep on the fly
        " <path>/<file>.[h|hpp]::<function>); - declare
        " <path>/<file>.[cc|cxx|cpp]::::<function>[()] - definition
        nnoremap <c-m-o> :Leaderf rg --match-path --stayOpen<CR>
        
        " nnoremap <expr><F4> pumvisible() ? ':Leaderf! rg --next<CR>' : <F4>
        " nnoremap <F4> :Leaderf! rg --next<CR>
        " nnoremap <S-F4> :Leaderf! rg --previous<CR>

    else
        " 不支持 python ，使用 CtrlP/ctrlp-funky 代替
        " 忽略默认键位
        let g:ctrlp_map = ''

        " 模糊匹配忽略
        let g:ctrlp_custom_ignore = {
          \ 'dir':  '\v[\/]\.(git|hg|svn)$',
          \ 'file': '\v\.(exe|so|dll|mp3|wav|sdf|suo|mht)$',
          \ 'link': 'some_bad_symbolic_links',
          \ }

        " 项目标志
        let g:ctrlp_root_markers = ['.project', '.root', '.svn', '.git']
        let g:ctrlp_working_path = 0

        " CTRL+p 打开文件模糊匹配
        noremap <c-o> :CtrlP<cr>

        " CTRL+n 打开最近访问过的文件的匹配
        noremap <m-p> :CtrlPMRUFiles<cr>

        " ALT+p 显示当前文件的函数列表
        noremap <c-m> :CtrlPFunky<cr>

        " ALT+n 匹配 buffer
        noremap <m-b> :CtrlPBuffer<cr>
    endif
endif

""""""""""""""""""""""""""""""""""""""""
" => gtags
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'

""""""""""""""""""""""""""""""""""""""""
" => LeaderF-filer
nnoremap <leader>ff :Leaderf! filer<cr>

""""""""""""""""""""""""""""""""""""""""
" => examples
if 0
    " search word under cursor, the pattern is treated as regex, and enter normal mode directly
    noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

    " search word under cursor, the pattern is treated as regex,
    " append the result to previous search results.
    noremap <C-G> :<C-U><C-R>=printf("Leaderf! rg --append -e %s ", expand("<cword>"))<CR>

    " search word under cursor literally only in current buffer
    noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR>

    " search word under cursor literally in all listed buffers
    noremap <C-D> :<C-U><C-R>=printf("Leaderf! rg -F --all-buffers -e %s ", expand("<cword>"))<CR>

    " search visually selected text literally, don't quit LeaderF after accepting an entry
    xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F --stayOpen -e %s ", leaderf#Rg#visual())<CR>

    " recall last search. If the result window is closed, reopen it.
    noremap go :<C-U>Leaderf! rg --recall<CR>


    " search word under cursor in *.h and *.cpp files.
    noremap <Leader>a :<C-U><C-R>=printf("Leaderf! rg -e %s -g *.h -g *.cpp", expand("<cword>"))<CR>
    " the same as above
    noremap <Leader>a :<C-U><C-R>=printf("Leaderf! rg -e %s -g *.{h,cpp}", expand("<cword>"))<CR>

    " search word under cursor in cpp and java files.
    noremap <Leader>b :<C-U><C-R>=printf("Leaderf! rg -e %s -t cpp -t java", expand("<cword>"))<CR>

    " search word under cursor in cpp files, exclude the *.hpp files
    noremap <Leader>c :<C-U><C-R>=printf("Leaderf! rg -e %s -t cpp -g !*.hpp", expand("<cword>"))<CR>

endif


