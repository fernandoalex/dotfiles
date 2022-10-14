require('telescope').setup{
	pickers = {
		find_files = {
			hidden = true,
		},
		defaults = { 
			file_ignore_patterns = { 
				"assets/",
				".git/",
				"/target/"
			}
		}
	}
}

require('telescope').load_extension('fzf')

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[?] Find files' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[?] Find buffers' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[?] Live grep' })
