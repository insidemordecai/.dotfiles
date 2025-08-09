return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tailwindcss-language-server",
        "lua-language-server",
        "css-lsp",
        "html-lsp",
        "shfmt",
        "stylua",
      })
    end,
  },
}
