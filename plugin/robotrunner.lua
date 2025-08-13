-- ~/.config/nvim/plugin/robotrunner.lua

-- Mini TOML parser for .robotrunner configs with order preservation
local function parse_robotrunner_toml(lines)
    local config = { order = {}, sections = {} }
    local current_section = nil
    for _, line in ipairs(lines) do
        local s = line:match("^%s*(.-)%s*$") -- trim spaces
        if s ~= "" and not s:match("^#") then
            local section = s:match("^%[(.+)%]$")
            if section then
                current_section = section
                if not config.sections[current_section] then
                    table.insert(config.order, current_section)
                    config.sections[current_section] = {}
                end
            else
                local key, val = s:match('^(%w+)%s*=%s*"(.-)"$')
                if key and val and current_section then
                    config.sections[current_section][key] = val
                end
            end
        end
    end
    return config
end
-- Search upward for .robotrunner file
local function find_robotrunner_file()
    local file = vim.fn.expand("%:p")
    local dir = vim.fn.fnamemodify(file, ":h")

    while dir ~= "/" do
        local candidate = dir .. "/.robotrunner.toml"
        if vim.fn.filereadable(candidate) == 1 then
            return candidate
        end
        dir = vim.fn.fnamemodify(dir, ":h")
    end
    return nil
end

-- Helper: find nearest test case name above cursor
local function find_nearest_testcase()
    local row = vim.api.nvim_win_get_cursor(0)[1] -- 1-based line number
    for i = row, 1, -1 do
        local line = vim.fn.getline(i)
        -- Match non-empty lines that aren't section headers
        if line:match("^%S") and not line:match("^%*%*%*") then
            return vim.trim(line)
        end
    end
    return nil
end

-- Modified run function to accept extra args

local function run_robot(prefix, args, filepath, extra_args)
    vim.cmd("split")
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(0, buf)

    local cmd = {}
    for word in string.gmatch(prefix, "%S+") do
        table.insert(cmd, word)
    end
    for word in string.gmatch(args or "", "%S+") do
        table.insert(cmd, word)
    end

    -- Append extra_args if it's a table
    if extra_args then
        if type(extra_args) == "table" then
            for _, v in ipairs(extra_args) do
                table.insert(cmd, v)
            end
        else
            -- fallback to string parsing (old behavior)
            for word in string.gmatch(extra_args, "%S+") do
                table.insert(cmd, word)
            end
        end
    end

    table.insert(cmd, filepath)

    vim.fn.termopen(cmd)
    vim.cmd("startinsert")
end

-- Config selection shared logic
local function select_and_run(extra_args)
    local filepath = vim.fn.expand("%:p")
    local config_file = find_robotrunner_file()
    if not config_file then
        vim.notify(".robotrunner config not found in project", vim.log.levels.ERROR)
        return
    end

    local configs = parse_robotrunner_toml(vim.fn.readfile(config_file))
    local menu = {}

    for _, name in ipairs(configs.order) do
        local tbl = configs.sections[name]
        table.insert(menu, { name = name, prefix = tbl.prefix, args = tbl.args })
    end

    vim.schedule(function()
        vim.ui.select(menu, {
            prompt = "Select RobotRunner config:",
            format_item = function(item)
                return string.format("%s → %s %s", item.name, item.prefix, item.args or "")
            end
        }, function(choice)
            if choice then
                run_robot(choice.prefix, choice.args, filepath, extra_args)
            end
        end)
    end)
end
-- Commands
vim.api.nvim_create_autocmd("FileType", {
    pattern = "robot",
    callback = function()
        vim.api.nvim_create_user_command("RunRobotBuffer", function()
            select_and_run(nil)
        end, {})

        vim.api.nvim_create_user_command("RunRobotTest", function()
            local testcase = find_nearest_testcase()
            if not testcase then
                vim.notify("No test case found above cursor", vim.log.levels.ERROR)
                return
            end
            select_and_run({ "-t", testcase })
        end, {})
        -- Add keymaps local to the buffer
        local opts = { noremap = true, silent = true, buffer = 0 }
        vim.keymap.set("n", "<leader>tb", ":RunRobotBuffer<CR>", opts)
        vim.keymap.set("n", "<leader>tt", ":RunRobotTest<CR>", opts)


        vim.notify("RobotRunner loaded for .robot file", vim.log.levels.INFO)
    end
})
