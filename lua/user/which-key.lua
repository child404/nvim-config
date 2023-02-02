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
        separator = "➜ ", -- symbol used between a key and it's label
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
    q = {
        name = "quit",
        q = { "<cmd>q<cr>", "Quit" },
        s = { "<cmd>wq!<cr>", "Save and quit" },
        d = { "<cmd>q!<cr>", "Quit and discard changes" },
    },

    f = {
        name = "file",
        s = { "<cmd>w!<CR>", "Save" },
        r = { "<cmd>lua require('telescope.builtin').oldfiles(require('telescope.themes').get_ivy{previewer = false})<cr>", "Recent File" },
        f = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy{previewer = false})<cr>", "Find Files" },
    },

    s = {
        name = "search",
        c = { "<cmd>nohlsearch<CR>", "No Highlight" },
        R = { "<cmd>lua require('telescope.builtin').registers(require('telescope.themes').get_ivy{previewer = false})<cr>", "Registers" },
        n = { "<cmd>lua require('telescope').extensions.notify.notify(require('telescope.themes').get_ivy{previewer = false})<cr>", "Notifications" },
        --[[ t = {"<cmd>lua require('telescope.previewers').vim_buffer_cat.new(require('telescope.themes').get_ivy{previewer = false})<cr>", "Cat Buffer"}, ]]
        --[[ g = {"<cmd>lua require('telescope.previewers').vim_buffer_vimgrep.new(require('telescope.themes').get_ivy{previewer = false})<cr>", "Grep Buffer"}, ]]
        b = {"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy{previewer = false})<cr>", "Search buffer"},
    },

    ["/"] = {"<cmd>lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy{previewer = false})<cr>", "Find Text"},

    [" "] = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy{previewer = false})<cr>", "Find File" },
    [","] = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy{previewer = false})<cr>", "Switch buffer" },
    ["."] = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy{previewer = false})<cr>", "Find Files" },

    ["X"] = { "<cmd>w<cr><cmd>exe v:count1 . \"TermExec cmd='python3 %' size=20 direction='horizontal'\"<cr>", "Run python" },

    r = {
        name = "rust",
        a = { "<cmd>RustCodeAction<cr>", "Code Action" },
        E = { "<cmd>RustExpand<cr>", "Expand" },
        e = { "<cmd>RustExpandMacro<cr>", "Expand Macro" },
        f = { "<cmd>RustFmt<cr>", "Format" },
        F = { "<cmd>RustFmtRange<cr>", "Format Range" },
        h = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
        u = { "<cmd>RustMoveItemUp<cr>", "Move Item Up" },
        d = { "<cmd>RustMoveItemDown<cr>", "Move Item Down" },
        D = { "<cmd>RustDebuggables<cr>", "Debuggables" },
        c = { "<cmd>RustOpenCargo<cr>", "Cargo.toml" },
        r = { "<cmd>RustRun<cr>", "Run" },
        R = { "<cmd>RustRunnables<cr>", "Runnables" },
        w = { "<cmd>RustReloadWorkspace<cr>", "Reload Workspace" },
        s = { "<cmd>RustSSR<cr>", "SSR" },
        g = { "<cmd>RustViewCrateGraph<cr>", "Crate Graph" },
        j = { "<cmd>RustJoinLines<cr>", "Join Lines" },
        p = { "<cmd>RustParentModule<cr>", "Parent Module" },
    },

    b = {
        name = "buffer",
        k = { "<cmd>Bdelete!<CR>", "Close buffer" },
        b = {
            "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy{previewer = false})<cr>",
            "Buffers",
        },
        p = {"<cmd>BufferLinePick<cr>", "Pick Buffer"},
        c = {"<cmd>BufferLinePickClose<cr>", "Pick Close Buffer"},
    },

    w = {
        name = "window",
        c = {"<cmd>q<cr>", "Close window"},
    },

    -- Debuggig keys
    d = {
        name = "debug",
        d = { "<cmd>w<cr><cmd>DapContinue<cr>", "Debug/Continue" },
        D = { "<cmd>lua require'dap'.clear_breakpoints();store_breakpoints(true)<cr>", "Delete breakpoints" },
        r = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to cursor" },
        R = { "<cmd>DapToggleRepl<cr>", "Repl" },
        c = { "<cmd>lua require('telescope').extensions.dap.commands(require('telescope.themes').get_ivy{previewer = false})<cr>", "Commands" },
        l = { "<cmd>lua require('telescope').extensions.dap.list_breakpoints(require('telescope.themes').get_ivy{previewer = false})<cr>", "List breakpoints" },
        f = { "<cmd>lua require('telescope').extensions.dap.frames(require('telescope.themes').get_ivy{previewer = false})<cr>", "Frames" },
        F = { "<cmd>lua require('telescope').extensions.dap.configurations(require('telescope.themes').get_ivy{previewer = false})<cr>", "Configurations" },
        t = { "<cmd>DapTerminate<cr>", "Terminate" },
        v = { "<cmd>lua require('telescope').extensions.dap.variables(require('telescope.themes').get_ivy{previewer = false})<cr>", "Variables" },
        h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover" },
        s = { "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<cr>", "Scopes" },
        e = { "<cmd>lua require('dapui').eval()<cr>", "Eval/Inspect" },
        C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Condition breakpoint" },
        L = { "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", "Log breakpoint" },
        b = { "<cmd>lua require'dap'.toggle_breakpoint();store_breakpoints(false)<cr>", "Breakpoint" },
        i = { "<cmd>DapStepInto<cr>", "Step into" },
        o = { "<cmd>DapStepOver<cr>", "Step over" },
        O = { "<cmd>DapStepOut<cr>", "Step out" },
    },

    m = {
        name = "markdown",
        p = { "<cmd>MarkdownPreview<cr>", "Preview" },
        t = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle" },
        s = { "<cmd>MarkdownPreviewStop<cr>", "Stop" },
    },

    -- DBUI keys
    x = {
        name = "databases",
        u = { "<cmd>DBUIToggle<CR>", "Toggle UI" },
        f = { "<cmd>DBUIFindBuffer<CR>", "Find buffer" },
        r = { "<cmd>DBUIRenameBuffer<CR>", "Rename buffer" },
        l = { "<cmd>DBUILastQueryInfo<CR>", "Last query" },
    },

    p = {
        name = "projectile",
        p = {"<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects"},
    },

    -- Packer
    ["P"] = {
        name = "packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    -- Git
    g = {
        name = "git",
        g = { "<cmd>Neogit<CR>", "Lazygit" },
        -- v = { "<cmd>lua require('telescope').extensions.lazygit.lazygit()<CR>", "View repos" },
        k = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        l = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        B = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk",
        },
        o = { "<cmd>lua require('telescope.builtin').git_status(require('telescope.themes').get_ivy{previewer = false})<cr>", "Open changed file" },
        b = { "<cmd>lua require('telescope.builtin').git_branches(require('telescope.themes').get_ivy{previewer = false})<cr>", "Checkout branch" },
        c = { "<cmd>lua require('telescope.builtin').git_commits(require('telescope.themes').get_ivy{previewer = false})<cr>", "Checkout commit" },
        S = { "<cmd>lua require('telescope.builtin').git_stash(require('telescope.themes').get_ivy{previewer = false})<cr>", "Checkout commit" },
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
        F = { "<cmd>Lspsaga lsp_finder<cr>", "Find definition" },
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
        s = { "<cmd>lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_ivy{previewer = false})<cr>", "Document Symbols" },
        S = {
            "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols(require('telescope.themes').get_ivy{previewer = false})<cr>",
            "Workspace Symbols",
        },
        n = { "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", "Doc scroll down" },
        p = { "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", "Doc scroll up" },
        D = { "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", "Preview definition" }
    },

    h = {
        name = "help",
        t = { "<cmd>lua require('telescope.builtin').colorscheme(require('telescope.themes').get_ivy{previewer = false})<cr>", "Colorscheme" },
        k = { "<cmd>lua require('telescope.builtin').keymaps(require('telescope.themes').get_ivy{previewer = false})<cr>", "Keymaps" },
        m = { "<cmd>lua require('telescope.builtin').man_pages(require('telescope.themes').get_ivy{previewer = false})<cr>", "Man pages" },
        h = { "<cmd>lua require('telescope.builtin').help_tags(require('telescope.themes').get_ivy{previewer = false})<cr>", "Find help" },
        r = {
            name = "reload",
            r = { "<cmd>w<cr><cmd>luafile ~/.config/nvim/init.lua<CR>", "Reload config" },
            f = { "<cmd>w<cr><cmd>luafile %<CR>", "Reload lua file" },
        },
        s = { "<cmd>lua require('telescope.builtin').search_history(require('telescope.themes').get_ivy{previewer = false})<cr>", "Search history" },
        c = { "<cmd>lua require('telescope.builtin').command_history(require('telescope.themes').get_ivy{previewer = false})<cr>", "Command history" },
        C = { "<cmd>lua require('telescope.builtin').commands(require('telescope.themes').get_ivy{previewer = false})<cr>", "Commands" },
    },

    o = {
        name = "open",
        t = { "<cmd>exec v:count1 . \"ToggleTerm size=15 direction=horizontal\"<cr>", "Horizontal" },
        p = { "<cmd>NvimTreeToggle<cr>", "Project sidebar" },
        s = { "<cmd>Alpha<cr>", "Start page" },
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)
