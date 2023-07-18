-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- install plugins
return packer.startup(function(use)
  -- packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim' -- dependancy for multiple plugins
  use 'joshdick/onedark.vim' -- colour scheme
  use 'nvim-lualine/lualine.nvim' -- better status line
  use 'kyazdani42/nvim-web-devicons' -- devicons
  use 'nvim-tree/nvim-tree.lua' -- file explorer
  use 'norcalli/nvim-colorizer.lua' -- highlight colours
  use 'numToStr/Comment.nvim' -- commenting with gc

  -- Git
  use 'lewis6991/gitsigns.nvim' -- show changes to the left

  -- LSP
  use {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
          -- LSP Support
          {'neovim/nvim-lspconfig'},
          {'williamboman/mason.nvim'},
          {'williamboman/mason-lspconfig.nvim'},

          -- Autocompletion
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'saadparwaiz1/cmp_luasnip'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-nvim-lua'},

          -- Snippets
          {'L3MON4D3/LuaSnip'},

          -- Snippet Collection (Optional)
          {'rafamadriz/friendly-snippets'},
      }
  }

  -- Auto Closing
  use 'windwp/nvim-autopairs' -- autoclose parens quotes...
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

  if packer_bootstrap then
    require("packer").sync()
  end
end)
