return {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
        text = {
            spinner = "dots", -- animation shown when tasks are ongoing
            done = "✔", -- character shown when all tasks are complete
            commenced = "Started", -- message shown when task starts
            completed = "Completed", -- message shown when task completes
        },
        align = {
            bottom = true, -- align fidgets along bottom edge of buffer
            right = true,  -- align fidgets along right edge of buffer
        },
        timer = {
            spinner_rate = 125,  -- frame rate of spinner animation, in ms
            fidget_decay = 1000, -- how long to keep around empty fidget, in ms
            task_decay = 400,    -- how long to keep around completed task, in ms
        },
        window = {
            relative = "win", -- where to anchor, either "win" or "editor"
            blend = 100,      -- &winblend for the window
            zindex = nil,     -- the zindex value for the window
            border = "none",  -- style of border for the fidget window
        },
    }
}
