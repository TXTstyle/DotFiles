return {
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
}
