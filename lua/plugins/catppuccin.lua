return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        flavour = "macchiato",
        term_colors = true,
        custom_highlights = function(colors)
            return {
                LspInlayHint = { fg = colors.overlay1, bg = colors.base },
                HarpoonActive = { fg = colors.base, bg = colors.overlay1, bold = true },
                HarpoonNumberActive = { fg = colors.base, bg = colors.overlay1, bold = true },
                HarpoonInactive = { fg = colors.base, bg = colors.surface0 },
                HarpoonNumberInactive = { fg = colors.base, bg = colors.surface0 },
                TabLineFill = { fg = colors.base, bg = colors.base },
                BlinkCmpLabelMatch = { fg = colors.none, bg = colors.none, bold = true },
            }
        end,
        dim_inactive = {
            enabled = true,
            shade = "dark",
            percentage = 0.85,
        },
        integrations = {
            blink_cmp = true,
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
