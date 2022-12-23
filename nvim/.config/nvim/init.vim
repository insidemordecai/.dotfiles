" --- General

let mapleader = " "

syntax enable           " enable syntax processing
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent         " enable autoindents
filetype indent on      " filetype-specific indentation
set number              " add line numbers
set numberwidth=1       " columns used for line numbers
set relativenumber
set incsearch           " highlight matched text when searching  
set nohlsearch          " disable highlighting of search results
set mouse=a             " enable mouse support
set ignorecase          " default to case insensitive search
set smartcase           " use case sensitive search if pattern includes uppercase letter
set noshowmode          " hide default status line
set signcolumn=yes      " enable column for signs such as gitsigns
set encoding=UTF-8      " set utf8 as standard encoding
set wildmenu            " enhance command menu completion

" --- Plugins

call plug#begin('~/.config/nvim/plugged')

" General
Plug 'dracula/vim',{'as':'dracula'}     " colour scheme
Plug 'nvim-lualine/lualine.nvim'        " status line
Plug 'kyazdani42/nvim-web-devicons'     " devicons
Plug 'nvim-tree/nvim-tree.lua'          " file explorer
" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

call plug#end()

lua require('insidemordecai')

" --- Colours

set termguicolors       " better colours
colorscheme dracula
set background=dark

" --- Undo and Swaps

set undofile            " save undo history
set undodir=~/.config/nvim/undodir
set directory=~/.config/nvim/swaps
