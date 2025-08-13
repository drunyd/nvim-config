require("core.options")
require("core.lazy")
require("core.lsp")
require("core.keymaps")
require("core.autocmds")
vim.filetype.add({
  extension = {
    NAT = "natural",
    nat = "natural", -- ha kisbetűs is lehet
  },
})
