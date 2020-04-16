" Vim tend to a have issues with flagging braces as errors, see for example https://github.com/vim-jp/vim-cpp/issues/16. A workaround is to set
let c_no_curly_error=1

" Highlighting of class scope is disabled by default. To enable set
let g:cpp_class_scope_highlight = 1

" Highlighting of member variables is disabled by default. To enable set
let g:cpp_member_variable_highlight = 1

" Highlighting of class names in declarations is disabled by default. To enable set
let g:cpp_class_decl_highlight = 1

" Highlighting of POSIX functions is disabled by default. To enable set
let g:cpp_posix_standard = 1

" There are two ways to highlight template functions. Either
let g:cpp_experimental_simple_template_highlight = 1

" which works in most cases, but can be a little slow on large files. Alternatively set
let g:cpp_experimental_template_highlight = 1

" Highlighting of library concepts is enabled by
let g:cpp_concepts_highlight = 1

" Enable highlighting of named requirements (C++20 library concepts)
let g:cpp_named_requirements_highlight = 1
