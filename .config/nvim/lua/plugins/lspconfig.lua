-- plugins and configs for lua
return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'saghen/blink.cmp',
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require("lspconfig").eslint.setup({ capabilities = capabilities })
            require("lspconfig").superhtml.setup({ capabilities = capabilities })
            require("lspconfig").htmx.setup({ capabilities = capabilities })
            require("lspconfig").ruff.setup({ capabilities = capabilities })
            require("lspconfig").lua_ls.setup({ capabilities = capabilities })
            require("lspconfig").terraformls.setup({ capabilities = capabilities })
            require("lspconfig").gopls.setup({ capabilities = capabilities })
        end
    },
}
