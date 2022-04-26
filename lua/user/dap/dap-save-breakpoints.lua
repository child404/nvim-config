HOME = os.getenv("HOME")
local breakpoints = require('dap.breakpoints')
local breakpoints_fp = '/.cache/dap/breakpoints.json'

function _G.store_breakpoints(clear)
    local load_bps_raw = io.open(HOME .. breakpoints_fp, 'r'):read("*a")
    local bps = {}
    if string.len(load_bps_raw) ~= 0 then
        bps = vim.fn.json_decode(load_bps_raw)
    end
    local opened_buffers = vim.api.nvim_list_bufs()
    if (clear) then
        for _, bufrn in ipairs(opened_buffers) do
            bps[vim.api.nvim_buf_get_name(bufrn)] = nil
        end
    else
        local breakpoints_by_buf = breakpoints.get()
        for _, bufrn in ipairs(opened_buffers) do
            bps[vim.api.nvim_buf_get_name(bufrn)] = breakpoints_by_buf[bufrn]
        end
    end
    local fp = io.open(HOME .. breakpoints_fp, 'w')
    fp:write(vim.fn.json_encode(bps))
    fp:close()
end

function _G.load_breakpoints()
    local content = io.open(HOME .. breakpoints_fp, 'r'):read('*a')
    if string.len(content) == 0 then
        return
    end
    local bps = vim.fn.json_decode(content)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local file_name = vim.api.nvim_buf_get_name(buf)
        if bps[file_name] ~= nil then
            for _, bp in pairs(bps[file_name]) do
                local line = bp.line
                local opts = {
                    condition = bp.condition,
                    log_message = bp.logMessage,
                    hit_condition = bp.hitCondition
                }
                breakpoints.set(opts, tonumber(buf), line)
            end
        end
    end
end
