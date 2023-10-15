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
--#endregion
-----------------------------------------------------------

--#region
--  Reference: https://github.com/rktjmp/hotpot.nvim
-- Bootstap hotpot into lazy plugin dir if it does not exist yet.
local hotpotpath = vim.fn.stdpath("data") .. "/lazy/hotpot.nvim"
if not vim.loop.fs_stat(hotpotpath) then
  vim.notify("Bootstrapping hotpot.nvim...", vim.log.levels.INFO)
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    -- You may with to pin a known version tag with `--branch=vX.Y.Z`
    "--branch=v0.9.6",
    "https://github.com/rktjmp/hotpot.nvim.git",
    hotpotpath,
  })
end
vim.opt.rtp:prepend(hotpotpath)
require("hotpot")

-- include hotpot as a plugin so lazy will update it

-- include the rest of your config

--#endregion
-----------------------------------------------------------


local venv = os.getenv("VIRTUAL_ENV")

require("lazy").setup({
    {
        "rktjmp/hotpot.nvim",
        config = function ()
            require("hotpot").setup({"rktjmp/hotpot.nvim"})
        end
    },
    'jbyuki/nabla.nvim',
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    },
    {
        -- calendar
        "itchyny/calendar.vim"
    },
    {
        "X3eRo0/dired.nvim",
        dependencies = {"MunifTanjim/nui.nvim"},
        config = function()
            require("dired").setup {
                path_separator = "/",
                show_banner = false,
                show_hidden = true,
                show_dot_dirs = true,
                show_colors = true,
            }
        end,
    },
    {
        'rmagatti/auto-session',
        dependencies = {'nvim-telescope/telescope.nvim'},
        config = function ()
            require("auto-session").setup {
                auto_session_enable = true,
                log_level = vim.log.levels.ERROR,
                auto_session_suppress_dirs = { "~", "~/Projects", "~/Downloads", "/" },
                -- auto_session_use_git_branch = false,

                -- auto_session_enable_last_session = false,
            
                -- ⚠️ This will only work if Telescope.nvim is installed
                -- The following are already the default values, no need to provide them if these are already the settings you want.
                -- session_lens = {
                --     -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
                --     buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
                --     load_on_setup = false,
                --     theme_conf = { border = true },
                --     previewer = false,
                -- },
                cwd_change_handling = {
                    restore_upcoming_session = true,
                    pre_cwd_changed_hook = nil,
                    -- pre_cwd_changed_hook = function ()
                    --     
                    -- end,
                    post_cwd_changed_hook = function ()
                        local nvim_tree = require("nvim-tree")
                        nvim_tree.change_dir(vim.fn.getcwd())
                    end
                },
                post_restore_cmds = {
                    function ()
                        local nvim_tree = require("nvim-tree")
                        nvim_tree.change_dir(vim.fn.getcwd())
                    end,
                    "NvimTreeOpen"
                },
                -- pre_restore_cmds = {}
            }
        end,
    },

    -- {
    --     'junegunn/fzf.vim'
    -- },
    -- {
    --     -- sessions
    --     'mhinz/vim-startify',
    --     keys = {
    --         {"<C-s><C-b>", "<cmd>Startify<cr>", desc="Open Buffers"}
    --     }

    -- },
    {
        -- git
        {
            -- glabコマンド
            "harrisoncramer/gitlab.nvim",
            dependencies = {
                "MunifTanjim/nui.nvim",
                "nvim-lua/plenary.nvim",
                "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
                enabled = true,
            },
            build = function () require("gitlab.server").build(true) end, -- Builds the Go binary
            config = function()
                require("gitlab").setup() -- Uses delta reviewer by default
            end,
        },
        {
            -- lazygit
            "kdheepak/lazygit.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim"
            },
        },
        {
            -- ghコマンド
            'ldelossa/gh.nvim',
            dependencies = {
                {'ldelossa/litee.nvim'}
            },
            config = function ()
                require('litee.lib').setup()
                require('litee.gh').setup()
            end
        },
    },
    {
        -- 各行をコピー
        'Rasukarusan/nvim-select-multi-line',
    },
    -- {
    --     "folke/styler.nvim",
    --     config = function()
    --         require("styler").setup({
    --             themes = {
    --                 markdown = { colorscheme = "gruvbox" },
    --                 help = { colorscheme = "catppuccin-mocha", background = "dark" },
    --             },
    --         })
    --     end,
    -- },
    {
        'equalsraf/neovim-gui-shim'
    },
    {
        'nosduco/remote-sshfs.nvim',
        dependencies = {
            {'nvim-telescope/telescope.nvim'}
        },
        config = function ()
            require('remote-sshfs').setup{
              connections = {
                ssh_configs = { -- which ssh configs to parse for hosts list
                  vim.fn.expand "$HOME" .. "/.ssh/config",
                  "/etc/ssh/ssh_config",
                  -- "/path/to/custom/ssh_config"
                },
                sshfs_args = { -- arguments to pass to the sshfs command
                  "-o reconnect",
                  "-o ConnectTimeout=5",
                },
              },
              mounts = {
                base_dir = vim.fn.expand "$HOME" .. "/.sshfs/", -- base directory for mount points
                unmount_on_exit = true, -- run sshfs as foreground, will unmount on vim exit
              },
              handlers = {
                on_connect = {
                  change_dir = true, -- when connected change vim working directory to mount point
                },
                on_disconnect = {
                  clean_mount_folders = false, -- remove mount point folder on disconnect/unmount
                },
                on_edit = {}, -- not yet implemented
              },
              ui = {
                select_prompts = false, -- not yet implemented
                confirm = {
                  connect = true, -- prompt y/n when host is selected to connect to
                  change_dir = false, -- prompt y/n to change working directory on connection (only applicable if handlers.on_connect.change_dir is enabled)
                },
              },
              log = {
                enable = false, -- enable logging
                truncate = false, -- truncate logs
                types = { -- enabled log types
                  all = false,
                  util = false,
                  handler = false,
                  sshfs = false,
                },
              },
            }
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
          -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        config = function ()
            require("plugins.config.noice")
        end
    },
    {
        'neoclide/coc.nvim',
        branch = 'release'
    },
    {
        'VonHeikemen/fine-cmdline.nvim',
        dependencies = {
            {
                'MunifTanjim/nui.nvim'
            }
        }
    },
    {
        'jamestthompson3/nvim-remote-containers'
    },
    {
        'chipsenkbeil/distant.nvim', 
        branch = 'v0.3',
        config = function()
            require('distant'):setup()
        end
    },
    {
        'pwntester/octo.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        config = function ()
            require('octo').setup()
        end
    },
    {
        'willothy/flatten.nvim',
        config = true,
        lazy = false,
        priority = 1001,
    },
    -- {
    --     'romgrk/barbar.nvim',
    --     dependencies = {
    --         'lewis6991/gitsigns.nvim',
    --         'nvim-tree/nvim-web-devicons'
    --     },
    --     init = function () vim.g.barbar_auto_setup = false end,
    --     opts= {

    --     },
    --     version = '^1.0.0'
    -- },
    {
        {
            'akinsho/toggleterm.nvim',
            version = "*",
            config = function ()
                require("toggleterm").setup({
                    autochdir = true
                })
            end
        }

    },
    {
        'nvim-lualine/lualine.nvim',
        config = function ()
            require('lualine').setup({
                options = {
                    theme = "jellybeans"
                }
            })
        end
    },
    {
        "princejoogie/chafa.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "m00qek/baleia.nvim"
        },
        config = function ()
            require("chafa").setup({
                render = {
                    min_padding = 5,
                    show_label = true,
                },
                event = {
                    update_on_nvim_resize = true
                }
            })
        end
    },
    {
        'nvim-telescope/telescope-media-files.nvim'
    },
    -- {
    --     'edluffy/hologram.nvim',
    --     config = function()
    --         require("hologram").setup ({
    --             auto_display = true
    --         })
    --     end
    -- },
    -- {
    --     'glepnir/dashboard-nvim',
    --     event = 'VimEnter',
    --     config = function()
    --         require('dashboard').setup ({
    --         -- config
    --         })
    --     end,
    --     dependencies = { {'nvim-tree/nvim-web-devicons'}}
    -- },
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
        dependencies = {
            "nvim-telescope/telescope-media-files.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function ()
            require('telescope').setup(
                require("plugins.config.telescope")
            )
        end,
    },
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
            require("fzf-lua").setup({
                require("plugins.config.fzf_lua")
            })
        end,
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
        -- init = function ()
        --     vim.cmd("TSUpdate")
        -- end,
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
        config = function ()
            require("plugins.config.which-key")
        end,
        opts = {
            -- your configuration comes hereby
            -- or leave it empty to use the default settings_window
            -- refer to the configuration section belowright
        }
    }
})

require("plugins.config.template")

-- require("telescope").load_extension("session-lens")
-- vim.keymap.set("n", "<C-s><C-b>", require("auto-session.session-lens").search_session, {
--   noremap = true,
-- })
