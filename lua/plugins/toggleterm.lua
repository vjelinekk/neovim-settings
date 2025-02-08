return {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
        local Terminal  = require('toggleterm.terminal').Terminal

        local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            float_opts = {
                border = "double",
            },
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                vim.cmd("startinsert!")
            end,
        })

        function _lazygit_toggle()
            lazygit:toggle()
        end

        local normal_terminal = Terminal:new({
            cmd = "zsh",
            direction = "float",
            float_opts = {
                border = "double",
            },
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                vim.cmd("startinsert!")
            end,
        })

        function _normal_terminal_toggle()
            normal_terminal:toggle()
        end

        vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = false, silent = true})
        vim.api.nvim_set_keymap("n", "<C-\\>", "<cmd>lua _normal_terminal_toggle()<CR>", {noremap = false, silent = true})
    end
}

