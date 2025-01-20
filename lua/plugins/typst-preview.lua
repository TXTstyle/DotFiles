return {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    config = function()
        require("typst-preview").setup({
            dependencies_bin = { ['tinymist'] = 'tinymist' }
        })

        vim.opt.wrap = true
        vim.opt.spell = true
        vim.opt.spelllang = "sv,en"
        vim.keymap.set('n', 'j', 'gj', { silent = true })
        vim.keymap.set('n', 'k', 'gk', { silent = true })
        vim.keymap.set('n', '<leader>ll', "<cmd>TypstPreviewToggle<cr>", { silent = true })
    end
}
