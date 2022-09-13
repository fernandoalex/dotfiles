require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
  },
  ensure_installed = {
	  'norg',
	  'rust',
	  'go',
	  'python',
	  'php',
	  'yaml',
	  'json',
	  'query',
	  'lua',
	  'vim',
	  'markdown',
	  'bash'
	  }, 
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
