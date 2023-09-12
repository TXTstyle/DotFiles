return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup {
            defaults = {
                file_ignore_patterns = { "node_modules" },
                path_display = { 'smart' },
                -- border = false,
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
                        preview_width = 0.55,
                    }
                },
                borderchars = {
                    prompt = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
                    results = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
                    preview = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
                },
                prompt_prefix = '󰞷 ',
                layout_strategy = 'horizontal_merged'
            }
        }

        require('telescope.pickers.layout_strategies').horizontal_merged = function(picker, max_columns, max_lines,
                                                                                    layout_config)
            local layout = require('telescope.pickers.layout_strategies').horizontal(picker, max_columns, max_lines,
                layout_config)

            layout.prompt.title = ''
            layout.results.title = ''
            layout.preview.title = ''

            local colors = require('onedark.colors')
            local TelescopePrompt = {
                TelescopePromptNormal = {
                    fg = colors.white,
                    bg = colors.bg3
                },
                TelescopePromptBorder = {
                    fg = colors.bg3,
                    bg = colors.bg3
                },
                TelescopeBorder = {
                    fg = colors.bg0,
                    bg = colors.bg0
                },
                TelescopeResultsNormal = {
                    fg = colors.white,
                    bg = colors.bg1
                },
                TelescopeResultsBorder = {
                    fg = colors.bg1,
                    bg = colors.bg1
                },
                TelescopePreviewBorder = {
                    bg = colors.bg0,
                    fg = colors.bg0
                }
            }
            for hl, col in pairs(TelescopePrompt) do
                vim.api.nvim_set_hl(0, hl, col)
            end

            return layout
        end


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
