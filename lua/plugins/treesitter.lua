return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    config = function()
        require("nvim-treesitter.configs").setup {
            -- A list of parser names, or "all" (the four listed parsers should always be installed)
            ensure_installed = { "rust", "javascript", "cpp", "c_sharp", "vue", "lua", "vim", "vimdoc" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            highlight = {
                enable = true,
            },
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil,
            },
            indent = {
                enable = true,
                disable = {}
            },
            autotag = {
                enable = true,
            }

        }
    end
}
