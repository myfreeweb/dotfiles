" GOPATH all the things. The option is added in vim/apply.sh because fuck everything.
" Only `Plug 'username/repo'` works with this setup. I don't care about other types of paths!
let g:plug_name_modifier = ':s?\.git$??'

call plug#begin('~/src/github.com')

function! DoRemote(arg)
	UpdateRemotePlugins
endfunction

" Languages
Plug 'sheerun/vim-polyglot'
Plug 'b4b4r07/vim-hcl'
Plug 'moll/vim-bbye'
Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }
Plug 'jceb/vim-orgmode', { 'for': 'org' }
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'ledger/vim-ledger', { 'for': 'ledger' }
Plug 'brandonbloom/vim-factor', { 'for': 'factor' }
Plug 'amirh/HTML-AutoCloseTag', { 'for': 'html' }
Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] }
Plug 'Rip-Rip/clang_complete', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }
if executable('npm')
	Plug 'Quramy/tsuquyomi', { 'for': ['ts', 'typescript'] }
endif
if executable('latex')
	Plug 'lervag/vimtex', { 'for': ['tex', 'latex'] }
endif
if executable('python')
	Plug 'davidhalter/jedi-vim', { 'for': 'python' }
endif
if executable('go')
	Plug 'fatih/vim-go', { 'for': 'go' }
endif
if executable('idris')
	Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
endif
if executable('ghc') " Haskell
	Plug 'myfreeweb/intero.nvim', { 'for': 'haskell' }
	Plug 'itchyny/vim-haskell-indent', { 'for': 'haskell' }
endif
if executable('cargo') " Rust
	Plug 'racer-rust/vim-racer', { 'for': 'rust' }
endif
if executable('mono') " .NET
	Plug 'OrangeT/vim-csharp', { 'for': 'cs' }
	Plug 'kongo2002/fsharp-vim', { 'for': 'fsharp' }
endif
if executable('sbt') " Scala
	Plug 'ensime/ensime-vim', { 'for': 'scala', 'do': 'pip install --user websocket-client' }
endif
if isdirectory($HOME.'/src/scm.gforge.inria.fr/anonscm/git/why3/why3/share/vim')
	Plug '~/src/scm.gforge.inria.fr/anonscm/git/why3/why3/share/vim'
endif

" Features
Plug 'Shougo/vimproc.vim', { 'do': 'gmake' }
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'sjl/gundo.vim', { 'on': ['GundoShow', 'GundoToggle'] }
Plug 'sjl/splice.vim', { 'on': ['SpliceInit'] }
Plug 'sjl/vitality.vim'
Plug 'junegunn/vim-easy-align'
Plug 'reedes/vim-wordy'
Plug 'ervandew/supertab'
Plug 'terryma/vim-multiple-cursors'
Plug 'Raimondi/delimitMate'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'sickill/vim-pasta'
Plug 'itchyny/lightline.vim'
" Plug 'editorconfig/editorconfig-vim' " Everything becomes slow over NFS :(
Plug 'benmills/vimux'

" Colors
Plug 'chriskempson/base16-vim'

call plug#end()
