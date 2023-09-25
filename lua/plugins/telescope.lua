return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim',
        "jvgrootveld/telescope-zoxide",
    },
    config = function()
        local t = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require('telescope.builtin')

        t.setup {
            defaults = {
                file_ignore_patterns = { "node_modules", "target" },
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
            },
            extensions = {
                zoxide = {
                    prompt_title = "",
                    mappings = {
                        default = {
                            action = function(selection)
                                vim.cmd("Lazy load nvim-tree.lua")
                                vim.cmd.cd(selection.path)
                            end,
                            after_action = function(selection)
                                print("Changed root to " .. selection.path)
                                require("nvim-tree.api").tree.change_root(selection.path)
                                builtin.find_files({ cwd = selection.path })
                            end
                        },
                    },
                }
            }
        }

        t.load_extension('zoxide')

        require('telescope.pickers.layout_strategies').horizontal_merged = function(picker, max_columns, max_lines,
                                                                                    layout_config)
            local layout = require('telescope.pickers.layout_strategies').horizontal(picker, max_columns, max_lines,
                layout_config)

            layout.prompt.title = ''
            layout.results.title = ''
            if not (layout.preview ~= nil) then
                layout.preview.title = ''
            end

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


        vim.keymap.set('n', '<Leader>ff', function()
            builtin.find_files()
        end)
        vim.keymap.set('n', '<C-p>', function()
            builtin.git_files()
        end, {})
        vim.keymap.set('n', '<Leader>gp', builtin.live_grep)

        vim.keymap.set("n", "<leader>cd", t.extensions.zoxide.list)
    end
}
