setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

if has('nvim')
	" sbt repl for fast testing!
	nnoremap <buffer> <Leader>t :T test<CR>
endif
