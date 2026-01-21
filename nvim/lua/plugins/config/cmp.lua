#!/usr/bin/env lua
--
-- FileName:     cmp
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-06-11 11:58:36
-- LastModified: 2025-12-14 16:41:31
-- Reference:    8ucchiman.jp
-- Description:  ---
--


local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip"},
        { name = "buffer" },
        { name = "path" },
    },
    mapping = cmp.mapping.preset.insert({
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif luasnip.expand_or_jumpable() then
        --         luasnip.expand_or_jump()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),

        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif luasnip.jumpable(-1) then
        --         luasnip.jump(-1)
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-l>'] = cmp.mapping.complete(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    experimental = {
        ghost_text = true,
    },
})
