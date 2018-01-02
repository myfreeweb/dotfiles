setlocal formatprg=rustfmt

setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

if has('nvim')
	nnoremap <buffer> <Leader>b :T cargo bench<CR>
	nnoremap <buffer> <Leader>t :T cargo test<CR>
	" no CR, let me enter arguments:
	nnoremap <buffer> <Leader>r :T cargo run -- 
	nnoremap <buffer> <Leader>r :T cargo run --release -- 
endif
