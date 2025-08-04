local capabilities = require('blink.cmp').get_lsp_capabilities()
return {
    cmd = {
        "lua-language-server",
    },
    filetypes = {
        "lua",
    },
    root_markers = {
        ".git",
        ".luacheckrc",
        ".luarc.json",
        ".luarc.jsonc",
        ".stylua.toml",
        "selene.toml",
        "selene.yml",
        "stylua.toml",
    },
    settings = {
        Lua = {
            diagnostics = {
            globals = { "vim", "require" },
                --     disable = { "missing-parameters", "missing-fields" },
            },
            telemetry = {
                enable = false,
            },
        },
    },
    capabilities = capabilities,
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
}
