vim.cmd[[colorscheme kanagawa]]
-- transparency
vim.api.nvim_set_hl(0, "Normal", {guibg = NONE, ctermbg = NONE})

require("kanagawa").setup({
  -- use the night style
  style = "night",
})
