local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
    ["B"] = {
        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "Buffers",
    },
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    ["w"] = { "<cmd>w!<CR>", "Save" },

    q = {
        name = "Quit",
        q = { "<cmd>q<cr>", "Quit" },
        w = { "<cmd>wq!<cr>", "Save and quit" },
        d = { "<cmd>q!<cr>", "Quit and discard changes" },
    },

    ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
    ["R"] = { "<cmd>w<cr><cmd>luafile %<CR>", "Reload lua" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["f"] = {
        "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "Find files",
    },
    ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

    ["X"] = { "<cmd>w<cr><cmd>exe v:count1 . \"TermExec cmd='python %' size=15 direction='float'\"<cr>", "Run python" },

    r = {
        name = "Rust",
        a = {"<cmd>RustCodeAction<cr>", "Code Action"},
        E = {"<cmd>RustExpand<cr>", "Expand"},
        e = {"<cmd>RustExpandMacro<cr>", "Expand Macro"},
        f = {"<cmd>RustFmt<cr>", "Format"},
        F = {"<cmd>RustFmtRange<cr>", "Format Range"},
        h = {"<cmd>RustHoverActions<cr>", "Hover Actions"},
        u = {"<cmd>RustMoveItemUp<cr>", "Move Item Up"},
        d = {"<cmd>RustMoveItemDown<cr>", "Move Item Down"},
        D = {"<cmd>RustDebuggables<cr>", "Debuggables"},
        c = {"<cmd>RustOpenCargo<cr>", "Cargo.toml"},
        r = {"<cmd>RustRun<cr>", "Run"},
        R = {"<cmd>RustRunnables<cr>", "Runnables"},
        w = {"<cmd>RustReloadWorkspace<cr>", "Reload Workspace"},
        s = {"<cmd>RustSSR<cr>", "SSR"},
        g = {"<cmd>RustViewCrateGraph<cr>", "Crate Graph"},
        j = {"<cmd>RustJoinLines<cr>", "Join Lines"},
        p = {"<cmd>RustParentModule<cr>", "Parent Module"},
    },

    -- Debuggig keys
    ["b"] = {"<cmd>lua require'dap'.toggle_breakpoint();store_breakpoints(false)<cr>", "Breakpoint"},
    ["i"] = {"<cmd>DapStepInto<cr>", "Step into"},
    ["o"] = {"<cmd>DapStepOver<cr>", "Step over"},
    ["O"] = {"<cmd>DapStepOut<cr>", "Step out"},
    d = {
        name = "Debug",
        d = {"<cmd>w<cr><cmd>DapContinue<cr>", "Debug/Continue"},
        D = {"<cmd>lua require'dap'.clear_breakpoints();store_breakpoints(true)<cr>", "Delete breakpoints"},
        r = {"<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to cursor"},
        R = {"<cmd>DapToggleRepl<cr>", "Repl"},
        c = {"<cmd>Telescope dap commands<cr>", "Commands"},
        l = {"<cmd>Telescope dap list_breakpoints<cr>", "List breakpoints"},
        f = {"<cmd>Telescope dap frames<cr>", "Frames"},
        F = {"<cmd>Telescope dap configurations<cr>", "Configurations"},
        t = {"<cmd>DapTerminate<cr>", "Terminate"},
        v = {"<cmd>Telescope dap variables<cr>", "Variables"},
        h = {"<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover"},
        s = {"<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<cr>", "Scopes"},
        e = {"<cmd>lua require('dapui').eval()<cr>", "Eval/Inspect"},
        C = {"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Condition breakpoint"},
        L = {"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", "Log breakpoint"},
    },

    -- DBUI keys
    x = {
        name = "Databases",
        u = {"<cmd>DBUIToggle<CR>", "Toggle UI"},
        f = {"<cmd>DBUIFindBuffer<CR>", "Find buffer"},
        r = {"<cmd>DBUIRenameBuffer<CR>", "Rename buffer"},
        l = {"<cmd>DBUILastQueryInfo<CR>", "Last query"},
    },

    -- Packer
    p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    -- Git
    g = {
        name = "Git",
        g = { "<cmd>LazyGit<CR>", "Lazygit" },
        v = { "<cmd>lua require('telescope').extensions.lazygit.lazygit()<CR>", "View repos" },
        k = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        l = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        h = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk",
        },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Diff",
        },
    },

    -- LSP
    l = {
        name = "LSP",
        a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
        d = {
            "<cmd>Trouble document_diagnostics<cr>",
            "Document Diagnostics",
        },
        w = {
            "<cmd>Trouble workspace_diagnostics<cr>",
            "Workspace Diagnostics",
        },
        f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
        F = { "<cmd>Lspsaga lsp_finder<cr>", "Find definition"},
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
        k = {
            "<cmd>Lspsaga diagnostic_jump_next<cr>",
            "Next Diagnostic",
        },
        l = {
            "<cmd>Lspsaga diagnostic_jump_prev<cr>",
            "Prev Diagnostic",
        },
        c = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
        r = { "<cmd>Lspsaga rename<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
        n = {"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", "Doc scroll down"},
        p = {"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", "Doc scroll up"},
        D = {"<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", "Preview definition"}
    },
    s = {
        name = "Search",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
    },

    -- Terminal
    t = {
        name = "Terminal",
        T = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" }, -- the same as for lazygit, shortcuts are broken due to vim normal mode
        p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        h = { "<cmd>exec v:count1 . \"ToggleTerm size=15 direction=horizontal\"<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=60 direction=vertical<cr>", "Vertical" },
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)
