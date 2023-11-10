return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup {
            flavour = "frappe",
            term_colors = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = true,
                harpoon = true,
                barbecue = {
                    bold_basename = true,
                    dim_context = true,
                },
                fidget = true,
                indent_blankline = {
                    enabled = true,
                },
                mason = true,
                noice = true,
                rainbow_delimiters = true,
                lsp_trouble = true,
                illuminate = {
                    enabled = true,
                    lps = true,
                },
                telescope = {
                    enabled = true,
                },
                which_key = true,
                alpha = true,
            },
        }
        vim.cmd.colorscheme "catppuccin"
    end
}
