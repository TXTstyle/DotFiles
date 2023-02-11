return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup {
            defaults = {
                path_display = { 'smart' },
                border = false,
                mappings = {
                    i = {
                        ["<C-j>"] = actions.preview_scrolling_down,
                        ["<C-k>"] = actions.preview_scrolling_up,
                        ["<esc>"] = actions.close
                    }
                },
                layout_config = {
                    horizontal = {
                        preview_cutoff = 100,
                        preview_width = 0.4,
                    }
                }
            }
        }

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<Leader>ff', function()
            builtin.find_files()
        end)
        vim.keymap.set('n', '<C-p>', function()
            builtin.git_files()
        end, {})
        vim.keymap.set('n', '<Leader>gp', builtin.live_grep)
    end
}
