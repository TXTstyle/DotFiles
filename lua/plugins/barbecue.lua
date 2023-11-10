return {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        theme = "catppuccin",
        exclude_filetypes = { "toggleterm", "Trouble" },
    },
}
