#!/usr/bin/env lua
--
-- FileName:     which-key
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-10-06 14:51:33
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
-- Description:  ---
--


local wk = require("which-key")
local Bmods = require("Bmods")
wk.register({
    g = {
        name = "+Git",
        h = {
            name = "+Github",
            c = {
                name = "+Commits",
                c = { "<cmd>GHCloseCommit<cr>", "Close" },
                e = { "<cmd>GHExpandCommit<cr>", "Expand" },
                o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
                p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
                z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
            },
            i = {
                name = "+Issues",
                p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
            },
            l = {
                name = "+Litee",
                t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
            },
            r = {
                name = "+Review",
                b = { "<cmd>GHStartReview<cr>", "Begin" },
                c = { "<cmd>GHCloseReview<cr>", "Close" },
                d = { "<cmd>GHDeleteReview<cr>", "Delete" },
                e = { "<cmd>GHExpandReview<cr>", "Expand" },
                s = { "<cmd>GHSubmitReview<cr>", "Submit" },
                z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
            },
            p = {
                name = "+Pull Request",
                c = { "<cmd>GHClosePR<cr>", "Close" },
                d = { "<cmd>GHPRDetails<cr>", "Details" },
                e = { "<cmd>GHExpandPR<cr>", "Expand" },
                o = { "<cmd>GHOpenPR<cr>", "Open" },
                p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
                r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
                t = { "<cmd>GHOpenToPR<cr>", "Open To" },
                z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
            },
            t = {
                name = "+Threads",
                c = { "<cmd>GHCreateThread<cr>", "Create" },
                n = { "<cmd>GHNextThread<cr>", "Next" },
                t = { "<cmd>GHToggleThread<cr>", "Toggle" },
            },
        },
        l = {
            name = "+GitLab",
            r  = { "<cmd> lua require('gitlab').review()<cr>", "Review" },
            s  = { "<cmd> lua require('gitlab').summary()<cr>", "Summary" },
            A  = { "<cmd> lua require('gitlab').approve()<cr>", "Approve" },
            R  = { "<cmd> lua require('gitlab').revoke()<cr>", "Revoke" },
            c  = { "<cmd> lua require('gitlab').create_comment()<cr>", "Create Comment" },
            n  = { "<cmd> lua require('gitlab').create_note()<cr>", "Create Note" },
            d  = { "<cmd> lua require('gitlab').toggle_discussions()<cr>", "Toggle Discussions" },
            aa = { "<cmd> lua require('gitlab').add_assignee()<cr>", "Add Assignee" },
            ad = { "<cmd> lua require('gitlab').delete_assignee()<cr>", "Delete Assignee"},
            ra = { "<cmd> lua require('gitlab').add_reviewer()<cr>", "Add Reviewer"},
            rd = { "<cmd> lua require('gitlab').delete_reviewer()<cr>", "Delete Reviewer"},
            p = { "<cmd> lua require('gitlab').pipeline()<cr>", "Pipeline"},
            o = { "<cmd> lua require('gitlab').open_in_browser()<cr>", "Open in Browser"},
        },
        o = {
            name = "+Octo",

        }
    },
    t = {
        name = "+Telescope",
        b = {"<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers"},
        f = {"<cmd>lua require('telescope.builtin').find_files()<cr>", "File Search"},
        g = {"<cmd>lua require('telescope.builtin').live_grep()<cr>", "Grep"},
        h = {"<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help Tags"},
        s = {"<cmd>lua require('telescope.builtin').git_status()<cr>", "Git status"},
    },
    l = {
        name = "+Luafzf",
        b = {"<cmd>lua require('fzf-lua').buffers()<cr>", "Buffers"}
    },
}, { prefix = '<leader>' })

wk.register({
    ["<C-l>"] = {"<cmd>NoiceLog<cr>", "Noice Log"},
    ["<C-k>"] = {"<cmd>cd %:h<cr>", "cwd change"},
    ["<C-j>"] = {"<cmd>Telescope hotprojects show_hotproject<cr>", "Show projects"},
    -- ["<C-s>"] = {"<cmd>Autosession search<cr>", "Show Session"},
    ["<C-e>"] = {"<cmd>Telescope possession list<cr>", "Show Session"},
    -- ["<C-s>"] = {"<cmd>Telescope projects<cr>", "Show projects"},
    -- ["d"] = {"<cmd>Autosession delete<cr>", "Delete Session"},
    ["<C-b>"] = {"<cmd>Telescope buffers<cr>", "buffer list"},
    ["<C-t>"] = {"<cmd>ToggleTerm<cr>", "terminal on/off"},
    -- ["<C-n>"] = {"<cmd>Neotree<cr>", "open Neotree"},
    -- ["<C-n>"] = {"<cmd>Dired<cr>", "open Dired"},
    -- ["<C-n>"] = {"<cmd>NvimTreeToggle<cr>", "nvim tree on/off"},
    ["<C-n>"] = {"<cmd>Oil<cr>", "Open parent directory"},

    ["<C-p>"] = { function () require("plugins.config.fzf_lua").snippets() end, "Snippets" },
    ["<C-o>"] = { function () require("plugins.config.fzf_lua").onelines() end, "Onelines" },
    ["<C-m>"] = { function () require("plugins.config.fzf_lua").readme() end, "README" },
    ["<C-i>"] = {"<cmd>GHOpenIssue", "github issue"},
    -- ["<C-s>"] = { function () require("iron.core").send_file() end, "Run script file"},
    ["<C-s>"] = {
        function ()
            local _file_path = vim.api.nvim_buf_get_name(0)
            local _file = Bmods.GetFileName(_file_path)
            local _extension = Bmods.GetFileExtension(_file_path)
            local _file_name = Bmods.StringDel(_file, _extension)
            print(_file, _file_name, _extension)
            if (( _file == "Bmods" )) then
                vim.cmd("terminal % .")
            elseif ((_file_name == _file) or _extension == ".sh" or _extension == ".zsh") then
                vim.cmd("terminal %")
            elseif (_extension == ".lua") then
                vim.cmd("terminal lua %")
            elseif (_extension == ".rs") then
                vim.cmd("terminal rustc %; ./" .. _file_name)
            elseif (_extension == ".py") then
                vim.cmd("terminal python %")
            else
                vim.notify("Could Not Run", vim.log.levels.ERROR)
            end
        end,
        "Run script file"
    },
    ["<C-r>"] = {
        name = "Repl",
        t = {"<cmd>IronRepl<cr>", "ReplToggle"},
        r = { function () require("iron.core").send_file() end, "Run script file" },
        l = { function () require("iron.core").send_line() end, "Run line" },
        -- q = { function () require("iron.core").remove_mark() end, "Rmove mark"},
    }
}, { prefix = '<C-s>'})

wk.register({
    ["<C-g>"] = {"<cmd>LazyGit<cr>", "Open LazyGit"},
    ["<C-i>"] = {
        name = "+issue",
        c = {"<cmd>Octo issue create<cr>", "Create Issue"},
        l = {"<cmd>Octo issue list<cr>", "List Issue"}
    },
    ["<C-l>"] = {"<cmd>Octo issue list<cr>", "List Issue"}
}, { prefix = '<C-g>'})


wk.register({
    ["<space>"] = {'<cmd>e %<cr>', "for enable syntax hightlight"},
    t = {'<cmd>lua require("nabla").popup()<cr>', "Preview mathematics"},
    p = {'<cmd>MarkdownPreviewToggle<cr>', "Preview readme"},
}, { prefix = "<space>" })


-- local iron = require("iron.core")
-- local view = require("iron.view")
-- wk.register({
--     ["<C-t>"] = {"<cmd>IronRepl<cr>", "ReplToggle"},
--     ["<C-r>"] = { function () iron.send_file() end, "Run script file" },
--     ["<C-l>"] = { function () iron.send_line() end, "Run line" },
--     -- ["<C-v>"] = { function () iron.visual_send() end, "Run a part of visual selection"},
--     ["<C-d>"] = { function () iron.remove_mark() end, "Rmove mark"},
-- }, { prefix = "<C-r>"})
wk.register({
    ["<C-r>"] = { function () require("iron.core").visual_send() end, "Run a part of visual selection"},
}, { prefix = "", mode = "v" })


