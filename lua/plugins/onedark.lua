return {
    'navarasu/onedark.nvim',
    priority = 98,
    config = function()
        require('onedark').setup {
            style = 'cool',
            diagnostics = {
                background = false,
            },
            lualine = {
                transparent = true
            }
        }
        -- require('onedark').load()
    end
}
