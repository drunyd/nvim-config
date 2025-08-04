-- List of favorite files/marks per project
return {
    -- https://github.com/ThePrimeagen/harpoon
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    event = 'VeryLazy',
    dependencies = {
        -- https://github.com/nvim-lua/plenary.nvim
        'nvim-lua/plenary.nvim',
    },
    opts = {
        menu = {
            width = 120
        }
    },
    config = function(_, opts)
        local harpoon = require("harpoon")
        harpoon:setup(opts)

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end)
    end,
}
