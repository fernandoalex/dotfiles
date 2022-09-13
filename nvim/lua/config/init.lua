-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus" -- share clipboard with system

vim.keymap.set('i', '<C-j>', '<Esc>', { desc = '[?] Ctrl-J to Esc' })
vim.keymap.set('n', '<leader><leader>', '<c-^>', { desc = '[?] Open last file' })

-- basic plugins with no/simple custom config
require("substitute").setup()
vim.keymap.set("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.keymap.set("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })

require("nvim-surround").setup()
