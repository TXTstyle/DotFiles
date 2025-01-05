return {
    "L3MON4D3/LuaSnip",
    version = 'v2.*',
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
        enable_autosnippets = true,
    },
    config = function ()
        require("luasnip.loaders.from_vscode").lazy_load()
        require'luasnip'.filetype_extend("vue", {"vue"})
    end
}
