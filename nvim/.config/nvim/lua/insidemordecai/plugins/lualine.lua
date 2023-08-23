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
        lualine_c = {{
          'filename',
          file_status = true, --displays file status (readonly status, modified status)
          path = 0 -- 0 - just filename, 1 = relative path, 2 = absolute path
        }},
        lualine_x = {'encoding'}, 
        lualine_y = {'progress'},
        lualine_z = {'location'}
    }
  }
