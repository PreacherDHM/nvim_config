require("mason").setup()
require("mason-lspconfig").setup()

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'single'
    opts.max_width = opts.max_width or 80
    opts.wrap_at = opts.wrap_at or 50
    local str = ""
    local line = 0
    for v, b in ipairs(contents) do
        str = str .. b .. ':' ..v .. '\n'
        line = line + 1
        contents[v] = string.gsub(contents[v], "\\", "")
        --if string.len(contents[v]) < 2 then
        --    table.remove(contents,v)
        --end
    end
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

omnisharp_server_location = "C:\\omnisharp\\omnisharp-win-arm64\\OmniSharp.exe"


-- Setup language servers.
local lspconfig = require('lspconfig')

lspconfig.marksman.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "C:/marksman/marksman.exe" }
})

-- OmniSharp
lspconfig.omnisharp.setup({
    --cmd = { "C:/Users/bakkenl/scoop/shims/OmniSharp.exe", "--languageserver", "--hostPID", tostring(pid) },
    --cmd = {"C:/omnisharp/omnisharp-win-x64/OmniSharp.exe", "--languageserver", "--hostPID", tostring(pid) },
    cmd = { "dotnet", "C:/Users/jesse/AppData/Local/nvim-data/mason/packages/omnisharp/libexec/OmniSharp.dll" },
    capabilities = capabilities,
    on_attach = on_attach, --function (client, bufnr)
    --  -- https://github.com/OmniSharp/omnisharp-roslyn/issues/2483#issuecomment-1492605642
    --  local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
    --  for i, v in ipairs(tokenModifiers) do
    --    tmp = string.gsub(v, ' ', '_')
    --    tokenModifiers[i] = string.gsub(tmp, '-_', '')
    --  end
    --  local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
    --  for i, v in ipairs(tokenTypes) do
    --    tmp = string.gsub(v, ' ', '_')
    --    tokenTypes[i] = string.gsub(tmp, '-_', '')
    --  end
    --  on_attach(client, bufnr)
    --end,
    --flags = {
    --  debounce_text_changes = 150,
    --}
})
--lspconfig.omnisharp_mono.setup({
--})
lspconfig.clangd.setup {
    cmd = { 'clangd' },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "h", "hpp" },
    --signal_filesupport = true
}

lspconfig.cmake.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.pyright.setup {
    signal_filesupport = true,
    auto_start = true

}
lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT', --version of Lua to use
                path = runtime_path,
            },
            diagnostics = {
                globals = { 'vim', 'use', 's', 'sn', 'i', 'rep', 'c', 'd', 'f', 't', 'fmta', 'fmt' },
                ignoredFiles = "Opened",
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
            workspace = {
                maxPreload = 11,
                preloadFileSize = 10,
                -- Make the server aware of Neovim runtime files
                library = {
                    vim.fn.expand('$VIMRUNTIME/lua'),
                    vim.fn.expand('$VIMRUNTIME/lua/vim/lsp'),
                },
                --ignoreDir = { "main/", "lua/" }
            },
        },
    },
}



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
        vim.keymap.set('n', '<space>cf', vim.lsp.buf.format, opts)
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
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
