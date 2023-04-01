return {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'hyper',
        }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
