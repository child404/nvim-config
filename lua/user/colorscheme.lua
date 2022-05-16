--[[ colorscheme.lua ]]

-- vim.g.italic_comments = true
-- vim.g.italic_keywords = true
-- vim.g.italic_functions = true
-- vim.g.italic_variables = true
-- vim.g.transparent_background = true
-- --
-- vim.cmd [[
--     au Colorscheme * :hi Keyword gui=italic cterm=italic
--     au Colorscheme * :hi Conditional gui=italic cterm=italic
--     au Colorscheme * :hi Repeat gui=italic cterm=italic
--     au Colorscheme * :hi Statement gui=italic cterm=italic
--     au Colorscheme * :hi Include gui=italic cterm=italic
--
--     au Colorscheme * :hi Identifier gui=italic cterm=italic
-- ]]

-- -- Lua
-- require('onedark').setup  {
--     -- Main options --
--     style = 'warm', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
--     transparent = false,  -- Show/hide background
--     term_colors = true, -- Change terminal color as per the selected theme style
--     ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
--     cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
--     -- toggle theme style ---
--     toggle_style_key = '<leader>ts', -- Default keybinding to toggle
--     toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between
--
--     -- Change code style ---
--     -- Options are italic, bold, underline, none
--     -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
--     code_style = {
--         comments = 'italic',
--         keywords = 'italic',
--         functions = 'none',
--         strings = 'none',
--         variables = 'none'
--     },
--
--     -- Custom Highlights --
--     colors = {}, -- Override default colors
--     highlights = {}, -- Override highlight groups
--
--     -- Plugins Config --
--     diagnostics = {
--         darker = true, -- darker colors for diagnostic
--         undercurl = true,   -- use undercurl instead of underline for diagnostics
--         background = true,    -- use background color for virtual text
--     },
-- }
-- require('onedark').load()

vim.g.tokyodark_transparent_background = false
vim.g.tokyodark_enable_italic_comment = true
vim.g.tokyodark_enable_italic = true
vim.g.tokyodark_color_gamma = "1.0"
vim.cmd("colorscheme tokyodark")

-- vim.cmd [[
-- try
--     colorscheme darkplus
-- catch /^Vim\%((\a\+)\)\=:E185/
--     colorscheme default
--     set background=dark
-- endtry
-- ]]
