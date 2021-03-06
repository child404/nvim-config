-- The settings are almost basic (from plugin GH repo)
local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
    return
end

dapui.setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    layouts = {
        {
            elements = {
                -- Provide as ID strings or tables with "id" and "size" keys
                {
                    id = "scopes",
                    size = 0.4, -- Can be float or integer > 1
                },
                { id = "breakpoints", size = 0.2 },
                { id = "stacks", size = 0.2 },
                { id = "watches", size = 0.2 },
            },
            size = 60,
            position = "left", -- Can be "left", "right", "top", "bottom"
        },
        {
            elements = {"repl"}, -- kind of disables the repl
            size = 15,
            position = "bottom", -- Can be "left", "right", "top", "bottom"
        } 
    },
    -- sidebar = {
    --     -- You can change the order of elements in the sidebar
    --     elements = {
    --         -- Provide as ID strings or tables with "id" and "size" keys
    --         {
    --             id = "scopes",
    --             size = 0.4, -- Can be float or integer > 1
    --         },
    --         { id = "breakpoints", size = 0.2 },
    --         { id = "stacks", size = 0.2 },
    --         { id = "watches", size = 0.2 },
    --     },
    --     size = 60,
    --     position = "left", -- Can be "left", "right", "top", "bottom"
    -- },
    -- tray = {
    --     elements = {"repl"}, -- kind of disables the repl
    --     size = 15,
    --     position = "bottom", -- Can be "left", "right", "top", "bottom"
    -- },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    }
})

-- Integration with the dap actions
local dap = require "dap"

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
