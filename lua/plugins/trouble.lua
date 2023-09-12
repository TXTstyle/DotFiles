return {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
        { "<leader>xx", "<cmd>TroubleToggle<cr>",                       { silent = true, noremap = true } },
        { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true } },
        { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  { silent = true, noremap = true } },
        { "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               { silent = true, noremap = true } },
        { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              { silent = true, noremap = true } },
        { "gR",         "<cmd>TroubleToggle lsp_references<cr>",        { silent = true, noremap = true } },
    },
    config = function()
        require('trouble').setup({
            signs = {
                -- icons / text used for a diagnostic
                error = "",
                warning = "",
                hint = "󰘥",
                information = "",
                other = "",
            },
        })
        -- vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
        -- vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
        -- vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
        -- vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
        -- vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
        -- vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
    end
}
