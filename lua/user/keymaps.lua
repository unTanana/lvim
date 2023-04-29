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


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-CR>"] = "o<ESC>"
lvim.keys.insert_mode["<S-CR>"] = "<ESC>o"
lvim.keys.visual_mode["y"] = "ygv<ESC>" -- visual_mode yank -> moves cursor to end of yanked text and into normal mode
lvim.keys.normal_mode["N"] = "Nzz"
lvim.keys.normal_mode["n"] = "nzz"
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
lvim.keys.normal_mode["n"] = "nzz"
lvim.keys.insert_mode["jk"] = "<ESC>"
-- delete before paste
lvim.keys.visual_mode["<leader>p"] = "\"_dP"
-- delete to _ registry
lvim.keys.visual_mode["<leader>d"] = "\"_d"
lvim.keys.normal_mode["<leader>d"] = "\"_d"
-- Lsp Saga
lvim.keys.normal_mode["K"] = ":Lspsaga hover_doc<CR>"
lvim.keys.normal_mode["gs"] = ":Lspsaga signature_help<CR>"
lvim.keys.normal_mode["[e"] = ":Lspsaga diagnostic_jump_prev<CR>"
lvim.keys.normal_mode["]e"] = ":Lspsaga diagnostic_jump_next<CR>"
lvim.keys.normal_mode["<leader>o"] = ":Lspsaga outline<CR>"
-- c* && c#
lvim.keys.normal_mode["c*"] = "*Ncgn"
lvim.keys.normal_mode["c#"] = "#NcgN"
lvim.keys.visual_mode["<leader>E"] = "<cmd>ChatGPTEditWithInstructions<cr>"

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
    b = { "<cmd>DapToggleBreakpoint<CR>", "Toggle Breakpoint" },
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
