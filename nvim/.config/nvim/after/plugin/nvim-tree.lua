local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

vim.g.nvim_tree_indent_markers = 1 -- this option shows indent markers when folders are open

-- recommended according to nvim-tree docs
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup {
    view = {
        adaptive_size = true,
    }
}

vim.api.nvim_set_keymap('n', '<Leader>n', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
