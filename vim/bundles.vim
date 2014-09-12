filetype off
set rtp+=~/.vim/bundle/vundle/
let g:vundle_default_git_proto = 'git'
call vundle#begin()

Plugin 'gmarik/vundle'

" Languages
Plugin 'sheerun/vim-polyglot'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'brandonbloom/vim-factor'
Plugin 'fatih/vim-go'
"" Web
Plugin 'mxw/vim-jsx'
Plugin 'amirh/HTML-AutoCloseTag'
"" Haskell
Plugin 'ujihisa/neco-ghc'
Plugin 'eagletmt/ghcmod-vim'
"" Python
Plugin 'nvie/vim-flake8'
Plugin 'fs111/pydoc.vim'

" Features
Plugin 'Shougo/vimproc'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimfiler.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'sjl/strftimedammit.vim'
Plugin 'sjl/gundo.vim'
Plugin 'sjl/splice.vim'
Plugin 'sjl/vitality.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-scripts/argtextobj.vim'
Plugin 'godlygeek/tabular'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'sickill/vim-pasta'
Plugin 'itchyny/lightline.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ervandew/supertab'

" Colors
Plugin 'chriskempson/base16-vim'

call vundle#end()
filetype plugin indent on
