" --- General

let mapleader = " "

syntax enable                           " enable syntax processing
set termguicolors                       " better colours
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent                         " enable autoindents
filetype indent on                      " filetype-specific indentation
set number                              " add line numbers
set numberwidth=1                       " columns used for line numbers
set relativenumber
set incsearch                           " highlight matched text when searching  
set nohlsearch                          " disable highlighting of search results
set mouse=a                             " enable mouse support
set ignorecase                          " default to case insensitive search
set smartcase                           " use case sensitive search if pattern includes uppercase letter
set noshowmode                          " hide default status line
set signcolumn=yes                      " enable column for signs such as gitsigns
set encoding=UTF-8                      " set utf8 as standard encoding
set wildmenu                            " enhance command menu completion
set cursorline                          " highlight the current line
set scrolloff=8                         " alway have 8 lines above/below
set hidden                              " easily keep multiple buffers
set clipboard=unnamedplus

" --- Plugins

call plug#begin('~/.config/nvim/plugged')

" General
Plug 'nvim-lua/plenary.nvim'            " dependency for multiple plugins
Plug 'dracula/vim',{'as':'dracula'}     " colour scheme
Plug 'joshdick/onedark.vim'
Plug 'nvim-lualine/lualine.nvim'        " status line
Plug 'kyazdani42/nvim-web-devicons'     " devicons
Plug 'nvim-tree/nvim-tree.lua'          " file explorer
Plug 'windwp/nvim-autopairs'            " autoclose brackets, parens...
Plug 'norcalli/nvim-colorizer.lua'      " highlight colours
Plug 'numToStr/Comment.nvim'            " commenting with gc
" Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
" Git
Plug 'lewis6991/gitsigns.nvim'          " signs of change since last commit
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'        " provides lsp guide in gh readme

call plug#end()

lua require('insidemordecai')

" --- Colours

colorscheme onedark
set background=dark                     " we like it dark     

" --- Undo and Swaps

set undofile                            " save undo history
set undodir=~/.config/nvim/undodir
set directory=~/.config/nvim/swaps
