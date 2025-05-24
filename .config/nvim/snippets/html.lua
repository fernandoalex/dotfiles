local luasnip = require("luasnip")
local s = luasnip.snippet
local i = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    s(
        ";;html:5", fmt([[
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, intial-scale=1.0">
            <title>Document</title>
        </head>
        <body>
        </body>
        </html>
        ]], {
        })
    )
}
