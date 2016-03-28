" This came from Greg V's dotfiles:
"      https://github.com/myfreeweb/dotfiles
" Feel free to steal it, but attribution is nice
" 
" Thanks: see vimrc
" http://www.stephendiehl.com/posts/vim_haskell.html

let g:haskellmode_completion_ghc = 0
let g:haskell_conceal_enumerations=0
let g:haskell_use_basedir = getcwd()

setlocal omnifunc=necoghc#omnifunc
setlocal formatprg=pointfree

setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal iskeyword-=.
setlocal iskeyword+='

imap <C-b> <Space>>>=<Space>
imap <C-l> <Space>→<Space>
imap <C-h> <Space>←<Space>

" GHCi repl for fast testing! Use per-project .ghci files.
nnoremap <buffer> <Leader>r :call VimuxSendText(":retest\n")<CR>
nnoremap <buffer> <Leader>b :call VimuxSendText(":bench\n")<CR>
nnoremap <buffer> <Leader>t :call VimuxSendText(":test\n")<CR>
nnoremap <buffer> <Leader>x :call VimuxSendText(":serve\n")<CR>

nnoremap <buffer> <Leader>s :GhcModSplitFunCase<CR>
nnoremap <buffer> <Leader>l :GhcModLintAsync<CR>

vnoremap <buffer> a= :EasyAlign /=/<CR>
vnoremap <buffer> a; :EasyAlign /∷\\|::/<CR>
vnoremap <buffer> al :EasyAlign /→\\|->/<CR>
