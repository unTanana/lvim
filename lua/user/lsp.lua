-- lsp stuff
local nvim_lsp = require "lspconfig"

nvim_lsp.tailwindcss.setup {
    filetypes = { "astro", "html", "css", "scss", "javascriptreact", "typescriptreact",
        "svelte", "vue", "tsx", "jsx", "rescript" }
}
nvim_lsp.clangd.setup {
    filetypes = { "c", "cpp", "objc", "objcpp", "mm" },
}

-- nvim_lsp.jedi_language_server.setup {
--     filetypes = { "python", "py" },
-- }
-- require("copilot").setup()

-- astro file detection
vim.filetype.add({
    extension = {
        astro = "astro",
    }
})

-- vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "DiagnosticSignHint" })
-- nvim_lsp.diagnostics.signs.values.hint = { text = "", name = "DiagnosticSignHint" }
-- nvim_lsp.setup()
