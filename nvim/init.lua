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

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-treesitter/playground'

  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
  use {
	  'nvim-telescope/telescope-fzf-native.nvim',
	  run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  use 'kyazdani42/nvim-web-devicons'
  use 'rcarriga/nvim-notify'

  -- theme
  -- use 'ellisonleao/gruvbox.nvim'
  use 'folke/tokyonight.nvim'

  -- -- lsp
  use { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  requires = {
	  -- Automatically install LSPs to stdpath for neovim
	  'williamboman/mason.nvim',
	  'williamboman/mason-lspconfig.nvim',

	  -- Useful status updates for LSP
	  'j-hui/fidget.nvim',
  },
  }

  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'

  -- git
  use 'lewis6991/gitsigns.nvim'
  use 'TimUntersberger/neogit'
  use 'sindrets/diffview.nvim'

  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- terraform
  use 'hashivim/vim-terraform' -- non-native
  use 'ANGkeith/telescope-terraform-doc.nvim'

  -- rust
  use 'simrat39/rust-tools.nvim'

  -- go
  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua'

  -- misc
  use 'windwp/nvim-autopairs'
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

  use 'nvim-neorg/neorg'
  use 'nvim-neorg/neorg-telescope'
  use 'norcalli/nvim-colorizer.lua'
  use 'ThePrimeagen/vim-be-good'
  use 'ThePrimeagen/harpoon'
  use 'mbbill/undotree'
  use 'laytan/cloak.nvim'

  -- test
  use 'stevearc/dressing.nvim'

  -- is there a full lua version?
  use 'tpope/vim-abolish'
  use 'laytan/cloak.nvim'

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
-- require('config.gruvbox')
require('config.tokyonight')
require('config.treesitter')
require('config.telescope')
require('config.lualine')
require('config.completion')
require('config.norg')
require('config.tools-git')
require('config.tools-lsp')
-- require('config.language-terraform')
-- require('config.language-rust')
-- require('config.language-go')
-- require('config.language-html-css')
-- require('config.language-java')
