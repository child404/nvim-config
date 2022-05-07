--[[ options.lua ]]
local opt = vim.opt
local cmd = vim.cmd

-- Options that didnt fit in other files
vim.g.t_co = 256
vim.g.background = "dark"

local options = {
    backup = false, -- no backup
    swapfile = false, -- no swap file
    clipboard = "unnamedplus", -- access to system clipboard
    cmdheight = 2, -- more space in command line
    completeopt = { "menuone", "noselect" }, -- settings for cmp plugin
    mouse = "a", -- enable mouse
    conceallevel = 0, -- so that `` is visible in markdown files
    pumheight = 10, -- pop up menu height
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds, 100-200 is too fast)
    updatetime = 300, -- faster completion (4000ms default)
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited


    colorcolumn = "120", -- show col for max num of lines
    number = true, -- show line numbers
    relativenumber = true, -- show relative line numbers
    scrolloff = 7, -- when to stop scrolling (lines before the bottom)
    sidescrolloff = 7,
    signcolumn = "yes", -- column on the left side
    cursorline = true, -- highlight the current line
    numberwidth = 4, -- set number column width to 2 {default 4}
    wrap = false, -- display lines as one long line

    encoding = "utf-8", -- same as the next ???
    fileencoding = "utf-8", -- encoding written to a file
    undofile = true, -- undo file even after reopening
    syntax = "ON", -- enable syntax highlighting
    termguicolors = true, -- enable terminal colors

    ignorecase = true, -- ignore case in search
    smartcase = true, -- ingore previous if uppercase in search
    incsearch = true, -- increment search
    hlsearch = true, -- highlight matched text

    expandtab = true, -- tabs to spaces
    shiftwidth = 4, -- num of spaces for each indent
    softtabstop = 4, -- same as the next ???
    tabstop = 4, -- 4 spaces for a tab
    showtabline = 2, -- always show tabs
    smartindent = true, -- make indenting smarter again
    autoindent = true, -- make indenting smarter again

    splitright = true, -- vsplit window opens at the right
    splitbelow = true, -- hsplit window opens at the bottom
}

opt.shortmess:append "c"

for k, v in pairs(options) do
    opt[k] = v
end

cmd "set whichwrap+=<,>,[,],h,l"
cmd [[set iskeyword+=-]]

-- PYTHON SET UP - delete trailing whitespaces - indentation based on python keywords
cmd [[
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 smarttab expandtab autoindent
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
]]

-- Access to Windows clipboard
cmd [[
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
]]
