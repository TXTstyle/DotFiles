return {
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require("which-key").setup()
        end
    },

    "ThePrimeagen/vim-be-good",
    "levouh/tint.nvim",
    "elkowar/yuck.vim",
    'tikhomirov/vim-glsl',
    "luckasRanarison/tree-sitter-hypr",

    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to  defaults
            })
        end
    },

    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    {
        "lukas-reineke/indent-blankline.nvim",
        branch = "v3",
        config = function()
            require('ibl').setup({
                scope = {
                    enabled = true,
                    show_start = false,
                    injected_languages = false,
                    highlight = { "@text" }
                },
                indent = {
                    highlight = { "@comment" },
                    char = '│'
                }
            })
        end
    },


    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup()
        end
    },

}
