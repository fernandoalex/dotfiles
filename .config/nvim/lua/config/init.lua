-- [[ basic keymaps ]]
-- set <space> as the leader key
-- see `:help mapleader`
--  NOTE: must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.opt.mouse = "" -- disable mouse support
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.clipboard = "unnamedplus" -- share clipboard with system
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- needed for the autocomplete
vim.opt.termguicolors = true
vim.opt.foldlevel = 99
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.keymap.set('n', '<leader><leader>', '<c-^>', { desc = '[?] Open last file' })

vim.keymap.set('n', "<silent> <Esc>", ':nohlsearch<CR><CR>', { noremap = true}) -- clear search highlight

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux-jump.sh<CR>")

-- [[ basic plugins with no/simple custom config ]]
require("substitute").setup()
vim.keymap.set("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.keymap.set("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })

-- [[ harpoon remaps]]
vim.keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>ho", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { noremap = true })
vim.keymap.set("n", "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { noremap = true })
vim.keymap.set("n", "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { noremap = true })

-- [[ worktree configs]]
require("telescope").load_extension("git_worktree")
vim.keymap.set("n", "<leader>wl", "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>wc", "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", { noremap = true })

require("treesitter-context").setup()
require("nvim-autopairs").setup()

require('cloak').setup({
  enabled = true,
  cloak_character = '*',
  patterns = {
    {
      file_pattern = {
      		  -- Match any file starting with '.env'.
		  '.env*',
		  'credentials',
		  },
      -- Match an equals sign and any character after it.
      cloak_pattern = '=.+'
    },
  },
})

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<CR>", { noremap = true })

vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

require('litee.lib').setup()
require('litee.gh').setup()
require("focus").setup()
require('telescope').load_extension('gh')
require('refactoring').setup()

-- mail stuff
vim.opt_local.spell = true
vim.opt_local.spelllang = 'en_us'
vim.opt_local.fo:append('aw')
local map = vim.api.nvim_buf_set_keymap
local options = { noremap = true, silent = true}
map(0, 'n', '<leader>x', 'ZZ', options)

vim.api.nvim_set_keymap('n', '<leader>mfp', ':lua require("music").open_playlist_picker()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>mp', ':lua require("music").play_track()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>mP', ':lua require("music").pause_track()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>mn', ':lua require("music").next_track()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>mN', ':lua require("music").previous_track()<CR>', {noremap = true, silent = true})

_G.p = function(tbl)
  vim.api.nvim_out_write(vim.inspect(tbl) .. "\n")
end
