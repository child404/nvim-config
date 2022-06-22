vim.g.venom_loaded = 1

local venom_status_ok, venom = pcall(require, "venom")

if not venom_status_ok then
    return
end

venom.setup({
    auto_activate = true,
    echo = true,
    quiet = false,
    symbol = "🐍",
    root_patterns = { ".venv", ".python-version", "venv", "*venv", "venv*", "env", "env*" },
    -- use_tools = true,
    -- tools = {},
})
