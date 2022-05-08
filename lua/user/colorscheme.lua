--[[ colorscheme.lua ]]

vim.g.italic_comments = true
vim.g.italic_keywords = true
vim.g.italic_functions = true
vim.g.italic_variables = true
vim.g.transparent_background = true

vim.cmd [[
try
    colorscheme darkplus
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
endtry
]]
