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

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[?] Find files' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[?] Find buffers' })
