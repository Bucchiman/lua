#!/usr/bin/env lua
--
-- FileName:     callback-helper
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2026-01-25
-- Description:  Helper for inserting callback function signatures
--

local M = {}

-- GLFWコールバックの定義
M.glfw_callbacks = {
    glfwSetKeyCallback = {
        name = "GLFWkeyfun",
        params = "GLFWwindow* window, int key, int scancode, int action, int mods",
        description = "Key callback"
    },
    glfwSetMouseButtonCallback = {
        name = "GLFWmousebuttonfun",
        params = "GLFWwindow* window, int button, int action, int mods",
        description = "Mouse button callback"
    },
    glfwSetCursorPosCallback = {
        name = "GLFWcursorposfun",
        params = "GLFWwindow* window, double xpos, double ypos",
        description = "Cursor position callback"
    },
    glfwSetScrollCallback = {
        name = "GLFWscrollfun",
        params = "GLFWwindow* window, double xoffset, double yoffset",
        description = "Scroll callback"
    },
    glfwSetFramebufferSizeCallback = {
        name = "GLFWframebuffersizefun",
        params = "GLFWwindow* window, int width, int height",
        description = "Framebuffer size callback"
    },
    glfwSetWindowSizeCallback = {
        name = "GLFWwindowsizefun",
        params = "GLFWwindow* window, int width, int height",
        description = "Window size callback"
    },
    glfwSetCharCallback = {
        name = "GLFWcharfun",
        params = "GLFWwindow* window, unsigned int codepoint",
        description = "Character callback"
    },
    glfwSetErrorCallback = {
        name = "GLFWerrorfun",
        params = "int error, const char* description",
        description = "Error callback"
    },
}

-- カーソル位置の単語を取得
local function get_word_under_cursor()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]

    -- 単語の開始位置を見つける
    local start_col = col
    while start_col > 0 and line:sub(start_col, start_col):match("[%w_]") do
        start_col = start_col - 1
    end
    start_col = start_col + 1

    -- 単語の終了位置を見つける
    local end_col = col + 1
    while end_col <= #line and line:sub(end_col, end_col):match("[%w_]") do
        end_col = end_col + 1
    end
    end_col = end_col - 1

    return line:sub(start_col, end_col)
end

-- コールバックシグネチャを挿入
function M.insert_callback_signature()
    local word = get_word_under_cursor()
    local callback_info = M.glfw_callbacks[word]

    if not callback_info then
        -- バッファ内の全テキストから関数名を探す
        local bufnr = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local text = table.concat(lines, "\n")

        for func_name, info in pairs(M.glfw_callbacks) do
            if text:find(func_name) then
                callback_info = info
                word = func_name
                break
            end
        end
    end

    if callback_info then
        vim.ui.select(
            {"void function", "lambda", "show signature"},
            {
                prompt = "Select callback type for " .. word .. ":",
            },
            function(choice)
                if not choice then return end

                if choice == "void function" then
                    local template = string.format(
                        "void callbackName(%s) {\n    // TODO: implement\n}",
                        callback_info.params
                    )
                    vim.api.nvim_put({template}, "l", true, true)
                elseif choice == "lambda" then
                    local template = string.format(
                        "auto callbackName = [](%s) {\n    // TODO: implement\n};",
                        callback_info.params
                    )
                    vim.api.nvim_put({template}, "l", true, true)
                elseif choice == "show signature" then
                    vim.notify(
                        string.format("%s:\n%s\nParameters: %s",
                            word,
                            callback_info.description,
                            callback_info.params),
                        vim.log.levels.INFO
                    )
                end
            end
        )
    else
        vim.notify("No callback information found for: " .. word, vim.log.levels.WARN)
    end
end

-- LSPから関数のシグネチャを取得してコールバックを推論
function M.infer_callback_from_lsp()
    local params = vim.lsp.util.make_position_params()

    vim.lsp.buf_request(0, 'textDocument/hover', params, function(err, result, ctx, config)
        if err then
            vim.notify("LSP error: " .. vim.inspect(err), vim.log.levels.ERROR)
            return
        end

        if not result or not result.contents then
            vim.notify("No hover information available", vim.log.levels.WARN)
            return
        end

        -- ホバー情報を表示
        local contents = result.contents
        local markdown = ""

        if type(contents) == "string" then
            markdown = contents
        elseif contents.value then
            markdown = contents.value
        elseif type(contents) == "table" and contents[1] then
            if type(contents[1]) == "string" then
                markdown = contents[1]
            elseif contents[1].value then
                markdown = contents[1].value
            end
        end

        -- シグネチャから引数の型を抽出（簡易版）
        local callback_pattern = "void%s*%(%*%)%s*%((.-)%)"
        local params_match = markdown:match(callback_pattern)

        if params_match then
            local template = string.format(
                "void callbackName(%s) {\n    // TODO: implement\n}",
                params_match
            )
            vim.notify("Callback signature:\n" .. template, vim.log.levels.INFO)
        else
            vim.notify("Full signature:\n" .. markdown, vim.log.levels.INFO)
        end
    end)
end

-- コマンドを設定
function M.setup()
    vim.api.nvim_create_user_command('InsertCallback', M.insert_callback_signature, {})
    vim.api.nvim_create_user_command('InferCallback', M.infer_callback_from_lsp, {})

    -- キーマッピング（C/C++ファイル専用）
    vim.api.nvim_create_autocmd("FileType", {
        pattern = {"c", "cpp"},
        callback = function()
            vim.keymap.set('n', '<leader>cb', M.insert_callback_signature,
                { buffer = true, desc = "Insert callback signature" })
            vim.keymap.set('n', '<leader>ci', M.infer_callback_from_lsp,
                { buffer = true, desc = "Infer callback from LSP" })
        end,
    })
end

return M
