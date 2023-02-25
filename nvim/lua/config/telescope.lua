require('telescope').setup{
	pickers = {
		find_files = {
			hidden = true,
		},
		defaults = {
			file_ignore_patterns = {
				"assets/",
				".git/",
				"*.jpg",
				"*.png",
				"/target/"
			}
		},
		git_bcommits = {
			git_command = {
				'git',
				'log',
				'--pretty=reference',
				'--date=short',
				'--abbrev-commit'
			}
		}
	}
}

require('telescope').load_extension('fzf')

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[?] Find files' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[?] Find buffers' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[?] Live grep' })
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').git_commits, { desc = '[?] Git Commits' })
vim.keymap.set('n', '<leader>fbc', require('telescope.builtin').git_bcommits, { desc = '[?] Buffer Git Commits' })
