-- FileName:     lazy
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-06-03 15:39:49
-- LastModified: 2025-12-06 13:04:32
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

-- --#region
-- --  Reference: https://github.com/rktjmp/hotpot.nvim
-- -- Bootstap hotpot into lazy plugin dir if it does not exist yet.
-- local hotpotpath = vim.fn.stdpath("data") .. "/lazy/hotpot.nvim"
-- if not vim.loop.fs_stat(hotpotpath) then
--   vim.notify("Bootstrapping hotpot.nvim...", vim.log.levels.INFO)
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "--single-branch",
--     -- You may with to pin a known version tag with `--branch=vX.Y.Z`
--     "--branch=v0.9.6",
--     "https://github.com/rktjmp/hotpot.nvim.git",
--     hotpotpath,
--   })
-- end
-- vim.opt.rtp:prepend(hotpotpath)
-- require("hotpot")
-- 
-- -- include hotpot as a plugin so lazy will update it
-- 
-- -- include the rest of your config
-- 
-- --#endregion
-----------------------------------------------------------


local venv = os.getenv("VIRTUAL_ENV")


require("lazy").setup({
    {
        "amitds1997/remote-nvim.nvim",
        version = "*", -- Pin to GitHub releases
        dependencies = {
            "nvim-lua/plenary.nvim", -- For standard functions
            "MunifTanjim/nui.nvim", -- To build the plugin UI
            "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
        },
        config = true,
    },
    {
      "hat0uma/csvview.nvim",
      ---@module "csvview"
      ---@type CsvView.Options
      opts = {
        parser = { comments = { "#", "//" } },
        keymaps = {
          -- Text objects for selecting fields
          textobject_field_inner = { "if", mode = { "o", "x" } },
          textobject_field_outer = { "af", mode = { "o", "x" } },
          -- Excel-like navigation:
          -- Use <Tab> and <S-Tab> to move horizontally between fields.
          -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
          -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
          jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
          jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
          jump_next_row = { "<Enter>", mode = { "n", "v" } },
          jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
        },
      },
      cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    },
    {
        'anurag3301/nvim-platformio.lua',
        dependencies = {
            {'akinsho/nvim-toggleterm.lua'},
            {'nvim-telescope/telescope.nvim'},
            {'nvim-lua/plenary.nvim'},
        },
        cmd = {
            "Pioinit",
            "Piorun",
            "Piocmd",
            "Piolib",
            "Piomon",
            "Piodebug",
            "Piodb",
        },
    },
    {
        'RaafatTurki/hex.nvim',
        config=function ()
            require("hex").setup({
            })
        end
    },
    {
        "vijaymarupudi/nvim-fzf"
    },
    {
        "tikhomirov/vim-glsl"
    },
    {
        "sindrets/diffview.nvim",
    },
    {
        "sakhnik/nvim-gdb"
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority=1000,
        config=function ()
            require("gruvbox").setup({
                transparent_mode=true
            })
        end, opts = ...},
    {
      "ellisonleao/carbon-now.nvim",
      lazy = true,
      cmd = "CarbonNow",
      ---@param opts cn.ConfigSchema
      -- opts = { [[ your custom config here ]] }
    },
    -- image preview
    -- {
    --     'https://github.com/adelarsq/image_preview.nvim',
    --     event = 'VeryLazy',
    --     config = function()
    --         require("image_preview").setup()
    --     end
    -- },
    -- {
    --     'mbpowers/nvimager'
    -- },
    -- {
    --     'sunjon/extmark-toy.nvim'
    -- },
    {
        "Rawnly/gist.nvim",
        cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
        config = true
    },
    -- `GistsList` opens the selected gif in a terminal buffer,
    -- nvim-unception uses neovim remote rpc functionality to open the gist in an actual buffer
    -- and prevents neovim buffer inception
    {
        "samjwill/nvim-unception",
        lazy = false,
        init = function() vim.g.unception_block_while_host_edits = true end
    },
    {
        'https://codeberg.org/esensar/nvim-dev-container',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function ()
            require("devcontainer").setup({})
        end
    },
    -- {
    --     "natecraddock/workspaces.nvim",
    --     config = function ()
    --         require("workspaces").setup()
    --     end
    -- },
    {
        "Vigemus/iron.nvim",
        config = function ()
            require("iron.core").setup(
                require("plugins.config.iron")
            )
        end
    },
    {
      'stevearc/oil.nvim',
      opts = {},
      enabled = function() return jit.os == "Linux" or jit.os == "OSX" or jit.os == "Windows" end,  -- https://www.reddit.com/r/neovim/comments/10yx0mu/how_can_i_load_a_plugin_only_if_im_using_linux/
      -- Optional dependencies
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function ()
          require("plugins.config.oil")
      end
    },
    {
        'Bucchiman/issuelist.nvim',
    },
    {
        'Bucchiman/hotprojects.nvim'
    },
--     {
--         'mrjones2014/dash.nvim',
--         build = 'make install',
--     },
    -- {
    --     2024-10-28 10:21:14 error
    --     'gelguy/wilder.nvim',
    --     build = function ()
    --         vim.cmd("UpdateRemotePlugins")
    --     end,
    --     config = function()
    --         require("wilder").setup({
    --             modes = {':', '/', '?'}
    --         })
    --     end,
    -- },
    {
        "folke/styler.nvim",
        config = function()
            require("styler").setup({
                themes = {
                    markdown = { colorscheme = "gruvbox" },
                    help = { colorscheme = "catppuccin-mocha", background = "dark" },
                },
            })
        end,
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
    -- {
    --     -- dired like emacs
    --     "X3eRo0/dired.nvim",
    --     dependencies = {"MunifTanjim/nui.nvim"},
    --     config = function()
    --         require("dired").setup {
    --             path_separator = "/",
    --             show_banner = false,
    --             show_hidden = true,
    --             show_dot_dirs = true,
    --             show_colors = true,
    --         }
    --     end,
    -- },
    -- {
    --     -- Update: 2023-10-20 11:48:29
    --     -- Description: conflicts between auto-session and neo-tree
    --     --              fix this by issue https://github.com/nvim-neo-tree/neo-tree.nvim/issues/400
    --     'rmagatti/auto-session',
    --     dependencies = {'nvim-telescope/telescope.nvim'},
    --     config = function ()
    --         -- require("auto-session").setup({
    --         --     log_level = vim.log.levels.ERROR,
    --         --     cwd_change_handling = {
    --         --         restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
    --         --         pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
    --         --         post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
    --         --             require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
    --         --         end,
    --         --     }
    --         -- })
    --         -- require("auto-session").setup {
    --         --     auto_session_create_enabled = false,
    --         --     auto_session_enabled = true,
    --         --     auto_session_restore_enabled = true,
    --         --     auto_session_use_git_branch = true,
    --         --     log_level = vim.log.levels.ERROR,
    --         --     bypass_session_save_file_types = {"neo-tree"},
    --         --     auto_session_suppress_dirs = { "~", "~/Projects", "~/Downloads", "/" },
    --         --     pre_save_cmds = { function ()
    --         --         require 'neo-tree.sources.manager'.close_all()
    --         --         vim.notify('closed all')
    --         --         end
    --         --     },
    --         --     post_restore_cmds = { function ()
    --         --         vim.notify('opening neotree')
    --         --         require 'neo-tree.sources.manager'.show('filesystem')
    --         --     end},
    --         -- }
    --     end,
    -- },

    {
        -- git
        -- {
        --     2024-10-28 10:14:32 error: there is no glab command
        --     -- glabコマンド
        --     "harrisoncramer/gitlab.nvim",
        --     dependencies = {
        --         "MunifTanjim/nui.nvim",
        --         "nvim-lua/plenary.nvim",
        --         "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
        --         enabled = true,
        --     },
        --     build = function () require("gitlab.server").build(true) end, -- Builds the Go binary
        --     config = function()
        --         require("gitlab").setup() -- Uses delta reviewer by default
        --     end,
        -- },
        {
            -- lazygit
            "kdheepak/lazygit.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim"
            },
        },
        -- {
        --     2024-10-28 10:14:32 error: there is no glab command
        --     -- ghコマンド
        --     'ldelossa/gh.nvim',
        --     dependencies = {
        --         {'ldelossa/litee.nvim'}
        --     },
        --     config = function ()
        --         require('litee.lib').setup()
        --         require('litee.gh').setup()
        --     end
        -- },
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
    -- {
    --     "folke/noice.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --       -- add any options here
    --     },
    --     dependencies = {
    --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --         "MunifTanjim/nui.nvim",
    --         -- OPTIONAL:
    --         --   `nvim-notify` is only needed, if you want to use the notification view.
    --         --   If not available, we use `mini` as the fallback
    --         "rcarriga/nvim-notify",
    --     },
    --     config = function ()
    --         require("plugins.config.noice")
    --     end
    -- },
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
--     {
--         'chipsenkbeil/distant.nvim', 
--         branch = 'v0.3',
--         config = function()
--             require('distant'):setup()
--         end
--     },
--     {
--         'pwntester/octo.nvim',
--         dependencies = {
--             'nvim-lua/plenary.nvim',
--             'nvim-telescope/telescope.nvim',
--             'nvim-tree/nvim-web-devicons',
--         },
--         config = function ()
--             require('octo').setup()
--         end
--     },
--     {
--         'willothy/flatten.nvim',
--         config = true,
--         lazy = false,
--         priority = 1001,
--     },

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
--     {
--         "princejoogie/chafa.nvim",
--         dependencies = {
--             "nvim-lua/plenary.nvim",
--             "m00qek/baleia.nvim"
--         },
--         config = function ()
--             require("chafa").setup({
--                 render = {
--                     min_padding = 5,
--                     show_label = true,
--                 },
--                 event = {
--                     update_on_nvim_resize = true
--                 }
--             })
--         end
--     },
    {
        'nvim-telescope/telescope-media-files.nvim'
    },
--     -- {
--     --     'edluffy/hologram.nvim',
--     --     config = function()
--     --         require("hologram").setup ({
--     --             auto_display = true
--     --         })
--     --     end
--     -- },
--     -- {
--     --     'glepnir/dashboard-nvim',
--     --     event = 'VimEnter',
--     --     config = function()
--     --         require('dashboard').setup ({
--     --         -- config
--     --         })
--     --     end,
--     --     dependencies = { {'nvim-tree/nvim-web-devicons'}}
--     -- },
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
            require('template').setup(
                require("plugins.config.template")
            )
        end
    },
    "nvim-lua/plenary.nvim",
    {
        'catppuccin/nvim',
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
            })
            -- vim.cmd.colorscheme "catppuccin"
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
    {
        'williamboman/mason.nvim',
        config = function()
            require("mason").setup()
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            -- require("plugins.config.lspconfig")
            require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls"}
            })
        end
    },
    -- For luasnip users
    {
        'L3MON4D3/LuaSnip',
        -- after = 'nvim-cmp',
        version = "v2.*",
        build = "make install_jsregexp",
        config = function ()
            require('plugins.config.snippets')
        end,
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
        }
    },
    'saadparwaiz1/cmp_luasnip',
    {
        'hrsh7th/nvim-cmp',
        config = function ()
            require("plugins.config.cmp")
        end,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
        },
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
