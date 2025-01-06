-- Great article on snippets
-- https://pcoves.gitlab.io/en/blog/nvim-snippets/

local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
return {
    s(
        { trig = ";;hello" },
        {
            t("Hello"),
        }
    ),
    s(
        { trig = ";;hello-node" },
        {
            t("Hello"),
            i(1, "World")
        }
    ),
}
