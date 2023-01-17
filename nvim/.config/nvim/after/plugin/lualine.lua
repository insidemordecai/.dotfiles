-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
    return
end

-- configure lualine
lualine.setup {
    options = {
        disabled_filetypes = {'NvimTree'}
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_diagnostic'}}},
        lualine_c = {'filename'},
        lualine_x = {'encoding'},
        lualine_y = {'location'},
        lualine_z = {'filetype'}
    }
}
