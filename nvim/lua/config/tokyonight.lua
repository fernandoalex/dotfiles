vim.cmd[[colorscheme tokyonight]]
-- transparency
vim.api.nvim_set_hl(0, "Normal", {guibg = NONE, ctermbg = NONE})

require("tokyonight").setup({
  -- use the night style
  style = "night",
})
