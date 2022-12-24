local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
    'html',
    'cssls',
    'sumneko_lua',
})

lsp.nvim_workspace()

lsp.setup()
