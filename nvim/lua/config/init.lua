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

vim.keymap.set('i', '<C-j>', '<Esc>', { desc = '[?] Ctrl-J to Esc' })
vim.keymap.set('n', '<leader><leader>', '<c-^>', { desc = '[?] Open last file' })

vim.keymap.set('n', "<silent> <Esc>", ':nohlsearch<CR><CR>', { noremap = true}) -- clear search highlight

vim.keymap.set("n", "<C-f>", ":silent !tmux neww tmux-jump.sh<CR>", { noremap = true }) -- trigger tmux-jump

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

vim.keymap.set("n", "<leader>tt", "<cmd>lua require('nvim-tree.api').tree.toggle()<cr>", { noremap = true })

vim.opt.list = true
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    show_end_of_line = true,
}

require('litee.lib').setup()
require('litee.gh').setup()
