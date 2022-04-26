local venom_status_ok, venom = pcall(require, "venom")
if not venom_status_ok then
    return
end

venom.setup({
    auto_activate = true,
    echo = false,
    quiet = true,
    symbol = "🐍",
    root_patterns = { ".venv", ".python-version", "venv", "*venv", "venv*", "env", "env*" },
    -- use_tools = true,
    -- tools = {},
})
