vim.g.mapleader = ' '
vim.api.nvim_exec(
    "au VimEnter * silent! !setxkbmap -option caps:escape"
    , false)
vim.api.nvim_exec(
    "au VimLeave * silent! !setxkbmap -option "
    , false)

vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeFindFile)
vim.keymap.set('t', '<Esc>', "<C-\\><C-n>")

vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
vim.keymap.set('n', 'f', '<C-w>w', { silent = true })

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '>-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
