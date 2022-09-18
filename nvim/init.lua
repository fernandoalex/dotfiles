-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- stylua: ignore start
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager

  -- Packages that are required by a bunch of stuff
  use 'nvim-lua/plenary.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
  use 'kyazdani42/nvim-web-devicons'

  -- theme
  use 'ellisonleao/gruvbox.nvim'

  -- lsp
  use 'neovim/nvim-lspconfig'

  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'

  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- misc
  use 'nvim-lualine/lualine.nvim'
  use 'gbprod/substitute.nvim'
  use {
	  'kylechui/nvim-surround',
	  config = function()
		  require("nvim-surround").setup()
	  end
  }
  use {
	  'akinsho/bufferline.nvim', 
	  requires = 'kyazdani42/nvim-web-devicons',
	  config = function()
		  require("bufferline").setup{}
	  end
  }
  use {
	  'numToStr/Comment.nvim',
	  config = function()
		  require('Comment').setup()
	  end
  }

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

require('config')
require('config.gruvbox')
require('config.treesitter')
require('config.telescope')
require('config.lualine')
require('config.completion')
