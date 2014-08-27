" This came from Greg V's dotfiles:
"      https://github.com/myfreeweb/dotfiles
" Feel free to steal it, but attribution is nice
" 
" Thanks: see vimrc

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
setlocal nosmartindent
setlocal wrap
setlocal define=^\s*\\(def\\\\|class\\)
inoremap <buffer> <C-b> """"""<left><left><left>

setlocal omnifunc=pythoncomplete#Complete
