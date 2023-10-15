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
    -- ["<C-n>"] = {"<cmd>Dired<cr>", "Dired version"},
    ["<C-k>"] = {"<cmd>cd %:h<cr>", "cwd change"},
    ["<C-s>"] = {"<cmd>Autosession search<cr>", "Show Session"},
    ["<C-b>"] = {"<cmd>Telescope buffers<cr>", "buffer list"},
    ["<C-t>"] = {"<cmd>ToggleTerm<cr>", "terminal on/off"},
    ["<C-n>"] = {"<cmd>Dired<cr>", "open Dired"},
    -- ["<C-n>"] = {"<cmd>NvimTreeToggle<cr>", "nvim tree on/off"},
    ["<C-p>"] = {
        function ()
            require("plugins.config.fzf_lua").snippets()
        end,
        "Snippets"
    },
    ["<C-o>"] = {
        function ()
            require("plugins.config.fzf_lua").onelines()
        end,
        "Onelines"
    },
    ["<C-r>"] ={
        function ()
            require("plugins.config.fzf_lua").readme()
        end,
        "README"
    },
}, { prefix = '<C-s>'})

wk.register({
    ["<C-g>"] = {"<cmd>LazyGit<cr>", "Open LazyGit"}
}, { prefix = '<C-g>'})


wk.register({
    t = {'<cmd>lua require("nabla").popup()<cr>', "Preview mathematics"},
    p = {'<cmd>MarkdownPreviewToggle<cr>', "Preview readme"},
    r = {'<cmd>term python %<cr>', "Run python code"}

}, { prefix = "<space>" })
