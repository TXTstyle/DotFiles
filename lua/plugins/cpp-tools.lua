return {
    "Badhi/nvim-treesitter-cpp-tools",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSCppDefineClassFunc", "TSCppMakeConcreteClass", "TSCppRuleOf3", "TSCppRuleOf5" },
    opts = {
        preview = {
            quit = 'q',      -- optional keymapping for quit preview
            accept = '<c-y>' -- optional keymapping for accept preview
        },
    },
    config = true,
}

-- TSCppDefineClassFunc
-- TSCppMakeConcreteClass
