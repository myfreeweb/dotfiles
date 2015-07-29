if !windows
	let g:plug_url_format = 'git@github.com:%s'
end

" GOPATH all the things. The option is added in vim/apply.sh because fuck everything.
" Only `Plug 'username/repo'` works with this setup. I don't care about other types of paths!
let g:plug_name_modifier = ':s?\.git$??'

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
	let g:make = 'make'
endif

call plug#begin('~/src/github.com')

" Languages
Plug 'sheerun/vim-polyglot'
Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }
Plug 'jceb/vim-orgmode', { 'for': 'org' }
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'ledger/vim-ledger', { 'for': 'ledger' }
Plug 'brandonbloom/vim-factor', { 'for': 'factor' }
Plug 'amirh/HTML-AutoCloseTag', { 'for': 'html' }
if executable('perl')
	Plug 'vim-perl/vim-perl', { 'for': ['perl', 'tt2', 'tt2html', 'tt2js', 'tap'] }
endif
if executable('npm')
	Plug 'marijnh/tern_for_vim', { 'for': ['js', 'jsx', 'javascript', 'html', 'jade', 'haml'], 'do': 'npm install --update' }
endif
if executable('latex')
	Plug 'lervag/vimtex', { 'for': ['tex', 'latex'] }
endif
if executable('python')
	Plug 'davidhalter/jedi-vim', { 'for': 'python', 'do': 'git submodule update --init' }
	Plug 'nvie/vim-flake8', { 'for': 'python' }
endif
if executable('go')
	Plug 'fatih/vim-go', { 'for': 'go' }
endif
if executable('idris')
	Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
endif
if executable('ghc') " Haskell
	Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
	Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
	Plug 'dag/vim2hs', { 'for': 'haskell' }
endif
if executable('cargo') " Rust
	Plug 'phildawes/racer', { 'for': 'rust', 'do': 'cargo build --release' }
endif
if executable('mono') " .NET
	Plug 'OrangeT/vim-csharp', { 'for': 'cs' }
	Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs' }
	Plug 'kongo2002/fsharp-vim', { 'for': 'fsharp' }
endif

" Features
Plug 'Shougo/vimproc', { 'do': g:make }
Plug 'Shougo/neocomplcache.vim' " doesn't require if_lua, which isn't supported in neovim
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'tsukkee/unite-tag'
Plug 'ujihisa/unite-haskellimport'
Plug 'sanford1/unite-unicode'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sleuth'
Plug 'sjl/strftimedammit.vim'
Plug 'sjl/gundo.vim', { 'on': ['GundoShow', 'GundoToggle'] }
Plug 'sjl/splice.vim', { 'on': ['SpliceInit'] }
Plug 'sjl/vitality.vim'
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/argtextobj.vim'
Plug 'godlygeek/tabular'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'sickill/vim-pasta'
Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'benmills/vimux'
Plug 'mhinz/vim-startify'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'reedes/vim-wordy'

" Colors
Plug 'chriskempson/base16-vim'

call plug#end()
