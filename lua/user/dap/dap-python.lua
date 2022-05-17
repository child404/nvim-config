local dap_python_status_ok, dap_python = pcall(require, "dap-python")
if not dap_python_status_ok then
    return
end

dap_python.setup("~/.virtualenvs/debugpy/bin/python")

local function get_python_path(workspace)
    -- Use activated virtualenv.
    local util = require("lspconfig/util")

    local path = util.path
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
    end

    -- Find and use virtualenv in workspace directory.
    for _, pattern in ipairs({ "*", ".*" }) do
        local match = vim.fn.glob(path.join(workspace or vim.fn.getcwd(), pattern, "pyvenv.cfg"))
        if match ~= "" then
            return path.join(path.dirname(match), "bin", "python")
        end
    end

    -- Fallback to system Python.
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

local dap = require"dap"

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        justMyCode = false,
        program = "${file}",
        console = "internalConsole",
        pythonPath = get_python_path(),
    },
    {
        type = "python",
        request = "attach",
        name = "Attach remote",
        justMyCode = false,
        pythonPath = get_python_path(),
        host = function()
            local value = vim.fn.input("Host [127.0.0.1]: ")
            if value ~= "" then
                return value
            end
            return "127.0.0.1"
        end,
        port = function()
            return tonumber(vim.fn.input("Port [5678]: ")) or 5678
        end,
    },
}
