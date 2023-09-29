require('telescope').setup{
	extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
		}
	},
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

vim.keymap.set('n', '<leader>fo',":lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') })<CR>", { desc = '[?] Find files' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[?] Find files' })
vim.keymap.set('n', '<leader>fbb', require('telescope.builtin').buffers, { desc = '[?] Find buffers' })
vim.keymap.set('n', '<leader>fbc', require('telescope.builtin').git_bcommits, { desc = '[?] Buffer Git Commits' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[?] Live grep' })
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').git_commits, { desc = '[?] Git Commits' })
