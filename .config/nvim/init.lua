-- TODO: try lazy
-- TODO: Disable NoNeckPain when DBUI
-- TODO: Disable NoNeckPain when DAP
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

    -- use 'xiyaowong/transparent.nvim'
    use 'MunifTanjim/nui.nvim'
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'nvim-treesitter/playground'

    use { 'nvim-telescope/telescope.nvim', 
        requires = { 
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-github.nvim'
        } 
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }


    use 'kyazdani42/nvim-web-devicons'
    use {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup({
                background_colour = "#000000"
            })
        end
    }

    -- theme
    use 'ellisonleao/gruvbox.nvim'
    -- use 'folke/tokyonight.nvim'
    -- use "rebelot/kanagawa.nvim"
    use 'craftzdog/solarized-osaka.nvim'

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
    use 'tpope/vim-fugitive'
    use 'NeogitOrg/neogit'
    use 'sindrets/diffview.nvim'

    -- snippets
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- terraform
    use 'hashivim/vim-terraform' -- non-native
    -- use 'ANGkeith/telescope-terraform-doc.nvim'

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

    -- use {
    --  'akinsho/bufferline.nvim',
    --  requires = 'kyazdani42/nvim-web-devicons',
    --     tag = "*",
    --  config = function()
    --   require("bufferline").setup({})
    --  end
    -- }
    --
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use 'norcalli/nvim-colorizer.lua'
    use 'ThePrimeagen/vim-be-good'
    use 'ThePrimeagen/harpoon'
    -- use 'ThePrimeagen/git-worktree.nvim'
    use 'fernandoalex/git-worktree.nvim'
    use {
        'folke/noice.nvim',
        config = function ()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    -- command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            kind = "",
                            find = "written",
                        },
                        opts = { skip = true },
                    },
                },
            })
        end
    }
    use 'mbbill/undotree'
    use 'laytan/cloak.nvim'

    -- test
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'nvim-neotest/nvim-nio'
    use { "theHamsta/nvim-dap-virtual-text", config = function()
        require("nvim-dap-virtual-text").setup({})
    end }

    use 'stevearc/dressing.nvim'
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end }
    use { "lukas-reineke/indent-blankline.nvim",
        config = function ()
            require('ibl').setup{}
        end
    }
    use {
        'ldelossa/gh.nvim',
        requires = { { 'ldelossa/litee.nvim' } }
    }
    use { 'folke/neodev.nvim',
        config = function ()
            require('neodev').setup()
        end,
    }
    -- use {
    --       "shortcuts/no-neck-pain.nvim",
    --       config = function ()
    --           -- TODO: this breaks with other plugins that create splits
    --           -- I am pretty sure we can run code on events on neovim, so
    --           -- it is probably possible to use that to fix some
    --           require("no-neck-pain").setup({
    --               width = 80,
    --               autocmds = {
    --                   enableOnVimEnter = true,
    --               },
    --           })
    --       end,
    --       tag = "*"
    --   }
    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use 'nvim-tree/nvim-tree.lua'
    -- use {
    --   "ahmedkhalf/project.nvim",
    --   config = function()
    --     require("project_nvim").setup {}
    --   end
    -- }
    use 'nvim-focus/focus.nvim'
    -- is there a full lua version?
    use 'tpope/vim-abolish'
    use 'tpope/vim-dadbod'
    use 'kristijanhusak/vim-dadbod-ui'
    use 'tpope/vim-unimpaired'

    use 'David-Kunz/gen.nvim'
    use({
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                view_options = {
                    show_hidden = true,
                }
            })
        end,
    })

    use 'phelipetls/jsonpath.nvim'

    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    }
    use {
        "S1M0N38/love2d.nvim",
        config = function ()
            require('love2d').setup({
                path_to_love_bin = "/Applications/love.app/Contents/MacOS/love"
            })
        end

    }
    -- whyyyy
    -- use 'fernandoalex/music.nvim'
    use '~/personal/music.nvim.git/main/'

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
require('config.osaka')
-- require('config.tokyonight')
-- require('config.kanagawa')
require('config.treesitter')
require('config.telescope')
require('config.lualine')
require('config.completion')
require('config.tools-git')
require('config.tools-lsp')
require('config.language-terraform')
require('config.language-rust')
require('config.language-go')
-- require('config.language-html-css')
-- require('config.language-java')
require('config.tools-dap')
--
-- vim.opt_local.spell = true
-- vim.opt_local.spelllang = 'en_us'
-- vim.opt_local.fo:append('aw')
-- local map = vim.api.nvim_buf_set_keymap
-- local options = { noremap = true, silent = true}
-- map(0, 'n', '<leader>x', 'ZZ', options)
