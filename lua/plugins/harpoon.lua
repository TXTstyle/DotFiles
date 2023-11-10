return {
    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    lazy = false,
    config = function()
        require("harpoon").setup({
            tabline = true,
            tabline_suffix = '',
            tabline_prefix = '',
        })

        local mark = require('harpoon.mark')
        local ui = require('harpoon.ui')

        vim.keymap.set("n", "<Leader>a", mark.add_file)
        vim.keymap.set("n", "<Leader>e", ui.toggle_quick_menu)

        vim.keymap.set("n", "<Leader>1", function() ui.nav_file(1) end)
        vim.keymap.set("n", "<Leader>2", function() ui.nav_file(2) end)
        vim.keymap.set("n", "<Leader>3", function() ui.nav_file(3) end)
        vim.keymap.set("n", "<Leader>4", function() ui.nav_file(4) end)
        vim.keymap.set("n", "<Leader>5", function() ui.nav_file(5) end)
        vim.keymap.set("n", "<Leader>6", function() ui.nav_file(6) end)
        vim.keymap.set("n", "<Leader>7", function() ui.nav_file(7) end)
        vim.keymap.set("n", "<Leader>8", function() ui.nav_file(8) end)
        vim.keymap.set("n", "<Leader>9", function() ui.nav_file(9) end)
        vim.keymap.set("n", "<Leader>0", function() ui.nav_file(10) end)

        local colors = require('catppuccin.palettes').get_palette('frappe')
        vim.api.nvim_set_hl(0, 'HarpoonActive',         { fg = colors.base, bg = colors.overlay1, bold = true })
        vim.api.nvim_set_hl(0, 'HarpoonNumberActive',   { fg = colors.base, bg = colors.overlay1, bold = true })
        vim.api.nvim_set_hl(0, 'HarpoonInactive',       { fg = colors.base, bg = colors.surface0 })
        vim.api.nvim_set_hl(0, 'HarpoonNumberInactive', { fg = colors.base, bg = colors.surface0 })
        vim.api.nvim_set_hl(0, 'TabLineFill',           { fg = colors.base, bg = colors.base })
    end
}
