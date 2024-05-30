return {
    "folke/trouble.nvim",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle focus=true<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>vrr",
            "<cmd>Trouble lsp_references toggle<cr>",
            desc = "References (Trouble)",
        },
    },
    opts = {
        auto_close = true,
        focus = true,
        keys = {
            ["<cr>"] = "jump_close",
        },
        icons = {
            error = "",
            warning = "",
            hint = "󰘥",
            information = "",
            other = "",
        },
    },
}
