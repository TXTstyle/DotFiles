return {
     "catgoose/nvim-colorizer.lua",
    opts = {
        filetypes = {
            "css",
            "scss",
            "html",
            "vue",
            "javascript",
            "hex",
        },
        user_default_options = {
            css = true,
            -- mode = "virtualtext",
            sass = { enable = true, parsers = { "css" }, },
        },
    }
}
