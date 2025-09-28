return {
    'tikhomirov/vim-glsl',
    "sindrets/diffview.nvim",
    'github/copilot.vim',
    {
        "jasonpanosso/harpoon-tabline.nvim",
        dependencies = { "ThePrimeagen/harpoon" }
    },
    {
        "rbong/vim-flog",
        lazy = true,
        cmd = { "Flog", "Flogsplit", "Floggit" },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },
    {
        "petertriho/nvim-scrollbar",
        opts = true,
    },
}
