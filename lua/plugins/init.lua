return {
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end
    },

    "ThePrimeagen/vim-be-good",
    "levouh/tint.nvim",
    "elkowar/yuck.vim",
    'tikhomirov/vim-glsl',
    'reisub0/hot-reload.vim',
    "sindrets/diffview.nvim",

    {
        "rbong/vim-flog",
        lazy = true,
        cmd = { "Flog", "Flogsplit", "Floggit" },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },

    {
        "rachartier/tiny-devicons-auto-colors.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        event = "VeryLazy",
        config = function()
            local colors = require('catppuccin.palettes').get_palette(vim.g.catppuccin_flavour)
            require('tiny-devicons-auto-colors').setup({
                colors = colors,
            })
        end
    },

    'pest-parser/pest.vim',

    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = {
                enabled = true,
                show_start = false,
                injected_languages = false,
            },
            indent = {
                highlight = { "@comment" },
                char = '│'
            }
        }
    },

    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup()
        end
    },

}
