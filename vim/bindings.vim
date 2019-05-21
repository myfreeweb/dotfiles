let mapleader = ","
let maplocalleader = "\\"

" Plugins and stuff
let g:filebeagle_suppress_keymaps = 1
map <silent> - <Plug>FileBeagleOpenCurrentBufferDir
nmap <silent> sk :SplitjoinSplit<CR>
nmap <silent> sj :SplitjoinJoin<CR>
xmap <silent> ga <Plug>(EasyAlign)
nmap <silent> ga <Plug>(EasyAlign)
nnoremap <silent> <Leader>q :Bdelete<CR>
nnoremap <silent> <Leader>U :UndotreeToggle<CR>
nnoremap <silent> <Leader>p :Denite buffer file_rec<CR>
nnoremap <silent> <Leader>b :Denite buffer<CR>
nnoremap <silent> <Leader>g :Denite grep<CR>
command! -bar Proj Denite -default-action=cd prj
command! ProjStuff Proj|execute 'terminal'|vsplit .
nnoremap <silent> <Leader>o :ProjStuff<CR>

if has('nvim')
	inoremap <silent><expr> <TAB>
				\ pumvisible() ? "\<C-n>" :
				\ <SID>check_back_space() ? "\<TAB>" :
				\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	let g:coc_snippet_next = '<TAB>'
	let g:coc_snippet_prev = '<S-TAB>'

	nmap <silent> [c <Plug>(coc-diagnostic-prev)
	nmap <silent> ]c <Plug>(coc-diagnostic-next)

	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
		if &filetype == 'vim'
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction

	autocmd CursorHold * silent call CocActionAsync('highlight')

	nmap <leader>rn <Plug>(coc-rename)

	vmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)

	vmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	nmap <leader>ac  <Plug>(coc-codeaction)

	command! -nargs=0 Diag   :call CocAction('diagnosticInfo')
	command! -nargs=0 Format :call CocAction('format')
	command! -nargs=? Fold   :call CocAction('fold', <f-args>)
endif

" Show most plugin keybindings  http://vimbits.com/bits/534
nnoremap <silent> <Leader>? :map <Leader><CR>

" Unfuck the screen
nnoremap <Leader>u :syntax sync fromstart<cr>:redraw!<cr> 

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
nnoremap <silent> <Leader><Tab>s :setlocal expandtab<CR>
nnoremap <silent> <Leader><Tab>2 :setlocal shiftwidth=2 softtabstop=2<CR>
nnoremap <silent> <Leader><Tab>4 :setlocal shiftwidth=4 softtabstop=4<CR>
nnoremap <silent> <Leader><Tab>8 :setlocal shiftwidth=8 softtabstop=8<CR>

" Inverted for Colemak + Improve up/down movement on wrapped lines http://vimbits.com/bits/25
noremap k gj
noremap j gk

" Less keystrokes
nnoremap ; :
vnoremap ; :
nnoremap ' i
vnoremap ' i
nnoremap U <C-r>
"nnoremap <Leader>q :Bdelete<CR>

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

" Select (charwise) the contents of the current line, excluding indentation.
" great for pasting Python lines into REPLs.
nnoremap vv ^vg_

" Extra commands
command! Wc w|Bdelete

" Case-insensitive commands
command! E e
command! W w
command! Q q
command! Wq wq
command! WQ wq
command! WC Wc

" Tab navigation
nmap <C-Right> :tabnext<CR>
nmap <C-Left>  :tabprev<CR>

" Window navigation
map <C-h> <C-w>h
nnoremap <BS> <C-w>h
map <C-k> <C-w>j
map <C-j> <C-w>k
map <C-l> <C-w>l

" Buffer navigation
"nnoremap <silent> <Right> :VimDrawerNextBuffer<CR>
"nnoremap <silent> <Left>  :VimDrawerPreviousBuffer<CR>
nnoremap <silent> <Right> :bnext<CR>
nnoremap <silent> <Left>  :bprev<CR>

" List navigation
nnoremap <Up>    :cprev<CR>zvzz
nnoremap <Down>  :cnext<CR>zvzz

" Terminal
if has('nvim')
	tnoremap <Esc> <C-\><C-n>
	tnoremap <C-v><Esc> <Esc>
	" Buffer navigation
	tmap <silent> <C-Right> <C-\><C-n>:bnext<CR>
	tmap <silent> <C-Left>  <C-\><C-n>:bprev<CR>
	" Window navigation out of terminals
	tmap <C-h> <Esc><C-w>h
	tmap <C-k> <Esc><C-w>j
	tmap <C-j> <Esc><C-w>k
	tmap <C-l> <Esc><C-w>l
	tnoremap <C-v><C-h> <C-h>
	tnoremap <C-v><C-j> <C-j>
	tnoremap <C-v><C-k> <C-k>
	tnoremap <C-v><C-l> <C-l>
	nnoremap <silent> <F10> :TREPLSendFile<CR>
	nnoremap <silent> <F9> :TREPLSendLine<CR>
	vnoremap <silent> <F9> :TREPLSendSelection<CR>
endif

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
