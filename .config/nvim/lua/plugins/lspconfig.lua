-- plugins and configs for lua
return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'saghen/blink.cmp',
        },
        config = function()
            vim.lsp.config("esling", {
                root_dir = require('lspconfig').util.root_pattern(
                    ".eslintrc",
                    ".eslintrc.js",
                    ".eslintrc.json",
                    "package.json"
                ),
            })
            vim.lsp.enable("eslint")
            vim.lsp.enable("ruff")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("terraformls")
            vim.lsp.enable("gopls")
            vim.lsp.enable("rust_analyzer")
        end
    },
}
