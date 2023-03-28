local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
    'html',
    'cssls',
    'lua_ls'
})

lsp.nvim_workspace()

lsp.setup()
