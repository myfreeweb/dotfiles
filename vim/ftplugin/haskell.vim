" thanks:
" http://www.stephendiehl.com/posts/vim_haskell.html

let g:haskell_conceal_enumerations=0
let g:haskell_use_basedir = getcwd()

setlocal formatprg=hindent

setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal iskeyword-=.
setlocal iskeyword+='
setlocal cpoptions+=M " don't treat \ as escape because lambdas

imap <C-b> <Space>>>=<Space>
imap <C-l> <Space>→<Space>

if has('nvim')
	" GHCi repl for fast testing! Use per-project .ghci files.
	nnoremap <buffer> <Leader>T :T :retest<CR>
	nnoremap <buffer> <Leader>b :T :bench<CR>
	nnoremap <buffer> <Leader>t :T :test<CR>
	nnoremap <buffer> <Leader>x :T :serve<CR>
endif

vnoremap <buffer> a= :EasyAlign /=/<CR>
vnoremap <buffer> a; :EasyAlign /∷\\|::/<CR>
vnoremap <buffer> al :EasyAlign /→\\|->/<CR>
