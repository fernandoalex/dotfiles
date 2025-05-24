-- plugins and configs for lua
return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'saghen/blink.cmp',
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require("lspconfig").eslint.setup({
                capabilities = capabilities,
                -- cmd = { "eslint", "--stdin" },
                -- filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
                root_dir = require('lspconfig').util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json",
                    "package.json"),
                -- settings = {
                --     packageManager = "npm",
                --     workingDirectory = { mode = "auto" },
                --     format = { enable = true },
                --     lint = { enable = true },
                -- },
                -- flags = {
                --     allow_incremental_sync = false,
                --     debounce_text_changes = 1000,
                -- },
                -- on_attach = function(client, bufnr)
                --     print("ESLint LSP attached to buffer " .. bufnr)
                -- end,
                -- on_init = function(client)
                --     print("ESLint LSP initialized")
                -- end,
                -- -- Add callback to see what's happening
                -- on_exit = function(code, signal, client_id)
                --     print("ESLint server exited with code: " .. code .. " and signal: " .. signal)
                -- end,
            })
            -- require("lspconfig").superhtml.setup({ capabilities = capabilities })
            -- require("lspconfig").htmx.setup({ capabilities = capabilities })
            require("lspconfig").ruff.setup({ capabilities = capabilities })
            require("lspconfig").lua_ls.setup({ capabilities = capabilities })
            require("lspconfig").terraformls.setup({ capabilities = capabilities })
            require("lspconfig").gopls.setup({ capabilities = capabilities })
            require("lspconfig").rust_analyzer.setup({ capabilities = capabilities })
        end
    },
}
