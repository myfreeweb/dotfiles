" This came from Greg V's dotfiles:
"      https://github.com/myfreeweb/dotfiles
" Feel free to steal it, but attribution is nice
" 
" Thanks: see vimrc

let mapleader = ","
let maplocalleader = "\\"

" Plugins and stuff
nmap sk :SplitjoinSplit<CR>
nmap sj :SplitjoinJoin<CR>
nnoremap <Leader>a :call VimuxOpenRunner()<CR>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Inverted for Colemak + Improve up/down movement on wrapped lines http://vimbits.com/bits/25
noremap k gj
noremap j gk

" Less keystrokes
nnoremap ; :
vnoremap ; :
nnoremap ' i
vnoremap ' i
nnoremap U <C-r>
nnoremap <Leader>q :bd<CR>

" Show most plugin keybindings  http://vimbits.com/bits/534
nnoremap <silent> <Leader>? :map <Leader><CR>

" Reselect visual block after indent/outdent  http://vimbits.com/bits/20
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Make Y behave like other capitals  http://vimbits.com/bits/11
nnoremap Y y$

" Don't move on *
nnoremap * *<C-o>

" Easier increment/decrement  http://vimbits.com/bits/207
nnoremap + <C-a>
nnoremap - <C-x>

" Folds
nnoremap <Space> za
vnoremap <Space> za

" Remove search highlights  http://vimbits.com/bits/21
nnoremap <silent> <CR> :nohlsearch<CR>

" Unfuck the screen
nnoremap <Leader>u :syntax sync fromstart<cr>:redraw!<cr> 

" Select (charwise) the contents of the current line, excluding indentation.
" great for pasting Python lines into REPLs.
nnoremap vv ^vg_

" Case-insensitive commands
command! E e
command! W w
command! Q q
command! Wq wq
command! WQ wq

" Window navigation
map <C-h> <C-w>h
nnoremap <BS> <C-w>h
map <C-k> <C-w>j
map <C-j> <C-w>k
map <C-l> <C-w>l

" Buffer navigation
nnoremap <Right> :bnext<CR>
nnoremap <Left>  :bprev<CR>

" List navigation
nnoremap <Up>    :cprev<CR>zvzz
nnoremap <Down>  :cnext<CR>zvzz

" Toggles
nnoremap <silent> <Leader>P :call ToggleOption('paste')<CR>
nnoremap <silent> <Leader>W :call ToggleOption('wrap')<CR>
nnoremap <silent> <Leader>S :call ToggleOption('spell')<CR>
function! ToggleOption(option_name)
	execute 'setlocal' a:option_name.'!'
	execute 'setlocal' a:option_name.'?'
endfunction

" Settings
nnoremap <silent> <Leader><Tab>t :setlocal noexpandtab<CR>
nnoremap <silent> <Leader><Tab>2 :setlocal expandtab shiftwidth=2 softtabstop=2<CR>
nnoremap <silent> <Leader><Tab>4 :setlocal expandtab shiftwidth=4 softtabstop=4<CR>
nnoremap <silent> <Leader><Tab>8 :setlocal expandtab shiftwidth=8 softtabstop=8<CR>

" Motion for numbers.  Great for CSS.  Lets you do things like this:
" margin-top: 200px; -> daN -> margin-top: px;
onoremap N  :<C-u>call <SID>NumberTextObject(0)<cr>
xnoremap N  :<C-u>call <SID>NumberTextObject(0)<cr>
onoremap aN :<C-u>call <SID>NumberTextObject(1)<cr>
xnoremap aN :<C-u>call <SID>NumberTextObject(1)<cr>
onoremap iN :<C-u>call <SID>NumberTextObject(1)<cr>
xnoremap iN :<C-u>call <SID>NumberTextObject(1)<cr>
function! s:NumberTextObject(whole)
	normal! v
	while getline('.')[col('.')] =~# '\v[0-9]'
		normal! l
	endwhile
	if a:whole
		normal! o
		while col('.') > 1 && getline('.')[col('.') - 2] =~# '\v[0-9]'
			normal! h
		endwhile
	endif
endfunction

" Kill buffers without closing panes
nnoremap <silent> <Leader>k :Bclose<CR>
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")

	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif

	if bufnr("%") == l:currentBufNum
		new
	endif

	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endfunction
