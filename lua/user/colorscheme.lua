--[[ colorscheme.lua ]]

-- vim.g.vscode_style = "dark"
-- vim.cmd [[
-- try
--     colorscheme vscode
-- catch /^Vim\%((\a\+)\)\=:E185/
--     colorscheme default
--     set background=dark
-- endtry
-- ]]

vim.cmd [[
try
    colorscheme darkplus
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
endtry
]]
