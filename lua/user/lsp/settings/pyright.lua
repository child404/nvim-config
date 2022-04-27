-- TODO: find venv and set pyrightconfig.json in settings rather than creating the file

local function get_python_path ()
    if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. "/bin/python"
    end
    return "/bin/usr/python"
end

return {
    before_init = function(_, config)
        config.settings.python.pythonPath = get_python_path()
    end,
    settings = {
        python = {
            analysis = {
                -- typeCheckingMode = "off"
            },
        }
    },
}
