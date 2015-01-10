" This came from Greg V's dotfiles:
"      https://github.com/myfreeweb/dotfiles
" Feel free to steal it, but attribution is nice
"
" Thanks: see vimrc

setlocal wrap
setlocal linebreak
setlocal nolist
setlocal textwidth=0 " Do NOT insert linebreaks automatically! I use linebreaks after every sentence.
setlocal expandtab
setlocal ai
setlocal formatoptions=tcroqn2
setlocal comments=n:>
setlocal comments=b:- " Auto insert bullet when constructing lists
setlocal spell

nnoremap <Leader>m :silent !open -a Marked.app '%:p'<cr>
