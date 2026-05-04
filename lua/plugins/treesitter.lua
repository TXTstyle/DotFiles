return {
    "reybits/ts-forge.nvim",
    opts = {
        ensure_installed = { "c", "rust", "javascript", "cpp", "vue", "lua", "vim", "vimdoc" },
        auto_install = true,

        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
            disable = { "dart" }
        },
    },
}
