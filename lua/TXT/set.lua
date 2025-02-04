vim.opt.nu = true
vim.opt.relativenumber = true

vim.o.timeout = true
vim.o.timeoutlen = 500
vim.o.timeout = true

vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.guifont = "JetBrainsMono Nerd Font"
vim.g.neovide_refresh_rate = 144
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_trail_size = 0.7
vim.g.neovide_scroll_animation_length = 0.07

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "85"

vim.cmd.colorscheme "catppuccin"

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = true,
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    float = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "󰍉",
            [vim.diagnostic.severity.INFO] = "",
        },

    },
})
