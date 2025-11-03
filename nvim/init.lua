#!/usr/bin/env lua
--
-- FileName:     init
-- Author:       8ucchiman
-- CreatedDate:  2023-03-26 11:40:26 +0900
-- LastModified: 2025-03-15 11:36:01
-- Reference:    https://zenn.dev/hisasann/articles/neovim-settings-to-lua
--               https://developer.jmatsuzaki.com/posts/get-file-name-in-vim/
--


-- 速いモジュールローダ
pcall(function() vim.loader.enable() end)

local function try_require(mod)
  local ok, err = pcall(require, mod)
  if not ok then
    vim.schedule(function()
      vim.notify(
        ("nvim: failed to load module '%s': %s"):format(mod, err),
        vim.log.levels.WARN
      )
    end)
  end
  return ok
end


function main()
    require("base")
    require("options")
    require("keymaps")
    require("plugins.lazy")
    Bmods = require("pocket.Bmods")
    local OS = (vim.env.NVIM_OS and vim.env.NVIM_OS:lower()) or Bmods.detect_os()
    local hostname = (function()
        local ok, name = pcall(function() return vim.loop.os_gethostname() end)
        return ok and (name or ""):lower() or ""
    end)()

    try_require(("os.%s"):format(OS))
    -- （任意）ホスト名専用ファイル（lua/os/hosts/<hostname>.lua）があれば上書き
    -- try_require(("os.hosts.%s"):format(hostname))

    -- （任意）ユーザーのローカル秘密設定 (init.local.lua) を最後に読み込む
    -- do
    --   local local_init = vim.fn.stdpath("config") .. "/init.local.lua"
    --   if vim.fn.filereadable(local_init) == 1 then
    --     pcall(dofile, local_init)
    --   end
    -- end

    local experiments = require("experiments")

    -- boot log
    vim.defer_fn(function()
      vim.notify(("nvim: OS profile = %s%s"):format(
        OS,
        hostname ~= "" and (" (host: " .. hostname .. ")") or ""
      ), vim.log.levels.INFO, { title = "Neovim" })
    end, 50)
end


function main01()
    local uname = vim.loop.os_uname().sysname

    -- OS 名をグローバル変数に保存（必要なら）
    vim.g.os_name = uname
    print("Detected OS: " .. vim.g.os_name)

    require("base")
    require("options")
    require("keymaps")

    require("plugins.lazy")
    Bmods = require("pocket.Bmods")

    -- require("tools.settings")
    local experiments = require("experiments")

    -- -- if vim.fn.filereadable(vim.fn.expand("/tmp/8ucchiman/nvim")) then
    -- if file_exists("/tmp/8ucchiman/nvim/sample.lua") then
    --     vim.opt.runtimepath:append('/tmp/8ucchiman')
    --     require("sample")
    -- end
end

local success, err = pcall(main)
if not success then
    print("Error:", err)
end
