-- [[ plugins.lua ]]

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

return packer.startup(function(use)
    -- Plugins
    use "wbthomason/packer.nvim" -- packer itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
    use "kyazdani42/nvim-web-devicons" -- icons for nvimtree/lualine

    use "lewis6991/impatient.nvim" -- speed up plugin loading

    use "goolord/alpha-nvim" -- awesome greeter (at startup)
    use "danilamihailov/beacon.nvim" -- lighting cursor on jumps
    use "machakann/vim-highlightedyank" -- highlight lines you yanked
    use "windwp/nvim-autopairs" -- automatically (smart) close brackets
    use "nvim-lualine/lualine.nvim" -- cool status line
    use "kyazdani42/nvim-tree.lua" -- replacement of nerdtree
    use "folke/which-key.nvim" -- shows keymaps while pressing
    use "lukas-reineke/indent-blankline.nvim" -- line indentation
    use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
    use "akinsho/toggleterm.nvim" -- toggle terminal tools

    -- Git (may be some more plugins here), awesome in combination with lazygit
    use "lewis6991/gitsigns.nvim"
    use "kdheepak/lazygit.nvim"

    -- Telescope (media files doesnt work without ueberzug)
    use "nvim-telescope/telescope.nvim" -- fuzzy finder
    -- use "nvim-telescope/telescope-media-files.nvim" -- support for media files (e.g. pics)
    use "ahmedkhalf/project.nvim" -- managing the projects

    -- Treesitter: enhancements in highlighting and virtual text
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "numToStr/Comment.nvim" -- commenting stuff
    use "JoosepAlviste/nvim-ts-context-commentstring" -- commenting depends on context

    -- Buffer
    use "akinsho/bufferline.nvim"
    use "moll/vim-bbye"

    -- Colorschemes
    use "RRethy/nvim-base16" -- base16 colorschemes
    use "lunarvim/darkplus.nvim" -- vscode-like colorscheme
    use "Mofiqul/vscode.nvim" -- vscode-like colorscheme, more support/commits than previous

    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp" -- lsp completions
    use {'tzachar/cmp-tabnine', run='./install.sh' }
    use "hrsh7th/cmp-nvim-lua"

    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

    -- Debugging
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } } -- UI for dap
    use "theHamsta/nvim-dap-virtual-text" -- display variables while debugging
    use "nvim-telescope/telescope-dap.nvim" -- integration with telescope (Telescope dap ...)
    use "mfussenegger/nvim-dap-python" -- python integration with dap

    -- autovenv for python
    use { 'rafi/vim-venom', ft = { 'python' }, config = 'require("venom").setup()' }
    -- autoindent for python
    use "Vimjas/vim-python-pep8-indent"


    -- Testing
    -- check out https://github.com/rcarriga/vim-ultest and https://github.com/rcarriga/vim-ultest/wiki/Debugging-Recipes
    -- use { "rcarriga/vim-ultest", requires = { "vim-test/vim-test" }, run = ":UpdateRemotePlugins" }

    -- Rust
    -- use "simrat39/rust-tools.nvim" -- Additional rust features such as inlay hints

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
