lvim.builtin.bufferline.active = false
lvim.builtin.indentlines.active = false

local function get_current_git_directory()
    return vim.fn.system("git rev-parse --show-toplevel"):gsub("%s+", "")
end

local function grep_git_files()
    -- remove newlines
    local dir = get_current_git_directory()

    local opts =
    {
        sorting_strategy = "ascending",
        prompt_prefix = "  ",
        prompt_title = "Live Grep",
        cwd = dir,
        search_dirs = { get_current_git_directory() },
    }

    require("telescope.builtin").live_grep(opts)
end

local function organize_imports()
    -- get current file extension
    local ext = vim.fn.expand("%:e")

    -- if python
    if ext == "py" then
        -- run isort
        vim.cmd("silent Isort")
    end

    if ext == "js" or ext == "ts" or ext == "jsx" or ext == "tsx" then
        local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = ""
        }
        vim.lsp.buf.execute_command(params)
    end
end

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "catppuccin-mocha"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.relativenumber = true
vim.opt.spelloptions = "camel"
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.updatetime = 50
-- vim.opt.colorcolumn = "80" -- tell vim to highlight the 80th column

-- to disable icons and use a minimalist setup, uncomment the following
lvim.use_icons = true
lvim.lsp.installer.setup.automatic_installation = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-CR>"] = "o<ESC>"
lvim.keys.insert_mode["<S-CR>"] = "<ESC>o"
-- yank cursor reset
lvim.keys.visual_mode["y"] = "ygv<ESC>" -- visual_mode yank -> moves cursor to end of yanked text and into normal mode

-- delete before paste
lvim.keys.visual_mode["<leader>p"] = "\"_dP"
-- delete to _ registry
lvim.keys.visual_mode["<leader>d"] = "\"_d"
lvim.keys.normal_mode["<leader>d"] = "\"_d"

-- Lsp Saga
lvim.keys.normal_mode["K"] = ":Lspsaga hover_doc<CR>"
lvim.keys.normal_mode["gd"] = ":Lspsaga goto_definition<CR>"
lvim.keys.normal_mode["gs"] = ":Lspsaga signature_help<CR>"
lvim.keys.normal_mode["[e"] = ":Lspsaga diagnostic_jump_prev<CR>"
lvim.keys.normal_mode["]e"] = ":Lspsaga diagnostic_jump_next<CR>"
lvim.keys.normal_mode["<leader>o"] = ":Lspsaga outline<CR>"
-- lvim.keys.normal_mode["<leader>z"] = ":ZenMode<CR>"

-- harpoon and buffers
lvim.keys.normal_mode["<C-1>"] = function() require("harpoon.ui").nav_file(1) end
lvim.keys.normal_mode["<C-2>"] = function() require("harpoon.ui").nav_file(2) end
lvim.keys.normal_mode["<C-3>"] = function() require("harpoon.ui").nav_file(3) end
lvim.keys.normal_mode["<C-4>"] = function() require("harpoon.ui").nav_file(4) end
lvim.keys.normal_mode["<S-l>"] = function() require("harpoon.ui").nav_next() end
lvim.keys.normal_mode["<S-h>"] = function() require("harpoon.ui").nav_prev() end
lvim.keys.normal_mode["<C-w>"] = "<C-^>"

-- c* && c#
lvim.keys.normal_mode["c*"] = "*Ncgn"
lvim.keys.normal_mode["c#"] = "#NcgN"

lvim.keys.normal_mode["N"] = "Nzz"
lvim.keys.normal_mode["n"] = "nzz"
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
lvim.keys.normal_mode["n"] = "nzz"
lvim.keys.insert_mode["jk"] = "<ESC>"


lvim.keys.visual_mode["<leader>E"] = "<cmd>ChatGPTEditWithInstructions<cr>"

-- harpoon
lvim.keys.normal_mode["<C-e>"] = require("harpoon.ui").toggle_quick_menu;
lvim.builtin.which_key.mappings["w"] = { require("harpoon.mark").add_file, "Add File" }

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )


-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }


-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope find_files<CR>", "Find files" }
lvim.builtin.which_key.mappings["c"] = {
    name = "+Code",
    p = { "\"0p", "paste 0" },
    P = { "\"0P", "Paste 0" },
    l = { "@l", "console.log" },
    e = { "@k", "console.error" },
    g = { "<cmd>!gitk %<CR>", "git file history" },
    o =
    { organize_imports, "Organize Imports" },
    r = { "<cmd>Lspsaga rename<CR>", "Rename" },
    d = { "<cmd>Lspsaga peek_definition<CR>", "Peek Definition" },
    f = { "<cmd>Lspsaga lsp_finder<CR>", "LSP Finder" },
    a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
    t = { "<cmd>Lspsaga goto_type_definition<CR>", "Go To Type Definition" },
}

lvim.builtin.which_key.mappings["a"] = {
    name = "+yAnk Extensions",
    f = { "?public\\|protected\\|private\\|function\\|func\\|fn\\|=><CR>$V%ygv<ESC><cmd>nohlsearch<CR>", "function" },
}


lvim.builtin.which_key.mappings["C"] = {
    name = "+Chat GPT",
    e = { "<cmd>ChatGPTEditWithInstructions<cr>", "Generate" },
    a = { "<cmd>ChatGTP<cr>", "Ask Chat GPT" },
    s = { "<cmd>ChatGTPActAs<cr>", "Ask Chat GPT Acting As" },
}

lvim.builtin.which_key.mappings["x"] = { "<cmd>BufferKill<cr>", "Close Window" }
-- lvim.builtin.which_key.mappings["w"] = {
--     name = "+Window",
--     d = { "<cmd>BufferLineMoveNext<cr>", "Move Right" },
--     a = { "<cmd>BufferLineMovePrev<cr>", "Move Left" },
--     s = { "<cmd>BufferLineTogglePin<cr>", "Toggle Pin" },
--     w = { ":w<CR>", "Save" },
--     q = { "<cmd>BufferKill<CR>", "Close Window" },
-- }

lvim.builtin.which_key.mappings["s"]["f"] = {
    require("lvim.core.telescope.custom-finders").find_project_files, "Find File"
}

lvim.builtin.which_key.mappings["s"]["s"] = {
    "<cmd>GrepInDirectory<CR>", "Find File"
}

lvim.builtin.which_key.mappings["F"] = {
    "<cmd>Telescope live_grep<cr>", "Local Text"
}

lvim.builtin.which_key.mappings["f"] = {
    grep_git_files, "Search Text"
}

lvim.builtin.which_key.mappings["g"] = { "<cmd>LazyGit<cr>", "LazyGit" }

lvim.builtin.telescope.defaults.file_ignore_patterns = { "node_modules", ".git", ".DS_Store" }

-- lvim.builtin.which_key.mappings["S"] = {
--     name = "Session",
--     c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
--     l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
--     Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = "<C-t>"

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml",
    "go",
    "astro",
    "markdown",
    "markdown_inline",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true


-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    -- { command = "black", filetypes = { "python" } },
    -- { command = "isort", filetypes = { "python" } },
    {
        -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
        command = "prettier",
        ---@usage arguments to pass to the formatter
        -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
        extra_args = { "--print-with", "100" },
        ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
        filetypes = { "typescript", "typescriptreact", "javascript" },
    },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    -- { command = "flake8", filetypes = { "python" } },
    -- {
    --     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    --     command = "shellcheck",
    --     ---@usage arguments to pass to the formatter
    --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    --     extra_args = { "--severity", "warning" },
    -- },
    {
        command = "cspell",
        ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
        filetypes = { "javascript", "python", "typescript", "typescriptreact" },
        diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
        end,
    },
}


-- Additional Plugins
lvim.plugins = {
    { "catppuccin/nvim",        name = "catppuccin" },
    { 'stsewd/isort.nvim' },
    { 'f-person/git-blame.nvim' },
    {
        "justinmk/vim-sneak"
    },
    {
        "nvim-treesitter/nvim-treesitter-context"
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                enable = true,
                filetypes = {
                    'html', 'javascript', 'typescript', 'javascriptreact',
                    'typescriptreact', 'svelte', 'vue', 'tsx',
                    'jsx', 'rescript',
                    'xml',
                    'php',
                    'markdown',
                    'glimmer', 'handlebars', 'hbs', 'astro',
                },
                skip_tags = { 'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot',
                    'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr', 'menuitem' }
            })
        end,
    },
    -- {
    --     "williamboman/mason.nvim",
    --     config = function()
    --         require("mason").setup()
    --     end,
    -- },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "tailwindcss" },
            })
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require('lspsaga').setup({
                rename = {
                    whole_project = false
                }
            })
        end,
    },
    {
        "kdheepak/lazygit.nvim"
    },
    {
        "zbirenbaum/copilot.lua",
        event = { "VimEnter" },
        config = function()
            vim.defer_fn(function()
                require("copilot").setup({
                    panel = {
                        enabled = false,
                        auto_refresh = true,
                        keymap = {
                            jump_prev = "[[",
                            jump_next = "]]",
                            accept = "<CR>",
                            refresh = "gr",
                            open = "<M-l>"
                        },
                    },
                    suggestion = {
                        enabled = true,
                        auto_trigger = false,
                        debounce = 75,
                        keymap = {
                            accept = "<M-CR>",
                            accept_word = false,
                            accept_line = false,
                            next = "<M-]>",
                            prev = "<M-[>",
                            dismiss = "<C-]>",
                        },
                    },
                    copilot_node_command = 'node', -- Node.js version must be > 16.x
                    server_opts_overrides = {
                        inlineSuggestCount = 4
                    },
                })
            end, 100)
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua", "nvim-cmp" },
        config = function()
            require("copilot_cmp").setup()
        end
    },
    {
        "jackMort/ChatGPT.nvim",
        config = function()
            require("chatgpt").setup({})
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },
    {
        "nvim-treesitter/nvim-treesitter-refactor",
        config = function()
            require("nvim-treesitter.configs").setup({
                refactor = {
                    navigation = {
                        enable = true,
                        keymaps = {
                            goto_next_usage = "<C-]>",
                            goto_previous_usage = "<C-[>",
                        },
                    },
                },
            })
        end,
    },
    -- {
    --     "folke/zen-mode.nvim",
    --     config = function()
    --         require("zen-mode").setup {
    --             window = {
    --                 width = 0.59,
    --             },
    --             plugin = {
    --                 gitsigns = true,
    --                 kitty = {
    --                     enabled = true
    --                 }
    --             }
    --         }
    --     end
    -- },
    {
        "ThePrimeagen/harpoon"
    },
    {
        "princejoogie/dir-telescope.nvim",
        -- telescope.nvim is a required dependency
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("dir-telescope").setup({
                -- these are the default options set
                hidden = true,
                no_ignore = false,
                show_preview = true,
            })
        end,
    }

}

-- make date format for blame relative
vim.g.gitblame_date_format = '%r'

-- lsp stuff
local nvim_lsp = require "lspconfig"

nvim_lsp.tailwindcss.setup {}
nvim_lsp.clangd.setup {
    filetypes = { "c", "cpp", "objc", "objcpp", "mm" },
}
-- require("copilot").setup()

-- astro file detection
vim.filetype.add({
    extension = {
        astro = "astro",
    }
})


-- copilot
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "zsh",
--     callback = function()
--         -- let treesitter use bash highlight for zsh files as well
--         require("nvim-treesitter.highlight").attach(0, "bash")
--     end,
-- })

local function set_cursor_colors()
    vim.cmd('highlight CursorNormal guibg=#a9ff9f guifg=NONE')
    vim.cmd('highlight CursorInsert guibg=#ff5f5f guifg=NONE')
    vim.cmd('highlight CursorVisual guibg=#ffffff guifg=NONE')
    vim.opt.guicursor = "n-v-c:CursorNormal,i:CursorInsert,v:CursorVisual"
    -- vim.opt.guicursor = "n-v-c:block-CursorNormal,i-ci-ve:ver100-CursorInsert,v:CursorVisual"
end

--  disable auto comment && colors
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }

        set_cursor_colors()
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.js", "*.ts", "*.tsx", "*.jsx", "*.astro" },
    callback = function()
        -- console log and error
        vim.fn.setreg('l', 'yiwoconsole.log("jkpei, jkpea;jk')
        vim.fn.setreg('k', 'yiwoconsole.error("jkpei, jkpea;jk')
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.go",
    callback = function()
        -- console log and error
        vim.fn.setreg('l', 'yiwofmt.Printf("jkpa %+vjkla, jkp')
        vim.fn.setreg('k', "ojkccif err != nil {\njkccreturn nil, err\n}jk")
    end,
})


vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.py",
    callback = function()
        -- console log and error
        vim.fn.setreg('l', 'yiwoprint("jkpei, jkpea;jk')
        vim.fn.setreg('k', 'yiwoprint("error -> jkpei, jkpea;jk')
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.rs",
    callback = function()
        -- console log and error
        vim.fn.setreg('l', 'yiwoprintln!("{:?jkei, jkpA;jk')
        -- vim.fn.setreg('k', "") -- not used
    end,
})


-- lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
-- lvim.builtin.nvimtree.setup.view.width = 45

lvim.builtin.nvimtree = {
    active = true,
    on_config_done = nil,
    setup = {
        -- ignore_ft_on_setup = {
        --     "startify",
        --     "dashboard",
        --     "alpha",
        -- },
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
