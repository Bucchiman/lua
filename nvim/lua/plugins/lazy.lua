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

vim.cmd("autocmd!")
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


local img_previewer = vim.fn.executable("ueberzug") == 1 and { "ueberzug", "layer" } or { "viu", "-b" }

local venv = os.getenv("VIRTUAL_ENV")

require("lazy").setup({
    {
        'edluffy/hologram.nvim',
        config = function()
            require("hologram").setup{
                auto_display = true
            }
        end
    },
    {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
            -- config
            }
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function ()
            -- require("bufferline").setup({
            -- })
            require("plugins.config.bufferline")
        end
    },
    {
        'rcarriga/nvim-notify',
        config = function ()
            require("notify").setup({
              background_colour = "#000000",
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
    "nvim-lua/popup.nvim",
    {
        "nvim-telescope/telescope.nvim",
        config = function ()
            -- require('telescope').load_extension('media_files')
            require'telescope'.setup {
              extensions = {
                media_files = {
                  -- filetypes whitelist
                  -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                  filetypes = {"png", "webp", "jpg", "jpeg"},
                  -- find command (defaults to `fd`)
                  find_cmd = "rg"
                }
              },
            }
        end

    },
    "nvim-telescope/telescope-media-files.nvim",
    {
        "theHamsta/nvim-dap-virtual-text"
    },
    {
        "xiyaowong/transparent.nvim",
        config = function ()
            require("transparent").setup({
              groups = { -- table: default groups
                'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                'SignColumn', 'CursorLineNr', 'EndOfBuffer',
              },
              extra_groups = {}, -- table: additional groups that should be cleared
              exclude_groups = {}, -- table: groups you don't want to clear
            })
        end
    },
    {
        "cocopon/iceberg.vim",
        config = function ()
            vim.cmd.colorscheme "iceberg"
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        version = "*",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        after = {
            'glepnir/template.nvim',
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
    {
        "ibhagwan/fzf-lua",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("plugins.config.fzf")
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
        'glepnir/template.nvim',
        cmd = {
            'Template',
            'TemProject'
        },
        config = function()
            require("template").setup({
                temp_dir = "$HOME/.config/template",
                author = "8ucchiman",
                email = "8ucchiman@gmail.com",
            })
        end
    },
    "nvim-lua/plenary.nvim",
    {
        "folke/neodev.nvim",
        opts = {}
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            "ravenxrz/DAPInstall.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "nvim-telescope/telescope-dap.nvim",
            "leoluz/nvim-dap-go",
            "jbyuki/one-small-step-for-vimkind",
        },
        config = function ()
            require("plugins.config.dap.dap").setup()
        end
    },
    {
        'rcarriga/nvim-dap-ui',
        config = function()
            local cfg = require("plugins.config.dapui")
            require("dapui").setup(cfg)
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
            -- vim.cmd.colorscheme "catppuccin"
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
            require("plugins.config.lspconfig")
            require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls"}
            })
        end
    },
    --#region
    --  Reference: https://github.com/hrsh7th/nvim-cmp
    --#endregion
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    -- For luasnip users
    {
        'L3MON4D3/LuaSnip',
        after = 'nvim-cmp',
        version = "v2.*",
        build = "make install_jsregexp",
        config = function ()
            require('plugins.config.snippets')
        end
    },
    'saadparwaiz1/cmp_luasnip',
    {
        'hrsh7th/nvim-cmp',
        config = function ()
            require("plugins.config.cmp")
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes hereby
            -- or leave it empty to use the default settings_window
            -- refer to the configuration section belowright
        }
    }
})

require("plugins.config.template")
