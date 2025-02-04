return {
    "ThePrimeagen/vim-be-good",
    "elkowar/yuck.vim",
    'tikhomirov/vim-glsl',
    "sindrets/diffview.nvim",
    'github/copilot.vim',

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
