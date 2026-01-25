#!/usr/bin/env lua
--
-- FileName:     lua
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2025-10-20 01:37:41
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
-- Description:  ---
--


local oil = require("oil")

-- OSごとに既定オープナー
local open_cmd
if jit.os == "Linux" then
  open_cmd = "xdg-open"
elseif jit.os == "OSX" then
  open_cmd = "open"
elseif jit.os == "Windows" then
  open_cmd = "start"
else
  open_cmd = nil
end

-- 対応拡張子
local image_exts = {
  png=true, jpg=true, jpeg=true, gif=true, bmp=true, webp=true,
}
local video_exts = {
  mp4=true, m4v=true, mov=true, mkv=true, webm=true, avi=true,
  mpg=true, mpeg=true, m2v=true, ogv=true,
}

-- 拡張子取得
local function get_extension(filename)
  local ext = filename:match("^.+%.(.+)$")
  return ext and ext:lower() or nil
end

-- コマンド存在チェック
local function has(cmd) return vim.fn.executable(cmd) == 1 end

-- 動画用ビューア選択（mpv優先）
local function choose_video_cmd(path, opts)
  opts = opts or {}
  if has("mpv") then
    local cmd = { "mpv", path }
    if opts.pause then table.insert(cmd, 2, "--pause") end
    if opts.loop  then table.insert(cmd, 2, "--loop=inf") end
    if opts.mute  then table.insert(cmd, 2, "--mute=yes") end
    return cmd
  elseif has("vlc") then
    local cmd = { "vlc", path }
    if opts.loop then table.insert(cmd, 2, "--loop") end
    return cmd
  elseif has("ffplay") then
    local cmd = { "ffplay", "-autoexit", path }
    if opts.mute then table.insert(cmd, 2, "-an") end
    -- ループしたい場合は: -loop 0（0=無限）
    if opts.loop then table.insert(cmd, 2, "-loop"); table.insert(cmd, 3, "0") end
    return cmd
  else
    if open_cmd then
      return { open_cmd, path } -- OS既定アプリへフォールバック
    end
  end
  return nil
end

-- 画像/動画プレビュー
local function preview_media()
  local entry = oil.get_cursor_entry()
  if not entry then
    vim.notify("No file selected", vim.log.levels.WARN)
    return
  end
  if entry.type ~= "file" then
    vim.notify("Select a file", vim.log.levels.WARN)
    return
  end

  local dir = oil.get_current_dir() or ""
  local path = vim.fs.joinpath(dir, entry.name)

  local ext = get_extension(entry.name)
  if not ext then
    vim.notify("File has no extension", vim.log.levels.WARN)
    return
  end

  if image_exts[ext] then
    if open_cmd then
      vim.fn.jobstart({ open_cmd, path }, { detach = true })
    else
      vim.notify("No system opener found for images", vim.log.levels.ERROR)
    end
    return
  end

  if video_exts[ext] then
    local cmd = choose_video_cmd(path, { pause = true }) -- 初期停止で開く
    if cmd then
      vim.fn.jobstart(cmd, { detach = true })
    else
      vim.notify("No video player found (install mpv/vlc/ffplay or set system opener)", vim.log.levels.ERROR)
    end
    return
  end

  vim.notify("Not image/video: " .. entry.name, vim.log.levels.INFO)
end

-- Oil内でターミナルを開く
local function open_terminal_in_oil()
  require("plugins.config.oil-terminal").toggle_terminal()
end

-- 既存の画像専用を差し替えたい場合は、上の preview_media を使ってください
-- local function preview_image() ... （不要）

-- Oil設定
oil.setup({
  columns = { "icon", "permissions", "size", "mtime" },
  view_options = { show_hidden = true },
  use_default_keymaps = false,
  keymaps = {
    ["<CR>"] = "actions.select",
    ["<C-p>"] = preview_media,  -- 画像/動画どちらもプレビュー
    ["<C-t>"] = open_terminal_in_oil,  -- Oil内でターミナルを開く
    ["g?"] = "actions.show_help",
    ["<C-c>"] = "actions.close",
    ["<C-i>"] = "actions.refresh",
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

-- local oil = require("oil")
-- 
-- -- OSごとに画像ビューアコマンドを決定
-- local open_cmd
-- if jit.os == "Linux" then
--   open_cmd = "xdg-open"
-- elseif jit.os == "OSX" then
--   open_cmd = "open"
-- elseif jit.os == "Windows" then
--   open_cmd = "start"
-- else
--   open_cmd = nil
-- end
-- 
-- -- 対応する画像拡張子
-- local image_exts = {
--   png = true, jpg = true, jpeg = true,
--   gif = true, bmp = true, webp = true,
-- }
-- 
-- 
-- -- ファイル拡張子を取得
-- local function get_extension(filename)
--   return filename:match("^.+%.(.+)$")
-- end
-- 
-- -- 画像プレビュー関数
-- local function preview_image()
--   local entry = oil.get_cursor_entry()
--   if not entry then
--     vim.notify("No file selected", vim.log.levels.WARN)
--     return
--   end
-- 
--   local ext = get_extension(entry.name)
--   if not ext then
--     vim.notify("File has no extension", vim.log.levels.WARN)
--     return
--   end
-- 
--   ext = string.lower(ext)
--   if image_exts[ext] and open_cmd then
--     local path = oil.get_current_dir() .. entry.name
--     vim.fn.jobstart({ open_cmd, path }, { detach = true })
--   else
--     vim.notify("Not an image file: " .. entry.name, vim.log.levels.INFO)
--   end
-- end
-- 
-- -- Oil設定
-- oil.setup({
--   columns = { "icon", "permissions", "size", "mtime" },
--   view_options = { show_hidden = true },
--   use_default_keymaps = false,
--   keymaps = {
--     ["<CR>"] = "actions.select",
--     ["<C-p>"] = preview_image,  -- Ctrl+pで画像プレビュー
--     ["g?"] = "actions.show_help",
--     ["<C-c>"] = "actions.close",
--     ["<C-i>"] = "actions.refresh",
--     ["-"] = "actions.parent",
--     ["_"] = "actions.open_cwd",
--     ["`"] = "actions.cd",
--     ["~"] = "actions.tcd",
--     ["gs"] = "actions.change_sort",
--     ["gx"] = "actions.open_external",
--     ["g."] = "actions.toggle_hidden",
--   },
--   prompt_save_on_select_new_entry = false,
-- })
