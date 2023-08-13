#!/usr/bin/env lua
--
-- FileName:     snippets
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-06-11 11:59:04
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://sbulav.github.io/vim/neovim-setting-up-luasnip/
-- Description:  ---
--



local ls = require("luasnip")
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function() return {os.date('%Y-%m-%d %X')} end


ls.add_snippets(nil, {
    all = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD time:to:sec",
        },{
            func(date, {}),
        }),
    }
})

require("luasnip.loaders.from_snipmate").load()
