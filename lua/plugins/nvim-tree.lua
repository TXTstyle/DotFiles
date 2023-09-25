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
        local api = require("nvim-tree.api")

        local function change_root_to_global_cwd()
            local global_cwd = vim.fn.getcwd(-1, -1)
            api.tree.change_root(global_cwd)
        end


        local function edit_or_open()
            local node = api.tree.get_node_under_cursor()

            if node.nodes ~= nil then
                api.node.open.edit()
            else
                api.node.open.edit()
                api.tree.close()
            end
        end

        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            view = {
                adaptive_size = true,
                mappings = {
                    list = {
                        { key = "l",          action = "open", action_cb = edit_or_open },
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
