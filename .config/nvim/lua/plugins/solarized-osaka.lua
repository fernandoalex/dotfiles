return {
    {
        "craftzdog/solarized-osaka.nvim",
        -- dir = "~/personal/solarized-osaka.nvim.git/main/",
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd [[colorscheme automata]]
            vim.cmd [[colorscheme solarized-osaka]]
        end
    }
}
