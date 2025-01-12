local luasnip = require("luasnip")
local s = luasnip.snippet
local i = luasnip.insert_node

return {
    s(
        ";;err", fmt([[
        if err != nil {{
            fmt.Println("{}")
            return err
        }}
        ]], {
            i(1, "Error message"),
        })
    )
}
