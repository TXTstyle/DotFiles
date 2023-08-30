return {
    "Badhi/nvim-treesitter-cpp-tools",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
        preview = {
            quit = 'q',  -- optional keymapping for quit preview
            accept = '<tab>' -- optional keymapping for accept preview
        },
    }
}

-- TSCppDefineClassFunc
-- TSCppMakeConcreteClass
