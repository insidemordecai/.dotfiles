-- import autopairs plugin safely
local status, autopairs = pcall(require, "nvim-autopairs")
if (not status) then return end

-- configure autopair
autopairs.setup({
    disable_filetype = {"TelescopePrompt" , "vim"},
})
