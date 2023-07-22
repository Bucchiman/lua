-- FileName:     lazy
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-06-03 15:39:49
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://github.com/MiaadTeam/lesvim/blob/main/lua/lazy/plugins.lua
-- Description:  ---
--

--#region
--  Reference: https://github.com/folke/lazy.nvim
--#endregion
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
-----------------------------------------------------------

local venv = os.getenv("VIRTUAL_ENV")

require("lazy").setup({
    'mfussenegger/nvim-dap',
    {
        'rcarriga/nvim-dap-ui',
        config = function()
            require("dapui").setup({
                icons = { expanded = "", collapsed = "" },
                layouts = {
                    {
                        elements = {
                            { id = "watches", size = 0.20 },
                            { id = "stacks", size = 0.20 },
                            { id = "breakpoints", size = 0.20 },
                            { id = "scopes", size = 0.40 },
                    },
                    size = 64,
                    position = "right",
                },
                {
                    elements = {
                        "repl",
                        "console",
                    },
                    size = 0.20,
                    position = "bottom",
                },
            },
        })
        end
    },
    {
        'mfussenegger/nvim-dap-python',
        config = function()
            require("dap-python").setup(venv .. "/bin/python")
        end
    },
    {
        'catppuccin/nvim',
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
            })
        end
    },
    {
        'williamboman/mason.nvim',
        config = function()
            require("mason").setup()
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls"}
            })
        end
    },
    --#region
    --  Reference: https://github.com/hrsh7th/nvim-cmp
    --#endregion
    {
        'neovim/nvim-lspconfig'
    },
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    -- For luasnip users
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    {
        'hrsh7th/nvim-cmp',
        config = function ()
            require("cmp").setup({
                snippet = {
                  -- REQUIRED - you must specify a snippet engine
                  expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                  end,
                },
                window = {
                  -- completion = cmp.config.window.bordered(),
                  -- documentation = cmp.config.window.bordered(),
                },
                -- mapping = cmp.mapping.preset.insert({
                --   ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
                --   ['<C-Space>'] = cmp.mapping.complete(),
                --   ['<C-e>'] = cmp.mapping.abort(),
                --   ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                -- }),
                -- sources = cmp.config.sources({
                --   { name = 'nvim_lsp' },
                --   { name = 'vsnip' }, -- For vsnip users.
                --   -- { name = 'luasnip' }, -- For luasnip users.
                --   -- { name = 'ultisnips' }, -- For ultisnips users.
                --   -- { name = 'snippy' }, -- For snippy users.
                -- }, {
                --   { name = 'buffer' },
                -- })
            })
        end
    },
})

vim.api.nvim_set_keymap('n', '<F5>', ':DapContinue<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':DapStepOver<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':DapStepInto<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':DapStepOut<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':DapToggleBreakpoint<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>B', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require("dap").run_last()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', ':lua require("dapui").toggle()<CR>', {})

vim.cmd.colorscheme "catppuccin"


require("plugins.config.lspconfig")


