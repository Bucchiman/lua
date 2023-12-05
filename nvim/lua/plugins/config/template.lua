#!/usr/bin/env lua
--
-- FileName:     template
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-07-09 15:23:57
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
-- Description:  ---
--


local file = vim.fn.expand("%")

vim.api.nvim_create_autocmd (
    {"BufNewFile"},
    {
        pattern = {
            "*.lua"
        },
        callback = function ()
            print("Hello world!!")
            print("This is " .. file)
        end
    }
)

vim.api.nvim_create_autocmd(
    {"BufNewFile"},
    {
        pattern = {
            "*.c",
            "*.s",
            "*.h",
            "*.hpp",
            "*.cu",
            "*.cs",
            "*.cpp",
            "*.rs",
            "*.rb",
            "*.py",
            "*.lua",
            "*.vim",
            "*.md",
            "*.yaml",
            "*.sh",
            "*.zsh",
            "*.Dockerfile",
            "*.snippets",
            "*.asm",
        },
        command = "Template "..file.." template"
    }
)


vim.api.nvim_create_autocmd(
    {"BufNewFile"},
    {
        pattern = {
            "plugin.lua"
        },
        command = "Template "..file.." plugin"
    }
)

vim.api.nvim_create_autocmd(
    "BufNewFile",
    {
        pattern = "CMakeLists.txt",
        command = "Template "..file.." CMakeLists"
    }
)

vim.api.nvim_create_autocmd(
    "BufNewFile",
    {
        pattern = "Dockerfile",
        command = "Template "..file.." Dockerfile"
    }
)

vim.api.nvim_create_autocmd(
    "BufNewFile",
    {
        pattern = "Brun",
        command = "Template " .. file .. " Brun"
    }
)

vim.api.nvim_create_autocmd(
    "BufNewFile",
    {
        pattern = "docker-compose.yml",
        command = "Template "..file.." docker_compose"
    }
)

vim.api.nvim_create_autocmd(
    "BufNewFile",
    {
        pattern = "Makefile",
        command = "Template "..file.." Makefile"
    }
)

vim.api.nvim_create_autocmd(
    "BufNewFile",
    {
        pattern = "Cargo.toml",
        command = "Template " ..file.." Cargo"
    }
)




return {
    temp_dir = "$HOME/.config/template",
    author = "8ucchiman",
    email = "8ucchiman@gmail.com",
}
