if !windows
	let g:plug_url_format = 'git@github.com:%s'
end

call plug#begin('~/.vim/bundle')

" Languages
Plug 'sheerun/vim-polyglot'
Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }
Plug 'brandonbloom/vim-factor', { 'for': 'factor' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'kongo2002/fsharp-vim', { 'for': 'fsharp' }
Plug 'ledger/vim-ledger', { 'for': 'ledger' }
Plug 'lervag/vim-latex', { 'for': 'tex' }
"" Web
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'amirh/HTML-AutoCloseTag', { 'for': 'html' }
"" Haskell
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'dag/vim2hs', { 'for': 'haskell' }
"" Python
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'fs111/pydoc.vim', { 'for': 'python' }

" Features
Plug 'Shougo/vimproc', { 'do': 'gmake \|\| make' }
Plug 'Shougo/neocomplcache.vim' " doesn't require if_lua, which isn't in neovim
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

" Colors
Plug 'chriskempson/base16-vim'

call plug#end()
