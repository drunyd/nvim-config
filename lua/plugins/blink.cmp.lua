return {
  {
    "saghen/blink.cmp",
    version = "v0.*", -- optional, but safer
    dependencies = {
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
    },
    opts = {
      snippets = {
        preset = "luasnip",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      cmdline = {
        enabled = false,
        sources = {}, -- required if you want to disable cmdline completions
      },
      completion = {
        list = {
          selection = {
            auto_insert = false,
          },
        },
        accept = {
          auto_brackets = { enabled = true },
        },
        menu = {
          border = "rounded",
          winblend = 10,
          winhighlight = "Normal:CatppuccinSurface0,FloatBorder:CatppuccinSurface2,Search:None",
          draw = { treesitter = { "lsp" } },
        },
        documentation = {
          auto_show = true,
          window = {
            border = "rounded",
            winblend = 10,
            winhighlight = "Normal:CatppuccinSurface0,FloatBorder:CatppuccinSurface2,Search:None",
          },
          auto_show_delay_ms = 100,
        },
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
          winblend = 10,
          winhighlight = "Normal:CatppuccinSurface0,FloatBorder:CatppuccinSurface2,Search:None",
        },
      },
      keymap = {
        preset = "default",
        ["<C-space>"] = { "show", "hide" },
        ["<C-e>"] = { "show_documentation", "hide_documentation" },
      },
    },
  },
}
