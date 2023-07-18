#!/usr/bin/env lua
--
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

--require("lazy").setup(plugins, opts)
local img_previewer = vim.fn.executable("ueberzug") == 1 and { "ueberzug" } or { "viu", "-b" }

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("lazy").setup(
{
    "kkharji/sqlite.lua",
    "folke/which-key.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/playground",
    "folke/neodev.nvim",
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
    'theHamsta/nvim-dap-virtual-text',
    -- "leoluz/nvim-dap-go",
    "lervag/vimtex",
    "Pocco81/DAPInstall.nvim",
    "jbyuki/nabla.nvim",
    'rcarriga/nvim-notify',
    {
        "dpayne/CodeGPT.nvim",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
        config = function()
            require("codegpt.config")
        end
    },
    {
        "folke/neoconf.nvim", cmd = "Neoconf"
    },
    {
        "uhooi/uhooi.nvim",
        config = function()
            require("uhooi").setup()
        end
    },
    {
        'glacambre/firenvim',

        -- Lazy load firenvim
        -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
        cond = not not vim.g.started_by_firenvim,
        build = function()
            require("lazy").load({ plugins = "firenvim", wait = true })
            vim.fn["firenvim#install"](0)
        end
    },
    {
        "catppuccin/nvim", name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = { -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = true,
                show_end_of_buffer = false, -- show the '~' characters after the end of buffers
                term_colors = false,
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.15,
                },
                no_italic = false, -- Force no italic
                no_bold = false, -- Force no bold
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
                color_overrides = {},
                custom_highlights = {},
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    notify = false,
                    mini = false,
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            })
        end
    },
    {
        "mfussenegger/nvim-dap",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            'mfussenegger/nvim-dap',
        },
    },
    {
        'mfussenegger/nvim-dap-python',
        config = function()
            require('dap-python').setup('$HOME/general_venv/bin/python')
        end
    },
    {
        'glepnir/template.nvim', cmd = {
            'Template','TemProject'
        },
        config = function()
            require('template').setup({
                temp_dir = "$HOME/.config/template",
                author = "8ucchiman",
                email = "8ucchiman@gmail.com",
            })
        end
    },
    {
      "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup()
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },
    {
        -- OK(05/22)
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            -- Helpers to install LSPs and maintain them
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
    },
    {
        -- OK(05/22)
        "williamboman/mason.nvim",
        dependencies = {
          "williamboman/mason-lspconfig.nvim",
          "jose-elias-alvarez/null-ls.nvim",
          "jay-babu/mason-null-ls.nvim",
        },
    },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            require('config.cmp')
        end,
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    },
    {
        'L3MON4D3/LuaSnip',
        after = 'nvim-cmp',
        config = function()
            require('config.snippets')
        end,
    },
    -- Nvimtree (File Explorer)
    {
        'nvim-tree/nvim-tree.lua',
        version = "*",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                  width = 30,
                },
                renderer = {
                  group_empty = true,
                },
                filters = {
                  dotfiles = true,
                },
            })
        end,
    },

    -- Telescope (Fuzzy Finder)
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        dependencies = {
            {'nvim-lua/plenary.nvim'},
        }
    },
    {
        "princejoogie/chafa.nvim",
        dependencies = {
            {"nvim-lua/plenary.nvim"},
            {"m00qek/baleia.nvim"}
        },
        config = function()
            require("chafa").setup({
                render = {
                    min_padding = 5,
                    show_label = true,
                },
                events = {
                    update_on_nvim_resize = true,
                }
            })
        end,
    },
    {
        "edluffy/hologram.nvim",
        config = function()
            require('hologram').setup{
                auto_display = true -- WIP automatic markdown image display, may be prone to breaking
            }
        end
    },
    {
        "ibhagwan/fzf-lua",
        config = function()
            require("fzf-lua").setup({
                previewers = {
                    builtin = {
                        ueberzug_scaler = "cover",
                        extensions = {
                        ["gif"] = img_previewer,
                        ["png"] = img_previewer,
                        ["jpg"] = img_previewer,
                        ["jpeg"] = img_previewer,
                        },
                    },
                },
            })
        end
    },
    {
        "dcampos/nvim-snippy",
        config = function()
            require('snippy').setup({
                mappings = {
                    is = {
                        ['<Tab>'] = 'expand_or_advance',
                        ['<S-Tab>'] = 'previous'
                    },
                    nx = {
                        ['<leader>x'] = 'cut_text',
                    },
                },
            })
        end
    },
    {
	    "L3MON4D3/LuaSnip",
	    -- follow latest release.
	    version = "1.2.1.*",
	    -- install jsregexp (optional!).
	    build = "make install_jsregexp"
    }
})

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local snippy = require("snippy")

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip"},
        -- { name = "buffer" },
        -- { name = "path" },
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif snippy.can_expand_or_advance() then
                snippy.expand_or_advance()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    endendcmp.select_prev_item()
                elseif snippy.can_jump(-1) then
                    snippy.previous()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ['<C-l>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm { select = true },
        }),
        experimental = {
            ghost_text = true,
        },
    })

-- require("chafa").setup({
--     render = {
--         min_padding = 5,
--         show_label = true,
--     },
--     events = {
--         update_on_nvim_resize = true,
--     }
-- }

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
require("plugins.template")
-- require("plugins.dap")
require("plugins.chatgpt")
require("plugins.lspconfig")
require("plugins.telescope")
