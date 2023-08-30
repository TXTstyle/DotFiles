return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
        enable_check_bracket_line = true,
        ignore_next_char = "[%w%.]",
        disable_filetypes = { "TelescopePrompt", "vim" }
    }
}
