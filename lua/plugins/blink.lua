return {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    dependencies = {
        { 'L3MON4D3/LuaSnip',            version = 'v2.*' },
        { 'rafamadriz/friendly-snippets' },
    },
    version = 'v0.*',
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        keymap = {
            preset = 'enter',
            ['<C-space>'] = {},
            ['<Tab>'] = {},
            ['<S-Tab>'] = {},

            ['<C-k>'] = { 'show', 'show_documentation', 'hide_documentation', 'hide' },
            ['<C-f>'] = { 'snippet_forward', 'fallback' },
            ['<C-b>'] = { 'snippet_backward', 'fallback' },
        },
        appearance = {
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
        },
        snippets = {
            expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
            active = function(filter)
                if filter and filter.direction then
                    return require('luasnip').jumpable(filter.direction)
                end
                return require('luasnip').in_snippet()
            end,
            jump = function(direction) require('luasnip').jump(direction) end,
        },
        completion = {
            list = {
                selection = "preselect",
            },
            menu = {
                scrollbar = false,
                draw = {
                    columns = { { 'kind_icon' }, { 'label', 'label_description', fill = true, gap = 1 } },
                    components = {
                        label = {
                            width = { fill = true, max = 50 },
                            text = function(ctx)
                                local highlights_info =
                                    require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
                                if highlights_info ~= nil then
                                    return highlights_info.text
                                else
                                    return ctx.label
                                end
                            end,
                            highlight = function(ctx)
                                local highlights_info =
                                    require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
                                local highlights = {}
                                if highlights_info ~= nil then
                                    for _, info in ipairs(highlights_info.highlights) do
                                        table.insert(highlights, {
                                            info.range[1],
                                            info.range[2],
                                            group = ctx.deprecated and "BlinkCmpLabelDeprecated" or info[1],
                                        })
                                    end
                                end
                                for _, idx in ipairs(ctx.label_matched_indices) do
                                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                                end
                                return highlights
                            end,
                        },
                    },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 250,
                window = {
                    scrollbar = false,
                },
            },
            -- Displays a preview of the selected item on the current line
            ghost_text = {
                enabled = true,
            },
        },
        sources = {
            default = { 'lsp', 'path', 'luasnip', 'buffer' },
            -- optionally disable cmdline completions
            cmdline = {},
        },

        -- experimental signature help support
        -- signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
}
