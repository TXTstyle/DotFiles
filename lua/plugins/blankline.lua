return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        scope = {
            enabled = true,
            show_start = false,
            injected_languages = false,
        },
        indent = {
            highlight = { "@comment" },
            char = '│'
        }
    }
}
