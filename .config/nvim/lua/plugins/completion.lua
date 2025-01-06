return {
    {
        'saghen/blink.cmp',
        version = '*',
        dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'default' },
            snippets = {
                expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
                active = function(filter)
                    if filter and filter.direction then
                        return require('luasnip').jumpable(filter.direction)
                    end
                    return require('luasnip').in_snippet()
                end,
                jump = function(direction) require('luasnip').jump(direction) end,
            },

            signature = { enabled = true },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'luasnip' },
            },
            completion = {
                documentation = {
                    auto_show = true,
                },
                menu = {
                    draw = {
                        treesitter = { 'lsp' }

                    }
                },
            }
        },
        -- opts_extend = { "sources.default" }
    },
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip.loaders.from_lua").load({
                paths = { "~/.config/nvim/snippets/" }
            })
        end
    }
}
