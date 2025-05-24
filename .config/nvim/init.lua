require("config.lazy")
require("config.custom")

-- options
vim.opt.mouse = "" -- disable mouse support
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus" -- share clipboard with system
vim.opt.ignorecase = true         -- Ignore case when searching
vim.opt.foldlevel = 99
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.colorcolumn = "80"
vim.opt.hlsearch = false
vim.opt.scrolloff = 999

-- keymaps
vim.keymap.set("n", "<leader>xs", "<cmd>source %<CR>") -- TODO: Add description
vim.keymap.set("n", "<leader>x", ":.lua<CR>")          -- TODO: Add description
vim.keymap.set("v", "<leader>x", ":lua<CR>")           -- TODO: Add description

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[?] Find files' })
vim.keymap.set('n', '<leader>fbb', require('telescope.builtin').buffers, { desc = '[?] Find buffers' })
vim.keymap.set('n', '<leader>fbc', require('telescope.builtin').git_bcommits, { desc = '[?] Buffer Git Commits' })
vim.keymap.set('n', '<leader>fg',
    ":lua require('config.multigrep').live_multigrep(require('telescope.themes').get_ivy({}))<CR>",
    { desc = '[?] Live grep' })
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').git_commits, { desc = '[?] Git Commits' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags) -- TODO: Add description
-- search nvim config files

--[[ TODO: tree-sitter text objects for quickly jumping to outer function definition
-- usefull for quickly getting docs of the function you are in
]] --

vim.keymap.set('n', '<leader>en', function()
    require('telescope.builtin').find_files {
        desc = '[?] Find files for nvim config',
        cwd = "~/dotfiles"

    }
end)

vim.keymap.set('n', '<leader>ep', function()
    require('telescope.builtin').find_files {
        desc = '[?] Find files in Lazy folder',
        cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
    }
end)


vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>ho", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { noremap = true })

vim.keymap.set("n", "s", require('substitute').operator, { noremap = true })
vim.keymap.set("n", "ss", require('substitute').line, { noremap = true })
vim.keymap.set("n", "S", require('substitute').eol, { noremap = true })
vim.keymap.set("x", "s", require('substitute').visual, { noremap = true })

vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>", { noremap = true })

vim.keymap.set("n", "<leader>no", "<cmd>lua require('neogit').open({kind = 'vsplit'})<cr>", { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>mfp', ':lua require("music").open_playlist_picker()<CR>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>mp', ':lua require("music").play_track()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>mP', ':lua require("music").pause_track()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>mn', ':lua require("music").next_track()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>mN', ':lua require("music").previous_track()<CR>',
    { noremap = true, silent = true })


-- call tmux jump from nvim
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux-jump.sh<CR>")
vim.treesitter.language.register("html", "handlebars")
