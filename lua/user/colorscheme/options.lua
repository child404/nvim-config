vim.g.italic_comments = true
vim.g.italic_keywords = true
vim.g.italic_functions = true
vim.g.italic_variables = true
vim.g.transparent_background = false
--
vim.cmd [[
    au Colorscheme * :hi Keyword gui=italic cterm=italic
    " au Colorscheme * :hi Conditional gui=italic cterm=italic
    " au Colorscheme * :hi Repeat gui=italic cterm=italic
    au Colorscheme * :hi Statement gui=italic cterm=italic
    au Colorscheme * :hi Include gui=italic cterm=italic

    au Colorscheme * :hi Identifier gui=italic cterm=italic
]]
