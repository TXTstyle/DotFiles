return {
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require("which-key").setup()
        end
    },
    "simrat39/rust-tools.nvim",

    "ThePrimeagen/vim-be-good",
    "levouh/tint.nvim",
    "elkowar/yuck.vim",
    'tikhomirov/vim-glsl',
    "luckasRanarison/tree-sitter-hypr",

    "simrat39/inlay-hints.nvim",


    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to  defaults
            })
        end
    },

    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    "lukas-reineke/indent-blankline.nvim",


    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup()
        end
    },

}
