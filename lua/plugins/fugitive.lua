return {
    'tpope/vim-fugitive',
    cmd = {"G", "Git"},
    keys = {
        {"<leader>gs", vim.cmd.Git, desc = "Git"}
    }
}
