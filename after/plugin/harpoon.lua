local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
local term = require('harpoon.term')

vim.keymap.set("n", "<Leader>a", mark.add_file)
vim.keymap.set("n", "<Leader>r", mark.rm_file)
vim.keymap.set("n", "<Leader>e", ui.toggle_quick_menu)


vim.keymap.set("n", "<Leader>n", function() ui.nav_prev() end)
vim.keymap.set("n", "<Leader>m", function() ui.nav_next() end)

vim.keymap.set("n", "<Leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<Leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<Leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<Leader>4", function() ui.nav_file(4) end)
