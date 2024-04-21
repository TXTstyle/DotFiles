return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        flavour = "frappe",
        term_colors = true,
        custom_highlights = function(colors)
            return {
                LspInlayHint = { fg = colors.overlay1, bg = colors.base },
            }
        end,
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
    },
}
