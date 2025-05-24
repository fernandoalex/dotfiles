return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        config = function()
            require('telescope').setup {
                pickers = {
                    find_files = {
                        theme = "ivy",
                        hidden = true,
                    },
                    live_grep = {
                        theme = "ivy",
                    },
                    helpt_tags = {
                        theme = "ivy",
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
                },
                extensions = {
                    fzf = {}
                }
            }

            require('telescope').load_extension('fzf')
        end
    }
}
