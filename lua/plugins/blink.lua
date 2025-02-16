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
        snippets = { preset = 'luasnip' },
        completion = {
            list = { selection = { preselect = true, auto_insert = true } },
            menu = {
                scrollbar = false,
                draw = {
                    columns = { { "kind_icon" }, { "label", gap = 1 } },
                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
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
            -- ghost_text = {
            --     enabled = true,
            -- },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        cmdline = {
            sources = {},
        },

        -- experimental signature help support
        -- signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
}
