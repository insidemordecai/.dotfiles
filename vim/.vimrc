set number						" add line numbers
filetype indent on				" add filetype-specific indentation
set laststatus=2
set mouse=a
syntax enable					" enable syntax processing
set ignorecase smartcase
set incsearch					" search as characters are entered
set nohlsearch					" remove highlight after completing search
set pastetoggle=<F3>			" toggle paste mode for proper indentation 
set wildmenu					" visual autocomplete for command menu

set tabstop=4 softtabstop=4
set shiftwidth=4

set cursorline
hi Cursorline term=none cterm=none ctermbg=8
hi CursorLineNr cterm=none ctermbg=8
" check https://github.com/NLKNguyen/papercolor-theme for colour numbers
