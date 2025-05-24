local luasnip = require("luasnip")
local s = luasnip.snippet
local i = luasnip.insert_node
local f = luasnip.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    s(
        ";;cornell", fmt([[
# Topic: {}
## Date: {}

---

## Cue Column

- {}

---

## Notes

- {}

---

## Summary

{}
]], {
            i(1, "Topic here"),
            f(function() return os.date("%Y-%m-%d") end, {}),
            i(2, "Key points / questions"),
            i(3, "Detailed notes"),
            i(4, "Summary")
        }))
}
