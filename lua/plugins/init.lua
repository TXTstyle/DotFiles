return {
    "folke/which-key.nvim",
    'ThePrimeagen/harpoon',
    "simrat39/rust-tools.nvim",
    'kevinhwang91/nvim-hlslens',
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            -- Snippet Collection (Optional)
            { 'rafamadriz/friendly-snippets' },
        }
    },

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
    { 'rmagatti/alternate-toggler',
        config = function()
            vim.keymap.set('n', '<space>ta', '<cmd>ToggleAlternate<cr>')
        end
    },
    'windwp/nvim-ts-autotag',
}
