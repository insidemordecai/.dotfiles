-- import gitsigns plugins safely
local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
    return
end

-- configure gitsigns
gitsigns.setup {
  current_line_blame = true,
  current_line_blame_opts = {
      virt_text_pos = 'right_align'
  },
  keymaps = {}
}
