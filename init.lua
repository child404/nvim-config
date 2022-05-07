--[[ init.lua ]]

-- Speed up plugin's loading time
require "impatient"

-- IMPORTS
require "user.options" -- Options
require "user.keymaps" -- Keymaps
require "user.plugins" -- Plugins
require "user.colorscheme" -- Colorsheme
require "user.cmp" -- Autocompletion
require "user.lsp" -- LSP settings

-- PLUGINS SETUP
require "user.lualine" -- awesome line at the buttom
require "user.nvim-tree" -- file manager, toggles on <leader>e (nerdtree replacement)
require "user.nvim-autopairs" -- auto close parentheses and wrap sumbols in quotes (by pressing Alt+e)
require "user.telescope" -- fuzzy finder, <leader>f/F/P/s to check available options
require "user.highlightedyank" -- highlight lines you yanked
require "user.treesitter" -- helps to better highlight syntax and context comments
require "user.comment" -- comment single line by pressing gj, indent lines and press
-- gc in visual mode to comment multiple lines, more powerful comments in normal mode
require "user.gitsigns" -- git highlighting and handling changes
require "user.bufferline" -- awesome tabs (buffers) at the top Shifts+k/l to navigate,
-- <leader>c to close the buffer, <leader>b to search through the buffers
require "user.alpha" -- awesome greeter, press <leader>a or launch nvim
require "user.project" -- project manager, press <leader>P
require "user.which-key" -- hints for available key-combinations, emacs-like (activates on <leader> key)
require "user.indentline" -- line indentation in code blocks
require "user.toggleterm" -- <leader>t to check available options
require "user.dap" -- powerful debugging tool, see <leader>d for more options
require "user.lazygit" -- lazygit integration with neovim
require "user.nvim-venom" -- automatically detect python virtualenv
require "user.nvim-trouble" -- open diagnostic list
require "user.nvim-lsp-signature" -- live signature for functions
require "user.lsp-saga"

-- require "user.nvim-lsp-status" -- figure out how does it work
-- require "user.csvtools"

-- TODO:
-- 1) Install more plugins from https://github.com/cwebster2/vim/blob/main/lua/cwebster/plugins.lua
--
-- 2) write a plugin to store virtualenvs (mb just use pyenv) and get them using telescope (like activate through the telescope);
--    activation etc. will be done by the vim-venom plugin (fork?);
--    to not activate venv through searching some venv dir, but to select venv for the project and store its {path_to_project: venv_name};
--    then just restore the latest venv used for current project;
--    but save the option to just activate env that was found for the file (if project is not found) by the vim-venom;
--
-- 3) dap test integration;
-- 4) check if some plugins can be lazyloaded;
-- 5) write README for this repo;
--
-- 6) configure pyright (but the basic setup is more than enough);
-- 7) configure rust_analyzer (rust-tools);
-- 8) figure out lazygit + gitsigns combination;

-- WANNA INSTALL
--
-- sql manager (connecting to db);
-- sql completion (lsp - kristijanhusak/vim-dadbod-completion);
-- cmp treesitter (ray-x/cmp-treesitter);
-- cmp nvim lua (hrsh7th/cmp-nvim-lua);
-- cmp tabnine (tzachar/cmp-tabnine);
-- rust-tools and crates cmp for lsp + rust linter?;
-- cpp lsp and linter;
-- latex cmp ant tools;
