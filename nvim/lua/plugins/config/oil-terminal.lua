#!/usr/bin/env lua
--
-- FileName:     oil-terminal
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2026-01-25
-- Description:  Custom terminal management for Oil file explorer
--


local M = {}

-- バッファーごとのターミナル管理
-- source_buf -> terminal_buf のマッピング
M.buf_to_terminal = {}
-- terminal_buf -> source_buf のマッピング (逆引き用)
M.terminal_to_buf = {}

-- ターミナルバッファーかどうかを判定
local function is_terminal_buffer(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end
  local buftype = vim.api.nvim_buf_get_option(bufnr, 'buftype')
  return buftype == 'terminal'
end

-- Oilバッファーかどうかを判定
local function is_oil_buffer(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  return bufname:match("^oil://") ~= nil
end

-- ターミナルのカレントディレクトリを取得
local function get_terminal_cwd(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return nil
  end

  -- ターミナルのジョブIDを取得
  local term_job_id = vim.b[bufnr].terminal_job_id
  if not term_job_id then
    return nil
  end

  -- プロセスIDを取得
  local pid = vim.fn.jobpid(term_job_id)
  if not pid or pid <= 0 then
    return nil
  end

  local cwd = nil

  -- Linux: /proc/{pid}/cwdから取得
  if vim.fn.isdirectory("/proc/" .. pid) == 1 then
    local cwd_link = "/proc/" .. pid .. "/cwd"
    local handle = io.popen("readlink " .. cwd_link .. " 2>/dev/null")
    if handle then
      cwd = handle:read("*l")
      handle:close()
    end
  end

  -- macOS/BSD: lsofを使用
  if not cwd or cwd == "" then
    local handle = io.popen("lsof -a -d cwd -p " .. pid .. " -Fn 2>/dev/null | grep '^n' | cut -c2-")
    if handle then
      cwd = handle:read("*l")
      handle:close()
    end
  end

  if cwd and cwd ~= "" then
    return cwd
  end

  return nil
end

-- ターミナルからOilを開く
function M.open_oil_from_terminal()
  local current_buf = vim.api.nvim_get_current_buf()

  if not is_terminal_buffer(current_buf) then
    vim.notify("Not in terminal buffer", vim.log.levels.WARN)
    return
  end

  -- ターミナルのカレントディレクトリを取得
  local cwd = get_terminal_cwd(current_buf)
  if not cwd then
    cwd = vim.fn.getcwd()
  end

  -- 元のバッファーを取得（存在する場合）
  local source_buf = M.terminal_to_buf[current_buf]

  if source_buf and vim.api.nvim_buf_is_valid(source_buf) then
    -- 元のバッファーに戻る
    vim.api.nvim_set_current_buf(source_buf)
  else
    -- 新しいバッファーを作成
    vim.cmd('enew')
    source_buf = vim.api.nvim_get_current_buf()
  end

  -- Oilでディレクトリを開く
  local oil_ok, oil = pcall(require, "oil")
  if oil_ok then
    oil.open(cwd)
    -- マッピングを更新
    M.buf_to_terminal[source_buf] = current_buf
    M.terminal_to_buf[current_buf] = source_buf
  else
    vim.notify("Oil not available", vim.log.levels.ERROR)
  end
end

-- ターミナルトグル機能
function M.toggle_terminal()
  local current_buf = vim.api.nvim_get_current_buf()

  -- 現在のバッファーがターミナルの場合、Oilを開く
  if is_terminal_buffer(current_buf) then
    M.open_oil_from_terminal()
    return
  end

  -- このバッファーに対応するターミナルが既に存在するか確認
  local terminal_buf = M.buf_to_terminal[current_buf]
  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
    vim.api.nvim_set_current_buf(terminal_buf)
    vim.cmd('startinsert')
    return
  end

  -- 新しいターミナルを作成
  local dir = vim.fn.getcwd()

  -- 現在のバッファーがOilの場合、そのディレクトリを使用
  local oil_ok, oil = pcall(require, "oil")
  if oil_ok and is_oil_buffer(current_buf) then
    local oil_dir = oil.get_current_dir()
    if oil_dir then
      dir = oil_dir
    end
  else
    -- 通常のファイルバッファーの場合、そのファイルのディレクトリを使用
    local bufname = vim.api.nvim_buf_get_name(current_buf)
    if bufname ~= "" then
      local file_dir = vim.fn.fnamemodify(bufname, ":h")
      if vim.fn.isdirectory(file_dir) == 1 then
        dir = file_dir
      end
    end
  end

  vim.cmd('enew')
  local terminal_bufnr = vim.api.nvim_get_current_buf()

  -- バッファーオプションを設定
  vim.api.nvim_buf_set_option(terminal_bufnr, 'buflisted', true)
  vim.api.nvim_buf_set_option(terminal_bufnr, 'bufhidden', 'hide')

  -- ディレクトリに移動してターミナルを起動
  vim.fn.termopen(vim.o.shell, {
    cwd = dir,
    on_exit = function(_, exit_code, _)
      -- ターミナル終了時の処理（マッピングをクリーンアップ）
      local src_buf = M.terminal_to_buf[terminal_bufnr]
      if src_buf then
        M.buf_to_terminal[src_buf] = nil
      end
      M.terminal_to_buf[terminal_bufnr] = nil
    end
  })

  -- バッファー間のマッピングを記録
  M.buf_to_terminal[current_buf] = terminal_bufnr
  M.terminal_to_buf[terminal_bufnr] = current_buf

  -- ターミナルモード用のキーマッピングを設定
  vim.api.nvim_buf_set_keymap(terminal_bufnr, 't', '<C-t>',
    [[<C-\><C-n>:lua require("plugins.config.oil-terminal").open_oil_from_terminal()<CR>]],
    {noremap = true, silent = true})

  -- インサートモードに入る
  vim.cmd('startinsert')
end

return M
