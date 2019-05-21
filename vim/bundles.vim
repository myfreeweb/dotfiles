" Only `Plug 'username/repo'` works with this setup.
" NOTE: Plug itself is patched in vim/apply.sh!
let g:plug_name_modifier = ':s?\.git$??'

call plug#begin('~/src/github.com')

" Languages
let g:polyglot_disabled = ['latex', 'jsx']
Plug 'sheerun/vim-polyglot'
Plug 'vmchale/ion-vim'
Plug 'joker1007/vim-ruby-heredoc-syntax'
Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'ledger/vim-ledger', { 'for': 'ledger' }
Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] }
Plug 'jceb/vim-orgmode', { 'for': ['org'] }
Plug 'ziglang/zig.vim', { 'for': 'zig' }
Plug 'igankevich/mesonic'
Plug 'jonsmithers/vim-html-template-literals', { 'for': 'javascript' }
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
Plug 'itchyny/vim-haskell-indent', { 'for': 'haskell' }
if executable('latex')
	Plug 'lervag/vimtex', { 'for': ['tex', 'latex'] }
endif
if isdirectory($HOME.'/src/scm.gforge.inria.fr/anonscm/git/why3/why3/share/vim')
	Plug '~/src/scm.gforge.inria.fr/anonscm/git/why3/why3/share/vim'
endif

" Features
Plug 'Shougo/vimproc.vim', { 'do': 'gmake' }
Plug 'Shougo/denite.nvim' " Unite (fuzzy finder for many things) but fast
if has('nvim')
	Plug 'neoclide/coc.nvim' " XXX: coc#util#install() hangs
endif
Plug 'samuelsimoes/vim-drawer' " Make buffers tab-local
Plug 'moll/vim-bbye' " Good buffer close
Plug 'tpope/vim-unimpaired' " ']q' to :cnext, etc.
Plug 'tpope/vim-speeddating' " Ctrl-A/X to increment dates/times
Plug 'tpope/vim-surround' " 'cs' to 'c'hange 's'urrounding brackets/etc
Plug 'tpope/vim-endwise' " Auto 'end' in Ruby/Lua/etc
Plug 'tpope/vim-abolish' " Smart case %S substitution, etc
Plug 'tpope/vim-commentary' " 'gc' to toggle comment
Plug 'tpope/vim-eunuch' " :Remove, :SudoWrite etc.
Plug 'tpope/vim-repeat' " Enable . repeating for plugins
Plug 'tpope/vim-sleuth' " Autodetect indent
Plug 'tpope/vim-rsi' " Readline key bindings in command prompts & insert mode
Plug 'jeetsukumaran/vim-filebeagle' " Simple file explorer without netrw's bugs
Plug 'mbbill/undotree', { 'on': ['UndotreeToggle'] } " Undo tree
Plug 'DougBeney/pickachu' " :Pick color/date/file with zenity/qarma
Plug 'ap/vim-css-color' " Highlight colors in the editor
Plug 'jreybert/vimagit' " Interactive git commit
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'Raimondi/delimitMate'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'sickill/vim-pasta'
Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'

" Colors
Plug 'chriskempson/base16-vim'

call plug#end()
