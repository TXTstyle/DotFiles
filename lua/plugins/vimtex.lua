return {
    "lervag/vimtex",
    -- lazy = false,     -- we don't want to lazy load VimTeX
    init = function()
        -- VimTeX configuration goes here, e.g.
        local viewer = "zathura";
        if jit.os == "OSX" then
            viewer = "skim"
        end

        vim.g.vimtex_view_method = viewer
        vim.g.vimtex_compiler_method = 'tectonic'
    end
}
