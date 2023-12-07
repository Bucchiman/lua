#!/usr/bin/env lua
--
-- FileName:     snippets
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-06-11 11:59:04
-- LastModified: 2023-12-07 15:55:21
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

function _(text)
    return tostring(text):gsub("^\t+", ""):gsub("\n\t+$", ""):gsub("(\n)\t+", "%1")
end

ls.add_snippets(nil, {
    all = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD time:to:sec",
        },{
            func(date, {}),
        }),
        snip({
            trig = "tldr",
            namr = "",
            dscr = "Too Long; Don't Read",
        },{
            func(function ()
                return "TL;DR"
            end, {})
        }),
        snip({
            trig = "oneline_temp",
            namr = "",
            dscr = "template for the onelines repo"
        },{
            func(function ()
                -- return "Command>\n\nArguments>\n\nTL;DR>\n\nKeywords>\n\nAlias>\n\nDescription>\nScene01>\nScene02>\nScene03>\n\nRelated>\n\nReference>\n\nLastModified> "
                return "Command>\\nArguments>TL;DR>Keywords>Alias>Description>Scene01>Scene02>Scene03>Related>Reference>LastModified> "
            end, {})
        }),
        -- snip({
        --     trig = "cron",
        --     namr = "",
        --     dscr = "systemd template"},
        --     {
        --         func(function ()
        --             return ""
        --         end, {})
        -- })
    }
})

require("luasnip.loaders.from_snipmate").load({
    paths = {
        "~/.config/local/snippets",
        "~/.config/snippets"
    }
})

