HOME = os.getenv("HOME")

-- for conciseness
local opt = vim.opt
local g = vim.g
local cmd = vim.cmd
local api = vim.api

-- general
opt.fileencoding = 'utf-8' -- set utf8 as default encoding
opt.number = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
api.nvim_command('filetype plugin indent on') -- filetype-specific indentation
opt.mouse = 'a' -- enable mouse support
opt.cursorline = true -- highlight current line
opt.scrolloff = 8 -- always have 8 line to screen edge above/below when scrolling
opt.signcolumn = 'yes' -- enable column for signs after numbers eg. git signs
opt.iskeyword:append("-") -- consider hello-world as whole word
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
opt.showmode = false -- hide default status line
opt.hidden = true -- easily keep multiple buffers

-- appearance
opt.termguicolors = true
opt.background = "dark" -- use dark variant of theme when available
cmd("colorscheme onedark")

-- searching
opt.incsearch = true -- highlight matched text when searching
opt.ignorecase = true -- default to case insensitive search
opt.smartcase = true -- use case sensitive search if pattern has uppercase letter
opt.hlsearch = false -- disable highlights after search

-- undo and swaps
opt.undofile = true -- save undo history
opt.undodir = HOME .. '/.vim/tmp/undo//'
opt.swapfile = false -- avoid creating temp files

-- map <leader> to space
g.mapleader = " "
g.maplocalleader = " "
