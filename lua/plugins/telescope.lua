return {
    'nvim-telescope/telescope.nvim',
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
                file_ignore_patterns = { "node_modules", "target", "vendor" },
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
        t.load_extension("flutter")

        require('telescope.pickers.layout_strategies').horizontal_merged = function(picker, max_columns, max_lines,
                                                                                    layout_config)
            local layout = require('telescope.pickers.layout_strategies').horizontal(picker, max_columns, max_lines,
                layout_config)

            layout.prompt.title = ''
            layout.results.title = ''
            if not (layout.preview ~= nil) then
                layout.preview.title = ''
            end

            local colors = require('catppuccin.palettes').get_palette(vim.g.catppuccin_flavour)
            local TelescopePrompt = {
                TelescopePromptNormal = {
                    fg = colors.text,
                    bg = colors.crust
                },
                TelescopePromptBorder = {
                    fg = colors.crust,
                    bg = colors.crust
                },
                TelescopeBorder = {
                    fg = colors.base,
                    bg = colors.base
                },
                TelescopeResultsNormal = {
                    fg = colors.text,
                    bg = colors.mantle
                },
                TelescopeResultsBorder = {
                    fg = colors.mantle,
                    bg = colors.mantle
                },
                TelescopePreviewBorder = {
                    bg = colors.base,
                    fg = colors.base
                }
            }
            for hl, col in pairs(TelescopePrompt) do
                vim.api.nvim_set_hl(0, hl, col)
            end

            return layout
        end
    end,
    cmd = "Telescope",
    keys = {
        { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Git files" },
        { "<leader>gp", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
        { "<leader>cd", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide list" },
    },
    lazy = true,
    event = "VeryLazy",
}
