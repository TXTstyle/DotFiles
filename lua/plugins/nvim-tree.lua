return {
    'nvim-tree/nvim-tree.lua',
    tag = 'nightly',
    cmd = "NvimTreeToggle",
    keys = {
        { "<leader>b",  vim.cmd.NvimTreeToggle,   desc = "tree toggle" },
        { "<leader>pv", vim.cmd.NvimTreeFindFile, desc = "tree open file" }
    },
    lazy = true,
    init = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
        local function change_root_to_global_cwd()
            local api = require("nvim-tree.api")
            local global_cwd = vim.fn.getcwd(-1, -1)
            api.tree.change_root(global_cwd)
        end

        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            view = {
                adaptive_size = true,
                mappings = {
                    list = {
                        { key = "u",          action = "dir_up" },
                        { key = "<Leader>cd", action = "cd" },
                        { key = "<C-C>",      action = "global_cwd", action_cb = change_root_to_global_cwd },
                    },
                },
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
