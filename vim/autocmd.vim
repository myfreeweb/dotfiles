" File types
au BufRead,BufNewFile .ghci setf haskell
au BufRead,BufNewFile *.ronn setf markdown
au BufRead,BufNewFile SCons* setf python
au BufRead,BufNewFile *.gradle setf groovy
au BufRead,BufNewFile *.scaml setf haml
au BufRead,BufNewFile *.sjs setf javascript
au BufRead,BufNewFile .{eslintrc,babelrc} setf json
au BufRead,BufNewFile *.swig setf htmldjango
au BufRead,BufNewFile *.tt setf tt2html
au BufRead,BufNewFile *.tap setf tap
au BufRead,BufNewFile *.gv setf dot
au BufRead,BufNewFile *i3.conf,*sway.conf setf i3
au BufRead,BufNewFile quakelive.cfg setf quake
au BufRead,BufNewFile *.{jar,war,ear,sar} setf zip
au BufRead,BufNewFile *.ledger setf ledger
au BufRead,BufNewFile *psqlrc,*.sql setf pgsql
au BufRead,BufNewFile *.nginx,*.ngx,*.ngx.conf,*nginx.conf setf nginx
au BufRead,BufNewFile *.pf,*pf.conf setf pf
au BufRead,BufNewFile *.sieve setf sieve
au BufRead,BufNewFile gitconfig setlocal noexpandtab

" Completion and stuff
au FileType {css,sass,scss,less,stylus} setlocal omnifunc=csscomplete#CompleteCSS
au FileType {css,sass,scss,less,stylus} setlocal iskeyword+=-
au FileType html setlocal omnifunc=htmlcomplete#CompleteTags
au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if has('nvim')
endif

" Folds
au FileType {vim,javascript,sql} setlocal foldmethod=marker
au BufRead,BufNewFile {,.}zshrc,*.fish setlocal foldmethod=marker

" Line numbers
au InsertEnter * set number
au InsertLeave * set relativenumber

" Misc
" https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
function s:MkNonExDir(file, buf)
	if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
		let dir=fnamemodify(a:file, ':h')
		if !isdirectory(dir)
			call mkdir(dir, 'p')
		endif
	endif
endfunction
au BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
au FileType netrw setlocal bufhidden=wipe
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
au VimResized * exe "normal! \<c-w>="
au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
au FileType mail exe "normal! }"
