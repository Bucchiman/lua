local on_attach = function(client, bufnr)

  -- LSPが持つフォーマット機能を無効化する
  -- →例えばtsserverはデフォルトでフォーマット機能を提供しますが、利用したくない場合はコメントアウトを解除してください
  --client.server_capabilities.documentFormattingProvider = false
  
  -- 下記ではデフォルトのキーバインドを設定しています
  -- ほかのLSPプラグインを使う場合（例：Lspsaga）は必要ないこともあります

local set = vim.keymap.set
    set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    set("n", "<C-m>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    set("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    set("n", "ma", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    set("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
    set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
    set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
end

-- 補完プラグインであるcmp_nvim_lspをLSPと連携させています（後述）
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp_lsp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end
-- (2022/11/1追記):cmp-nvim-lspに破壊的変更が加えられ、
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(
--  vim.lsp.protocol.make_client_capabilities()
-- )
-- ⇑上記のupdate_capabilities(...)の関数は非推奨となり、代わりにdefault_capabilities()関数が採用されました。日本語情報が少ないため、念の為併記してメモしておきます。

-- この一連の記述で、mason.nvimでインストールしたLanguage Serverが自動的に個別にセットアップされ、利用可能になります
-- Note: mason.setup() と mason-lspconfig.setup() は lazy.lua で既に呼ばれています
require("mason-lspconfig").setup_handlers({
    -- デフォルトハンドラー：全てのLSPに適用
    function (server_name)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
    -- 特定のLSPに対するカスタムハンドラー
    ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace"
                    },
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = {
                            'vim',
                            'require'
                        },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false
                    },
                    telemetry = {
                        enable = false,
                    }
                }
            }
        })
    end,
})


-- Setup language servers.
local lspconfig = require('lspconfig')

-- Note: pyright, rust_analyzer は mason-lspconfig の自動ハンドラーで処理されます
-- 個別の設定が必要な場合は、上記の setup_handlers 内にカスタムハンドラーを追加してください

-- lspconfig.pyright.setup {}
-- lspconfig.rust_analyzer.setup {
--   settings = {
--     ['rust-analyzer'] = {},
--   },
-- }

-- For neocmakelsp (correct setup)
-- Note: neocmake が mason でインストール可能なら、setup_handlers で処理されます
require('lspconfig').neocmake.setup({})

-- Note: lua_ls の設定は上記の setup_handlers 内に移動しました

-- clangd は詳細な設定があるため、個別にセットアップ
lspconfig.clangd.setup ({
    cmd = {
        "clangd",
        "--background-index",
        "--compile-commands-dir=.",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),

    init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true,
        semanticHighlighting = true,
        extraClangArguments = {"/opt/local/include"},
    },

    capabilities = capabilities,

    -- Diagnostics
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = { prefix = "", spacing = 0 },
                signs = true,
                update_in_insert = true,
            }
        ),
    },
    -- Code navigation
    -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),

    on_attach = function(client, bufnr)
        print("clangd is now attached!")

        -- インレイヒントを有効化（Neovim 0.10+）
        if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        -- カスタムキーマッピング
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- 挿入モードでのシグネチャヘルプ
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

        -- インレイヒントのトグル
        vim.keymap.set('n', '<leader>ih', function()
            if vim.lsp.inlay_hint then
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
            end
        end, opts)
    end,
    -- flags = {
    --     debounce_text_changes = 150,
    -- }
})

lspconfig.glslls.setup{}

-- コールバックヘルパーを初期化
require("plugins.config.callback-helper").setup()


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
