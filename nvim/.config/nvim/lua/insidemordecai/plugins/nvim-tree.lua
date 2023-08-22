-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

-- configure nvim-tree
vim.g.nvim_tree_indent_markers = 1 -- this option shows indent markers when folders are open

nvimtree.setup {}

vim.api.nvim_set_keymap('n', '<Leader>n', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
