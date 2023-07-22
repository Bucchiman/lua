#!/usr/bin/env lua
--
-- FileName:     snippets
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-06-11 11:59:04
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    8ucchiman.jp
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

local date = function() return {os.date('%Y-%m-%d')} end

ls.add_snippets(nil, {
    all = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        },{
            func(date, {}),
        })
    }
})

require("luasnip.loaders.from_snipmate").load()
