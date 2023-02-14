return {
    "NvChad/nvim-colorizer.lua",
    opts = {
        filetypes = {
            "css",
            "html",
            "vue",
            "javascript",
        },
        user_default_options = {
            css = true,
            -- mode = "virtualtext",
            sass = { enable = true, parsers = { "css" }, },
        },
    }
}
