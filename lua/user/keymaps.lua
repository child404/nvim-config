--[[ keysmaps.lua ]]
-- Most of the keymaps are not needed due to the which-keys plugin (a lot of them are specified there)
-- Check which-keys.lua for more details
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- Set <leader> key
vim.g.mapleader = " "
vim.g.localleader = " "

-- Remap hjkl to jkl;
map("", ";", "l", opts)
map("", "l", "k", opts)
map("", "k", "j", opts)
map("", "j", "h", opts)
map("i", "<C-j>", "<BS>", { silent = true })

-- Easier window navigation
map("n", "<C-j>", "<C-w>h", opts)
map("n", "<C-k>", "<C-w>j", opts)
map("n", "<C-l>", "<C-w>k", opts)
map("n", "<C-w>;", "<C-w>l", opts) -- no way to bind Ctrl+Semicolon in vim

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize +2<CR>", opts)
map("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Easier buffer navigation
map("n", "<C-K>", ":bnext<CR>", opts)
map("n", "<C-L>", ":bprevious<CR>", opts)

vim.cmd [[
    autocmd FileType python map <buffer> <C-X> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType python imap <buffer> <C-X> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
]]

-- Easier save/close
-- map("n", "<leader>qq", ":q<CR>", opts)
-- map("n", "<leader>ww", ":w<CR>", opts)
-- map("n", "<leader>wq", ":wq<CR>", opts)
-- map("n", "<leader>q1", ":q!<CR>", opts)

-- Reload lua module
-- map("n", "<leader>rr", ":luafile %<CR>", opts)

-- NeovimTree
-- map("n", "<leader>n", [[:NvimTreeToggle<CR>]], opts)

-- Telescope
-- map("n", "<leader>ff", ":lua require(\"telescope.builtin\").find_files(require('telescope.themes').get_dropdown())<CR>", opts)
-- map("n", "<leader>fg", ":lua require(\"telescope.builtin\").live_grep(require('telescope.themes').get_dropdown())<CR>", opts)
-- map("n", "<leader>fb", ":lua require(\"telescope.builtin\").buffers(require('telescope.themes').get_dropdown())<CR>", opts)
-- map("n", "<leader>fh", ":lua require(\"telescope.builtin\").help_tags(require('telescope.themes').get_dropdown())<CR>", opts)
-- map("n", "<leader>fm", ":lua require(\"telescope.builtin\").media_files(require('telescope.themes').get_dropdown())<CR>", opts)

-- Disable highlighted search items by leader + Space
-- <leader>h specified in the which-keys plugin
-- map("n", "<leader><Space>", ":nohlsearch<CR>", opts)
