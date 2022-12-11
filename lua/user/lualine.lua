local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info" },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    -- diagnostics_color = {
    --     color_error = { fg = '#ec5f67' },
    --     color_warn = { fg = '#ECBE7B' },
    --     color_info = { fg = '#008080' },
    -- },
    colored = false,
    update_in_insert = false,
    always_visible = true,
}

local diff = {
    "diff",
    colored = true,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width
}

local mode = {
    function()
        return " "
    end,
    padding = { left = 0, right = 0 },
    color = {},
    cond = nil,
}

local filetype = {
    "filetype",
    icons_enabled = false,
    icon = nil,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
    color = { gui = "bold" },
}

local location = {
    "location",
    padding = 0,
}

-- cool function for progress
local progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
end

local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local function lsp_provider()
    local clients = {}
    local icon = ' LSP: '
    for _, client in pairs(vim.lsp.buf_get_clients()) do
        if client.name == "pyright" then
            if client.config.settings.python["pythonPath"] ~= nil then
                local venv_name = string.match(vim.env.VIRTUAL_ENV, "[^/]+$")
                clients[#clients + 1] = icon .. client.name .. '(' .. venv_name .. ')'
            end
        else
            if client.name ~= "null-ls" then
                clients[#clients + 1] = icon .. client.name
            end
        end
    end
    return table.concat(clients, ' ')
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            "alpha", "dashboard", "NvimTree", "Outline", "toggleterm",
            "dapui_breakpoints", "dapui_scopes", "dapui_stacks", "dapui_watches", "dap-repl",
        },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { mode },
        lualine_b = {},
        lualine_c = { branch, diagnostics, lsp_provider },
        -- lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_x = { diff, spaces, "encoding", filetype },
        lualine_y = { location },
        lualine_z = { progress },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
