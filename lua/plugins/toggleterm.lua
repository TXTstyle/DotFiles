return {
    'akinsho/toggleterm.nvim',
    cmd = "ToggleTerm",
    keys = {
        { "<c-T>", vim.cmd.ToggleTerm, desc = "ToggleTerm" }
    },
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
            end
        end,
        direction = 'float',
        open_mapping = [[<c-T>]],
        float_opts = {
            border = 'single',
            width = function ()
                return math.floor(vim.o.columns * 0.95)
            end,
            height = function ()
            end,
        },

    }
}
