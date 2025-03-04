return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
            mappings = {
                reset = {
                    normal = "<C-x>",
                },
                close = {
                    normal = "<C-c>",
                    insert = "<C-x>",
                },
            }
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}
