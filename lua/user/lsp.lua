-- lsp stuff
local nvim_lsp = require "lspconfig"

nvim_lsp.tailwindcss.setup {
    filetypes = { "astro", "html", "css", "scss", "javascriptreact", "typescriptreact",
        "svelte", "vue", "tsx", "jsx", "rescript" }
}
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
