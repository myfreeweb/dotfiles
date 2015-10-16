" This came from Greg V's dotfiles:
"      https://github.com/myfreeweb/dotfiles
" Feel free to steal it, but attribution is nice
" 
" Thanks:
"  see vimrc
"  https://github.com/junegunn/fzf/blob/master/plugin/fzf.vim

" nnoremap <silent> <Leader>i :<C-u>Unite unicode          -start-insert<CR>

nnoremap <silent> <Leader>p :<C-u>call TermMenuOpen()<CR>
function! TermMenuOpen()
	call TermMenuRun("git ls-files", function("s:OpenFiles"))
endfunction

nnoremap <silent> <Leader>g :<C-u>call TermMenuSearch()<CR>
function! TermMenuSearch()
	call inputsave()
	let query = input('Search: ')
	call inputrestore()
	call TermMenuRun($SEARCH." --nogroup --nocolor ".shellescape(query), function("s:OpenFiles"))
endfunction

function! TermMenuRun(cmd, callback)
	enew
	setlocal buftype=nofile bufhidden=wipe nobuflisted
	let s:callback = a:callback
	let s:tempresult = tempname()
	let termsettings = { 'buf': bufnr('%'), 'dict': {}, 'name': 'TermMenu' }
	function! termsettings.on_exit(id, code)
		bd!
		call s:callback(readfile(s:tempresult))
		silent! call delete(s:tempresult)
	endfunction
	call termopen(a:cmd." | ".$MENU." > ".shellescape(s:tempresult), termsettings)
	startinsert
endfunction

function! s:OpenFiles(lines)
	for line in a:lines
		let parts = split(line, ':')
		execute 'edit' parts[0]
		silent! execute ':' parts[1]
	endfor
endfunction
