-- recommended according to nvim-tree docs
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("insidemordecai.base")
require("insidemordecai.plugins")

require("insidemordecai.plugins.nvim-tree")
require("insidemordecai.plugins.lualine")
require("insidemordecai.plugins.colorizer")
require("insidemordecai.plugins.comment")
require("insidemordecai.plugins.gitsigns")
require("insidemordecai.plugins.lsp")
require("insidemordecai.plugins.autopairs")
require("insidemordecai.plugins.treesitter")
