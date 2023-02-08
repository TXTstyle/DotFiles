-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup({ function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use 'navarasu/onedark.nvim'

    use { "folke/which-key.nvim", }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('ThePrimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use("simrat39/rust-tools.nvim")
    use { 'kevinhwang91/nvim-hlslens' }


    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
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
    }


    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use("ThePrimeagen/vim-be-good")
    use("levouh/tint.nvim")

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
        "SmiteshP/nvim-gps",
        requires = "nvim-treesitter/nvim-treesitter"
    }

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup { disable_filetype = { 'Telescope', 'vim' } } end
    }
    use("j-hui/fidget.nvim")
    use("simrat39/inlay-hints.nvim")

    use("numToStr/Comment.nvim")

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    use({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim", })
    use("lukas-reineke/indent-blankline.nvim")

    use("lewis6991/gitsigns.nvim")

    use { "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup()
        end }

    use { 'mrjones2014/nvim-ts-rainbow' }
    use('RRethy/vim-illuminate')
    use {
        "Badhi/nvim-treesitter-cpp-tools",
        requires = { "nvim-treesitter/nvim-treesitter" },
    }
    use({ 'rmagatti/alternate-toggler',
        config = function()
            vim.keymap.set('n', '<space>ta', '<cmd>ToggleAlternate<cr>')
        end
    })
    use 'windwp/nvim-ts-autotag'
    use { 'folke/noice.nvim',
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    }
    use {'akinsho/toggleterm.nvim', tag = '*'}
end,
    config = {
        display = {
            open_fn = require("packer.util").float,
        }
    }

})
