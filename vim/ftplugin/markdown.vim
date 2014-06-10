setlocal wrap
setlocal linebreak
setlocal nolist
setlocal textwidth=0 " Do NOT insert linebreaks automatically! I use linebreaks after every sentence.
setlocal expandtab
setlocal ai
setlocal formatoptions=tcroqn2
setlocal comments=n:>
nnoremap <Leader>m :silent !open -a Marked.app '%:p'<cr>
