

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

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
--require("lazy").setup(plugins, opts)

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
    --'mfussenegger/nvim-dap',
    'theHamsta/nvim-dap-virtual-text',
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "lervag/vimtex",
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
        'mfussenegger/nvim-dap',
        config = function()
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
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            -- Helpers to install LSPs and maintain them
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
          "williamboman/mason-lspconfig.nvim",
          "jose-elias-alvarez/null-ls.nvim",
          "jay-babu/mason-null-ls.nvim",
        },
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
    -- Nvimtree (File Explorer)
    {
        'nvim-tree/nvim-tree.lua',
        version = "*",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require("nvim-tree").setup{}
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
        requires = {
            "nvim-lua/plenary.nvim",
            "m00qek/baleia.nvim"
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

    }

    --{
	--    "L3MON4D3/LuaSnip",
	--    -- follow latest release.
	--    version = "<CurrentMajor>.*",
	--    -- install jsregexp (optional!).
	--    build = "make install_jsregexp"
    --}
})


local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    -- { name = "buffer" },
    -- { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
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

