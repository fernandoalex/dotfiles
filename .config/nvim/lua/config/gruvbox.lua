vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
-- transparency
-- vim.api.nvim_set_hl(0, "Normal", {guibg = NONE, ctermbg = NONE})

require("gruvbox").setup({})
