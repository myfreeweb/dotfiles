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
nnoremap <silent> <Leader>g :<C-u>Unite grep:.           -start-insert<CR>
nnoremap <silent> <Leader>b :<C-u>Unite buffer           -quick-match  -no-split<CR>
nnoremap <silent> <Leader>p :<C-u>Unite file_rec/async:! -start-insert -no-split<CR>
nnoremap <silent> <Leader>y :<C-u>Unite history/yank     -start-insert<CR>

" Inverted for Colemak + Improve up/down movement on wrapped lines http://vimbits.com/bits/25
noremap k gj
noremap j gk

" Less keystrokes
nnoremap ; :
vnoremap ; :
nnoremap ' i
vnoremap ' i
nnoremap U <C-r>

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

" windows
map <C-h> <C-w>h
map <C-k> <C-w>j
map <C-j> <C-w>k
map <C-l> <C-w>l

" case-insensitive
command! E e
command! W w
command! Q q
command! Wq wq
command! WQ wq

" buffer nav
nnoremap <Right> :bnext<CR>
nnoremap <Left>  :bprev<CR>

" List nav
nnoremap <Up>    :cprev<CR>zvzz
nnoremap <Down>  :cnext<CR>zvzz

" Motion for numbers.  Great for CSS.  Lets you do things like this:
" margin-top: 200px; -> daN -> margin-top: px;
onoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
xnoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
onoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
onoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>
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
