return {
    {
        "CopilotC-Nvim/CopilotChat.nvim", -- Plugin for integrating Copilot Chat into Neovim
        dependencies = {
            { "github/copilot.vim" }, -- Dependency for Copilot integration
            { "nvim-lua/plenary.nvim", branch = "master" }, -- Provides utility functions like curl, logging, and async
        },
        build = "make tiktoken", -- Build command for MacOS/Linux systems
        opts = {
            mappings = {
                reset = {
                    normal = "<C-x>", -- Keybinding to reset chat in normal mode
                },
                close = {
                    normal = "<C-c>", -- Keybinding to close chat in normal mode
                    insert = "<C-x>", -- Keybinding to reset chat in insert mode
                },
            },
            prompts = {
                Explain = "Please explain the selected code.", -- Prompt for code explanation
                Review = "Can you review the selected code for bugs or improvements?", -- Prompt for code review
                Fix = "Please fix any bugs in the selected code.", -- Prompt for bug fixing
                Optimize = "Please optimize the selected code for performance.", -- Prompt for performance optimization
                Docs = "Generate usefull code documentation for the selected code that does not provide redundant information and match the language used in other comments.", -- Prompt for generating documentation
                Tests = "Write unit tests for the selected function according to the project testing approaches.", -- Prompt for generating unit tests
                Commit = "Generate a concise git commit message describing all the changes in project. #git:staged", -- Prompt for generating commit messages
            },
        },

        config = function(_, opts)
            require("CopilotChat").setup(opts) -- Initialize CopilotChat with the provided options

            local prompts = opts.prompts
            local function ask_prompt(prompt_name, ignore_mode)
                return function()
                    if ignore_mode ~= nil and ignore_mode == true then
                        local prompt = prompts[prompt_name] -- Retrieve the corresponding prompt
                        require("CopilotChat").ask(prompt) -- Trigger the prompt in CopilotChat
                        return
                    end

                    local mode = vim.fn.mode()
                    if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
                        vim.notify("Please select some code in visual mode first!", vim.log.levels.WARN) -- Notify user if not in visual mode
                        return
                    end
                    local prompt = prompts[prompt_name] -- Retrieve the corresponding prompt
                    require("CopilotChat").ask(prompt) -- Trigger the prompt in CopilotChat
                end
            end

            local keymap_opts = { noremap = true, silent = true }
            local map = vim.keymap.set

            -- Keybindings for visual mode prompts
            map("v", "<leader>ce", ask_prompt("Explain"), vim.tbl_extend("force", keymap_opts, { desc = "CopilotChat: Explain" }))
            map("v", "<leader>cr", ask_prompt("Review"), vim.tbl_extend("force", keymap_opts, { desc = "CopilotChat: Review" }))
            map("v", "<leader>cf", ask_prompt("Fix"), vim.tbl_extend("force", keymap_opts, { desc = "CopilotChat: Fix" }))
            map("v", "<leader>co", ask_prompt("Optimize"), vim.tbl_extend("force", keymap_opts, { desc = "CopilotChat: Optimize" }))
            map("v", "<leader>cd", ask_prompt("Docs"), vim.tbl_extend("force", keymap_opts, { desc = "CopilotChat: Generate docs" }))
            map("v", "<leader>ct", ask_prompt("Tests"), vim.tbl_extend("force", keymap_opts, { desc = "CopilotChat: Generate tests" }))

            -- Keybindings for normal mode
            map("n", "<leader>cm", ask_prompt("Commit", true), vim.tbl_extend("force", keymap_opts, { desc = "CopilotChat: Generate commit message" }))
            map("n", "<leader>cc", "<cmd>CopilotChat<CR>", vim.tbl_extend("force", keymap_opts, { desc = "CopilotChat: Open chat" }))

            -- Buffer-local mappings for CopilotChat buffers
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "copilot-chat",
                callback = function(args)
                    local buf = args.buf
                    vim.keymap.set("n", "<C-x>", "<cmd>CopilotChatReset<CR>", { buffer = buf, desc = "CopilotChat Reset" }) -- Reset chat in normal mode
                    vim.keymap.set("n", "<C-c>", "<cmd>CopilotChatClose<CR>", { buffer = buf, desc = "CopilotChat Close" }) -- Close chat in normal mode
                    vim.keymap.set("i", "<C-x>", "<cmd>CopilotChatReset<CR>", { buffer = buf, desc = "CopilotChat Reset" }) -- Reset chat in insert mode
                end,
            })
        end,
    },
}
