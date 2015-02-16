" This came from Greg V's dotfiles:
"      https://github.com/myfreeweb/dotfiles
" Feel free to steal it, but attribution is nice
" 
" Thanks: see vimrc
" http://www.stephendiehl.com/posts/vim_haskell.html

setlocal omnifunc=necoghc#omnifunc
setlocal formatprg=pointfree

setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal iskeyword-=.

imap <C-b> <Space>>>=<Space>
imap <C-l> <Space>→<Space>
