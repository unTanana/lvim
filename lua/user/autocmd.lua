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
    pattern = { "*.cpp", "*.c", "*.mm" },
    callback = function()
        -- console log and error
        vim.fn.setreg('l', 'yiwoprintf("jkpa %djkla, jkpA;jk')
        vim.fn.setreg('k', 'yiwoprintf("error - jkpa %djkla, jkpA;jk')
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


-- function to find and execute build.sh in current project directory
local function build_project_sh()
    local build_script = vim.fn.findfile("build.sh", ".;")
    if build_script ~= "" then
        -- sh build.sh
        vim.fn.system("sh " .. build_script)
    else
        print("build.sh not found")
    end
end


vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.cpp", "*.c", "*.mm" },
    callback = function()
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<leader>lb", build_project_sh, opts)
    end,
})

local function cargo_build()
    vim.fn.system("cargo build")
end

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.rs",
    callback = function()
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<leader>lb", cargo_build, opts)
    end,
})


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
