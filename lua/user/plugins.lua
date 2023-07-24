lvim.plugins = {
    -- dap
    { "mfussenegger/nvim-dap" },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup()
        end
    },
    --
    { "catppuccin/nvim",        name = "catppuccin" },
    { 'stsewd/isort.nvim' },
    { 'f-person/git-blame.nvim' },
    {
        "justinmk/vim-sneak"
    },
    -- {
    --     "nvim-treesitter/nvim-treesitter-context"
    -- },
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
                    in_select = false,
                    auto_save = false,
                    project_max_width = 0.5,
                    project_max_height = 0.5,
                    keys = {
                        quit = '<C-c>',
                        exec = '<CR>',
                        select = 'x',
                    },
                },
                symbol_in_winbar = {
                    enable = false,
                },
                scroll_preview = {
                    scroll_down = '<C-d>',
                    scroll_up = '<C-u>',
                },
                finder = {
                    keys = {
                        shuttle = '[w',
                        toggle_or_open = { '<CR>', 'o', 'l' },
                        vsplit = 'v',
                        split = 's',
                        tabe = 't',
                        tabnew = 'r',
                        quit = 'q',
                        close = '<C-c>k',
                    },
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
                    suggestion = { enabled = false },
                    panel = { enabled = false },
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
    },
    {
        "knubie/vim-kitty-navigator"
    }
}
