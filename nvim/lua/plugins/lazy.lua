-- FileName:     lazy
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-06-03 15:39:49
-- LastModified: 2023-12-11 18:27:11
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
      -- Optional dependencies
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function ()
          require("oil").setup({
              columns = {
                  "icon",
                  "permissions",
                  "size",
                  "mtime",
              },
              view_options = {
                  show_hidden = true,
              },
                use_default_keymaps = false,
              keymaps = {
                  ["<C-v>"] = "actions.select_vsplit",
                  ["g?"] = "actions.show_help",
                  ["<CR>"] = "actions.select",
                  ["<C-h>"] = "actions.select_split",
                  ["<C-t>"] = "actions.select_tab",
                  ["<C-p>"] = "actions.preview",
                  ["<C-c>"] = "actions.close",
                  ["<C-l>"] = "actions.refresh",
                  ["-"] = "actions.parent",
                  ["_"] = "actions.open_cwd",
                  ["`"] = "actions.cd",
                  ["~"] = "actions.tcd",
                  ["gs"] = "actions.change_sort",
                  ["gx"] = "actions.open_external",
                  ["g."] = "actions.toggle_hidden",
              },
            prompt_save_on_select_new_entry = false,
          })
      end
    },
    {
        'Bucchiman/issuelist.nvim',
    },
    {
        'Bucchiman/hotprojects.nvim'
    },
    {
        'cwebster2/github-coauthors.nvim'
    },
    {
        'jedrzejboczar/possession.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function ()
            require('possession').setup {
                silent = false,
                load_silent = true,
                debug = false,
                logfile = false,
                prompt_no_cr = false,
                autosave = {
                    current = true,  -- or fun(name): boolean
                    tmp = true,  -- or fun(): boolean
                    tmp_name = 'project', -- or fun(): string
                    on_load = true,
                    on_quit = true,
                },
                commands = {
                    save = 'PossessionSave',
                    load = 'PossessionLoad',
                    rename = 'PossessionRename',
                    close = 'PossessionClose',
                    delete = 'PossessionDelete',
                    show = 'PossessionShow',
                    list = 'PossessionList',
                    migrate = 'PossessionMigrate',
                },
                hooks = {
                    before_save = function(name) return {} end,
                    after_save = function(name, user_data, aborted) end,
                    before_load = function(name, user_data) return user_data end,
                    after_load = function(name, user_data) end,
                },
                plugins = {
                    close_windows = {
                        hooks = {'before_save', 'before_load'},
                        preserve_layout = true,  -- or fun(win): boolean
                        match = {
                            floating = true,
                            buftype = {},
                            filetype = {},
                            custom = false,  -- or fun(win): boolean
                        },
                    },
                    delete_hidden_buffers = {
                        hooks = {
                            'before_load',
                            vim.o.sessionoptions:match('buffer') and 'before_save',
                        },
                        force = false,  -- or fun(buf): boolean
                    },
                    nvim_tree = true,
                    neo_tree = true,
                    symbols_outline = true,
                    tabby = true,
                    dap = true,
                    dapui = true,
                    delete_buffers = true,
                },
                telescope = {
                    list = {
                        default_action = 'load',
                        mappings = {
                            save = { n = '<c-x>', i = '<c-x>' },
                            load = { n = '<c-v>', i = '<c-v>' },
                            delete = { n = '<c-t>', i = '<c-t>' },
                            rename = { n = '<c-r>', i = '<c-r>' },
                        },
                    },
                },
            }
        end
    },
    {
        'mrjones2014/dash.nvim',
        build = 'make install',
    },
    -- {
    --     "nvim-neo-tree/neo-tree.nvim",
    --     branch = "v3.x",
    --     dependencies = { 
    --         "nvim-lua/plenary.nvim",
    --         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    --         "MunifTanjim/nui.nvim",
    --         {
    --             's1n7ax/nvim-window-picker',
    --             version = '2.*',
    --             config = function()
    --                 require 'window-picker'.setup({
    --                     filter_rules = {
    --                     include_current_win = false,
    --                     autoselect_one = true,
    --                     -- filter using buffer options
    --                     bo = {
    --                             -- if the file type is one of following, the window will be ignored
    --                             filetype = { 'neo-tree', "neo-tree-popup", "notify" },
    --                             -- if the buffer type is one of following, the window will be ignored
    --                             buftype = { 'terminal', "quickfix" },
    --                         },
    --                     },
    --                 })
    --             end,
    --         },
    --     },
    -- config = function ()
    --   -- If you want icons for diagnostic errors, you'll need to define them somewhere:
    --   vim.fn.sign_define("DiagnosticSignError",
    --     {text = " ", texthl = "DiagnosticSignError"})
    --   vim.fn.sign_define("DiagnosticSignWarn",
    --     {text = " ", texthl = "DiagnosticSignWarn"})
    --   vim.fn.sign_define("DiagnosticSignInfo",
    --     {text = " ", texthl = "DiagnosticSignInfo"})
    --   vim.fn.sign_define("DiagnosticSignHint",
    --     {text = "󰌵", texthl = "DiagnosticSignHint"})
 
    --   require("neo-tree").setup({
    --     close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    --     popup_border_style = "rounded",
    --     enable_git_status = true,
    --     enable_diagnostics = true,
    --     enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
    --     open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
    --     sort_case_insensitive = false, -- used when sorting files and directories in the tree
    --     sort_function = nil , -- use a custom function for sorting files and directories in the tree 
    --     -- sort_function = function (a,b)
    --     --       if a.type == b.type then
    --     --           return a.path > b.path
    --     --       else
    --     --           return a.type > b.type
    --     --       end
    --     --   end , -- this sorts files and directories descendantly
    --     default_component_configs = {
    --       container = {
    --         enable_character_fade = true
    --       },
    --       indent = {
    --         indent_size = 2,
    --         padding = 1, -- extra padding on left hand side
    --         -- indent guides
    --         with_markers = true,
    --         indent_marker = "│",
    --         last_indent_marker = "└",
    --         highlight = "NeoTreeIndentMarker",
    --         -- expander config, needed for nesting files
    --         with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
    --         expander_collapsed = "",
    --         expander_expanded = "",
    --         expander_highlight = "NeoTreeExpander",
    --       },
    --       icon = {
    --         folder_closed = "",
    --         folder_open = "",
    --         folder_empty = "󰜌",
    --         -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
    --         -- then these will never be used.
    --         default = "*",
    --         highlight = "NeoTreeFileIcon"
    --       },
    --       modified = {
    --         symbol = "[+]",
    --         highlight = "NeoTreeModified",
    --       },
    --       name = {
    --         trailing_slash = false,
    --         use_git_status_colors = true,
    --         highlight = "NeoTreeFileName",
    --       },
    --       git_status = {
    --         symbols = {
    --           -- Change type
    --           added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
    --           modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
    --           deleted   = "✖",-- this can only be used in the git_status source
    --           renamed   = "󰁕",-- this can only be used in the git_status source
    --           -- Status type
    --           untracked = "",
    --           ignored   = "",
    --           unstaged  = "󰄱",
    --           staged    = "",
    --           conflict  = "",
    --         }
    --       },
    --       -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
    --       file_size = {
    --         enabled = true,
    --         required_width = 64, -- min width of window required to show this column
    --       },
    --       type = {
    --         enabled = true,
    --         required_width = 122, -- min width of window required to show this column
    --       },
    --       last_modified = {
    --         enabled = true,
    --         required_width = 88, -- min width of window required to show this column
    --       },
    --       created = {
    --         enabled = true,
    --         required_width = 110, -- min width of window required to show this column
    --       },
    --       symlink_target = {
    --         enabled = false,
    --       },
    --     },
    --     -- A list of functions, each representing a global custom command
    --     -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
    --     -- see `:h neo-tree-custom-commands-global`
    --     commands = {},
    --     window = {
    --       position = "left",
    --       width = 40,
    --       mapping_options = {
    --         noremap = true,
    --         nowait = true,
    --       },
    --       mappings = {
    --         ["<space>"] = { 
    --             "toggle_node", 
    --             nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
    --         },
    --         ["<2-LeftMouse>"] = "open",
    --         ["<cr>"] = "open",
    --         ["<esc>"] = "cancel", -- close preview or floating neo-tree window
    --         ["P"] = { "toggle_preview", config = { use_float = true } },
    --         ["l"] = "focus_preview",
    --         ["S"] = "open_split",
    --         ["s"] = "open_vsplit",
    --         -- ["S"] = "split_with_window_picker",
    --         -- ["s"] = "vsplit_with_window_picker",
    --         ["t"] = "open_tabnew",
    --         -- ["<cr>"] = "open_drop",
    --         -- ["t"] = "open_tab_drop",
    --         ["w"] = "open_with_window_picker",
    --         --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
    --         ["C"] = "close_node",
    --         -- ['C'] = 'close_all_subnodes',
    --         ["z"] = "close_all_nodes",
    --         --["Z"] = "expand_all_nodes",
    --         ["a"] = { 
    --           "add",
    --           -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
    --           -- some commands may take optional config options, see `:h neo-tree-mappings` for details
    --           config = {
    --             show_path = "none" -- "none", "relative", "absolute"
    --           }
    --         },
    --         ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
    --         ["d"] = "delete",
    --         ["r"] = "rename",
    --         ["y"] = "copy_to_clipboard",
    --         ["x"] = "cut_to_clipboard",
    --         ["p"] = "paste_from_clipboard",
    --         ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
    --         -- ["c"] = {
    --         --  "copy",
    --         --  config = {
    --         --    show_path = "none" -- "none", "relative", "absolute"
    --         --  }
    --         --}
    --         ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
    --         ["q"] = "close_window",
    --         ["R"] = "refresh",
    --         ["?"] = "show_help",
    --         ["<"] = "prev_source",
    --         [">"] = "next_source",
    --         ["i"] = "show_file_details",
    --       }
    --     },
    --     nesting_rules = {},
    --     filesystem = {
    --       filtered_items = {
    --         visible = false, -- when true, they will just be displayed differently than normal items
    --         hide_dotfiles = true,
    --         hide_gitignored = true,
    --         hide_hidden = true, -- only works on Windows for hidden files/directories
    --         hide_by_name = {
    --           --"node_modules"
    --         },
    --         hide_by_pattern = { -- uses glob style patterns
    --           --"*.meta",
    --           --"*/src/*/tsconfig.json",
    --         },
    --         always_show = { -- remains visible even if other settings would normally hide it
    --           --".gitignored",
    --         },
    --         never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
    --           --".DS_Store",
    --           --"thumbs.db"
    --         },
    --         never_show_by_pattern = { -- uses glob style patterns
    --           --".null-ls_*",
    --         },
    --       },
    --       follow_current_file = {
    --         enabled = false, -- This will find and focus the file in the active buffer every time
    --         --               -- the current file is changed while the tree is open.
    --         leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    --       },
    --       group_empty_dirs = false, -- when true, empty folders will be grouped together
    --       hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
    --                                               -- in whatever position is specified in window.position
    --                             -- "open_current",  -- netrw disabled, opening a directory opens within the
    --                                               -- window like netrw would, regardless of window.position
    --                             -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    --       use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
    --                                       -- instead of relying on nvim autocmd events.
    --       window = {
    --         mappings = {
    --           ["<bs>"] = "navigate_up",
    --           -- ["."] = "set_root",
    --           ["H"] = "toggle_hidden",
    --           ["/"] = "fuzzy_finder",
    --           ["D"] = "fuzzy_finder_directory",
    --           ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
    --           -- ["D"] = "fuzzy_sorter_directory",
    --           ["f"] = "filter_on_submit",
    --           ["<c-x>"] = "clear_filter",
    --           ["[g"] = "prev_git_modified",
    --           ["]g"] = "next_git_modified",
    --           ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
    --           ["oc"] = { "order_by_created", nowait = false },
    --           ["od"] = { "order_by_diagnostics", nowait = false },
    --           ["og"] = { "order_by_git_status", nowait = false },
    --           ["om"] = { "order_by_modified", nowait = false },
    --           ["on"] = { "order_by_name", nowait = false },
    --           ["os"] = { "order_by_size", nowait = false },
    --           ["ot"] = { "order_by_type", nowait = false },
    --         },
    --         fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
    --           ["<down>"] = "move_cursor_down",
    --           ["<C-n>"] = "move_cursor_down",
    --           ["<up>"] = "move_cursor_up",
    --           ["<C-p>"] = "move_cursor_up",
    --         },
    --       },
 
    --       commands = {} -- Add a custom command or override a global one using the same function name
    --     },
    --     buffers = {
    --       follow_current_file = {
    --         enabled = true, -- This will find and focus the file in the active buffer every time
    --         --              -- the current file is changed while the tree is open.
    --         leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    --       },
    --       group_empty_dirs = true, -- when true, empty folders will be grouped together
    --       show_unloaded = true,
    --       window = {
    --         mappings = {
    --           ["bd"] = "buffer_delete",
    --           ["<bs>"] = "navigate_up",
    --           -- ["."] = "set_root",
    --           ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
    --           ["oc"] = { "order_by_created", nowait = false },
    --           ["od"] = { "order_by_diagnostics", nowait = false },
    --           ["om"] = { "order_by_modified", nowait = false },
    --           ["on"] = { "order_by_name", nowait = false },
    --           ["os"] = { "order_by_size", nowait = false },
    --           ["ot"] = { "order_by_type", nowait = false },
    --         }
    --       },
    --     },
    --     git_status = {
    --       window = {
    --         position = "float",
    --         mappings = {
    --           ["A"]  = "git_add_all",
    --           ["gu"] = "git_unstage_file",
    --           ["ga"] = "git_add_file",
    --           ["gr"] = "git_revert_file",
    --           ["gc"] = "git_commit",
    --           ["gp"] = "git_push",
    --           ["gg"] = "git_commit_and_push",
    --           ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
    --           ["oc"] = { "order_by_created", nowait = false },
    --           ["od"] = { "order_by_diagnostics", nowait = false },
    --           ["om"] = { "order_by_modified", nowait = false },
    --           ["on"] = { "order_by_name", nowait = false },
    --           ["os"] = { "order_by_size", nowait = false },
    --           ["ot"] = { "order_by_type", nowait = false },
    --         }
    --       }
    --     }
    --   })
 
    --   vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    -- end
    -- },
    {
        'gelguy/wilder.nvim',
        build = function ()
            vim.cmd("UpdateRemotePlugins")
        end,
        config = function()
            require("wilder").setup({
                modes = {':', '/', '?'}
            })
        end,
    },
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
--     {
--         "rktjmp/hotpot.nvim",
--         config = function ()
--             require("hotpot").setup({"rktjmp/hotpot.nvim"})
--         end
--     },
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
    -- {
    --     'nvim-tree/nvim-tree.lua',
    --     version = "*",
    --     dependencies = {
    --         'nvim-tree/nvim-web-devicons',
    --     },
    --     config = function()
    --         require("nvim-tree").setup({
    --             actions = {
    --                 open_file = {
    --                     quit_on_open = true
    --                 }
    --             },
    --             sync_root_with_cwd = true,
    --             respect_buf_cwd = true,
    --             update_focused_file = {
    --                 enable = true,
    --                 update_root = true
    --             },
    --             sort_by = "case_sensitive",
    --             view = {
    --               width = 30,
    --             },
    --             renderer = {
    --               group_empty = true,
    --             },
    --             filters = {
    --               dotfiles = true,
    --             },
    --         })
    --     end,
    -- },
    -- {
    --     -- nvim-tree: not working
    --     "ahmedkhalf/project.nvim",
    --     config = function()
    --         require("project_nvim").setup {
    --             -- your configuration comes here
    --             -- or leave it empty to use the default settings
    --             -- refer to the configuration section below
    --         }
    --     end
    -- },
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
        config = function ()
            require("template").setup(
                require("plugins.config.template")
            )
        end
    },
    "nvim-lua/plenary.nvim",
    {
        "folke/neodev.nvim",
        opts = {}
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = function ()
            vim.cmd("TSUpdate")
        end,
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
