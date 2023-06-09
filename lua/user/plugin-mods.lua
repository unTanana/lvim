-- fix gisigns icons
lvim.builtin.gitsigns.opts.signs = {
    add = {
        hl = "GitSignsAdd",
        text = lvim.icons.ui.BoldLineLeft,
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn",
    },
    change = {
        hl = "GitSignsChange",
        text = lvim.icons.ui.BoldLineLeft,
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
    },
    delete = {
        hl = "GitSignsDelete",
        text = lvim.icons.ui.BoldLineLeft,
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
    },
    topdelete = {
        hl = "GitSignsDelete",
        text = lvim.icons.ui.BoldLineLeft,
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
    },
    changedelete = {
        hl = "GitSignsChange",
        text = lvim.icons.ui.BoldLineLeft,
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
    },
}


lvim.builtin.terminal.execs = {
    -- { nil, "<C-`>",   "Horizontal Terminal", "horizontal", 0.4 },
    -- { nil, "<C-`>",   "Vertical Terminal", "vertical", 0.4 },
    -- { nil, [[<c-\>]], "Float Terminal", "float", nil },
    { nil, [[<c-`>]], "Float Terminal", "float", nil },
}

-- make date format for blame relative
vim.g.gitblame_date_format = '%r'

-- copilot
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })


--redo nvimtree
lvim.builtin.nvimtree = {
    active = true,
    on_config_done = nil,
    setup = {
        auto_reload_on_write = false,
        hijack_directories = {
            enable = false,
        },
        update_cwd = true,
        diagnostics = {
            enable = lvim.use_icons,
            show_on_dirs = false,
            icons = {
                hint = lvim.icons.diagnostics.BoldHint,
                info = lvim.icons.diagnostics.BoldInformation,
                warning = lvim.icons.diagnostics.BoldWarning,
                error = lvim.icons.diagnostics.BoldError,
            },
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
        },
        system_open = {
            cmd = nil,
            args = {},
        },
        git = {
            enable = false,
            ignore = false,
            timeout = 200,
        },
        view = {
            width = 30,
            hide_root_folder = false,
            side = "left",
            mappings = {
                custom_only = false,
                list = {},
            },
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            float = {
                enable = true,
                quit_on_focus_loss = true,
                open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 120,
                    height = 120,
                    row = 10,
                    col = 56,
                },
            },
        },
        renderer = {
            indent_markers = {
                enable = false,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    none = " ",
                },
            },
            icons = {
                webdev_colors = lvim.use_icons,
                show = {
                    git = lvim.use_icons,
                    folder = lvim.use_icons,
                    file = lvim.use_icons,
                    folder_arrow = lvim.use_icons,
                },
                glyphs = {
                    default = lvim.icons.ui.Text,
                    symlink = lvim.icons.ui.FileSymlink,
                    git = {
                        deleted = lvim.icons.git.FileDeleted,
                        ignored = lvim.icons.git.FileIgnored,
                        renamed = lvim.icons.git.FileRenamed,
                        staged = lvim.icons.git.FileStaged,
                        unmerged = lvim.icons.git.FileUnmerged,
                        unstaged = lvim.icons.git.FileUnstaged,
                        untracked = lvim.icons.git.FileUntracked,
                    },
                    folder = {
                        default = lvim.icons.ui.Folder,
                        empty = lvim.icons.ui.EmptyFolder,
                        empty_open = lvim.icons.ui.EmptyFolderOpen,
                        open = lvim.icons.ui.FolderOpen,
                        symlink = lvim.icons.ui.FolderSymlink,
                    },
                },
            },
            highlight_git = true,
            group_empty = false,
            root_folder_modifier = ":t",
        },
        filters = {
            dotfiles = false,
            custom = { "node_modules", "\\.cache" },
            exclude = {},
        },
        trash = {
            cmd = "trash",
            require_confirm = true,
        },
        log = {
            enable = false,
            truncate = false,
            types = {
                all = false,
                config = false,
                copy_paste = false,
                diagnostics = false,
                git = false,
                profile = false,
            },
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false,
                restrict_above_cwd = false,
            },
            open_file = {
                quit_on_open = false,
                resize_window = false,
                window_picker = {
                    enable = false,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", "terminal", "help" },
                    },
                },
            },
        },
    },
}

-- harpoon and buffers
lvim.keys.normal_mode["<C-1>"] = function() require("harpoon.ui").nav_file(1) end
lvim.keys.normal_mode["<C-2>"] = function() require("harpoon.ui").nav_file(2) end
lvim.keys.normal_mode["<C-3>"] = function() require("harpoon.ui").nav_file(3) end
lvim.keys.normal_mode["<C-4>"] = function() require("harpoon.ui").nav_file(4) end
lvim.keys.normal_mode["<S-l>"] = function() require("harpoon.ui").nav_next() end
lvim.keys.normal_mode["<S-h>"] = function() require("harpoon.ui").nav_prev() end
lvim.keys.normal_mode["<C-w>"] = "<C-^>"
lvim.keys.normal_mode["<C-e>"] = require("harpoon.ui").toggle_quick_menu;
lvim.builtin.which_key.mappings["w"] = { require("harpoon.mark").add_file, "Add File" }
-- lvim.builtin.which_key.mappings["e"] = { require("harpoon.ui").toggle_quick_menu, "toggle harpoon" }
