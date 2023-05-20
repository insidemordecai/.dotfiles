HOME = os.getenv("HOME")

-- for conciseness
local o = vim.opt
local g = vim.g

-- general
o.termguicolors = true -- better colours
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.autoindent = true
vim.api.nvim_command('filetype plugin indent on') -- filetype-specific indentation
o.number = true -- add line numbers
o.relativenumber = true
o.numberwidth = 1 -- columns used for line numbers
o.mouse = 'a' -- enable mouse support
o.showmode = false -- hide default status line
o.signcolumn = 'yes' -- enable column for signs eg. gitsigns
o.wildmenu = true -- enhance command menu completion
o.cursorline = true -- highlight current line
o.scrolloff = 8 -- always have 8 lines above/below
o.hidden = true -- easily keep multiple buffers
o.clipboard = 'unnamedplus' -- make nvim and host clipboard work well
o.fileencoding = 'utf-8' -- set utf8 as standard encoding
o.iskeyword:append("-") -- consider string-string as whole word
o.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
o.wrap = false -- disable word wrapping

-- searching
o.incsearch = true -- highlight matched text when searching
o.ignorecase = true -- default to case insensitive search
o.smartcase = true -- use case sensitive search if pattern has uppercase letters
o.hlsearch = false -- disable highlights after search

-- colours
vim.cmd('colorscheme onedark')
o.background = "dark" -- we like it dark

-- undo and swaps
o.undofile = true -- save undo history
o.undodir = HOME .. '/.vim/tmp/undo//'
o.swapfile = false -- avoid creating temp files

-- map <leader> to space
g.mapleader = " "
g.maplocalleader = " "
