return {
    "folke/which-key.nvim",
    'ThePrimeagen/harpoon',
    "simrat39/rust-tools.nvim",
    'kevinhwang91/nvim-hlslens',

    "ThePrimeagen/vim-be-good",
    "levouh/tint.nvim",

    {
        "SmiteshP/nvim-gps",
        dependencies = "nvim-treesitter/nvim-treesitter"
    },

    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup { disable_filetype = { 'Telescope', 'vim' } } end
    },
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


    { "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup()
        end },

    'mrjones2014/nvim-ts-rainbow',
    {
        "Badhi/nvim-treesitter-cpp-tools",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    'windwp/nvim-ts-autotag',
}
