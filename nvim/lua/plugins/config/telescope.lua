#!/usr/bin/env lua
--
-- FileName:     telescope
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-10-14 12;46:07
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
-- Description:  ---
--


M = {}

require('telescope').load_extension('media_files')
require('telescope').load_extension('remote-sshfs')
require('telescope').load_extension('possession')
-- require('telescope').load_extension('projects')
-- require("telescope").load_extension('find_template')
-- require('telescope').load_extension('githubcoauthors')
require('telescope').load_extension('hotprojects')
require('telescope').load_extension('issuelist')

M.extensions = {
    media_files = {
        -- filetypes whitelist
        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        filetypes = {"png", "webp", "jpg", "jpeg"},
        -- find command (defaults to `fd`)
        find_cmd = "rg"
    }
}

return M

