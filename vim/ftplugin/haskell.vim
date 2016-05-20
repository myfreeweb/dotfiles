" This came from Greg V's dotfiles:
"      https://github.com/myfreeweb/dotfiles
" Feel free to steal it, but attribution is nice
" 
" Thanks: see vimrc
" http://www.stephendiehl.com/posts/vim_haskell.html

let g:haskell_conceal_enumerations=0
let g:haskell_use_basedir = getcwd()

setlocal omnifunc=intero#omnifunc
setlocal formatprg=pointfree

setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal iskeyword-=.
setlocal iskeyword+='
setlocal cpoptions+=M " don't treat \ as escape because lambdas

imap <C-b> <Space>>>=<Space>
imap <C-l> <Space>→<Space>

vnoremap <buffer> <Leader>G :InteroGoto<CR>
vnoremap <buffer> <Leader>T :InteroType<CR>
vnoremap <buffer> <Leader>U :InteroUses<CR>

" GHCi repl for fast testing! Use per-project .ghci files.
nnoremap <buffer> <Leader>r :call VimuxSendText(":retest\n")<CR>
nnoremap <buffer> <Leader>b :call VimuxSendText(":bench\n")<CR>
nnoremap <buffer> <Leader>t :call VimuxSendText(":test\n")<CR>
nnoremap <buffer> <Leader>x :call VimuxSendText(":serve\n")<CR>
nnoremap <buffer> <Leader>m :call intero#ensurebufmodule()<CR>:call VimuxSendText(":m + ".b:intero_module."\n")<CR>

vnoremap <buffer> a= :EasyAlign /=/<CR>
vnoremap <buffer> a; :EasyAlign /∷\\|::/<CR>
vnoremap <buffer> al :EasyAlign /→\\|->/<CR>
