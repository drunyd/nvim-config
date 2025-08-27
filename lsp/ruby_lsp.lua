local capabilities = require('blink.cmp').get_lsp_capabilities()

return {
    cmd = { "ruby-lsp" }, -- safer for per-project gems
    filetypes = { "ruby", "eruby" },
    root_markers = {
        "Gemfile",
        ".git"
    },
    init_options = {
        formatter = "rubocop",
        linters = { "rubocop" },
        addonSettings = {
            ["Ruby LSP Rails"] = {
                enablePendingMigrationsPrompt = false,
            },
        },
    },
    capabilities = capabilities,
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
}
