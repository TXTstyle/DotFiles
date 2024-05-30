return {
    'nvim-tree/nvim-tree.lua',
    cmd = "NvimTreeToggle",
    keys = {
        { "<leader>pv", vim.cmd.NvimTreeFindFile, desc = "tree open file" },
        {
            "<leader>b",
            function()
                local nvimTree = require("nvim-tree.api")
                local currentBuf = vim.api.nvim_get_current_buf()
                local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
                if currentBufFt == "NvimTree" then
                    nvimTree.tree.toggle()
                else
                    nvimTree.tree.focus()
                end
            end,
            desc = "tree open",
        },
    },
    lazy = true,
    init = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            view = {
                adaptive_size = true,
                side = "right",
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
        })
    end

}
