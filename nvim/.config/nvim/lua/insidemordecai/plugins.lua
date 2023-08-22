-- auto install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- auto run :PackerCompile when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- install plugins
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- packer can manage itself

  use 'nvim-lua/plenary.nvim' -- common dependancy
  use 'joshdick/onedark.vim' -- colour scheme
  use 'nvim-lualine/lualine.nvim' -- status line
  use 'kyazdani42/nvim-web-devicons' -- icons
  use 'nvim-tree/nvim-tree.lua' -- file tree
  use 'norcalli/nvim-colorizer.lua' -- highlight colours
  use 'numToStr/Comment.nvim' -- commenting with gc

  -- Git integration
  use 'lewis6991/gitsigns.nvim' -- show signs to the left

  --LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required (Snippets)
    }
  }

 -- Treesitter 
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  -- Auto closing
  use 'windwp/nvim-autopairs' -- auto close quotes, brackets...
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

  if packer_bootstrap then
    require('packer').sync()
  end
end)
