return {
    {
        'tpope/vim-fugitive',
        config = function ()
            vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>Gvdiffsplit!<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>Git blame<CR>", {noremap = true, silent = true})

            -- Helper function to get buffer number matching fugitive path
            local function get_fugitive_bufnum(side)
                for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                    local name = vim.api.nvim_buf_get_name(bufnr)
                    if name:match("//" .. side .. "/") then
                        return bufnr
                    end
                end
                vim.notify("No fugitive buffer found for //" .. side, vim.log.levels.WARN)
                return nil
            end

            -- Diffget from LEFT (//2)
            vim.keymap.set("n", "<leader>gl", function()
                local buf = get_fugitive_bufnum("2")
                if buf then
                    vim.cmd("diffget " .. buf)
                end
            end, { desc = "Diffget LEFT (//2)" })

            -- Diffget from RIGHT (//3)
            vim.keymap.set("n", "<leader>gr", function()
                local buf = get_fugitive_bufnum("3")
                if buf then
                    vim.cmd("diffget " .. buf)
                end
            end, { desc = "Diffget RIGHT (//3)" })
        end
    },
    {
        'airblade/vim-gitgutter',
        config = function ()
            vim.g.gitgutter_map_keys = 0

            vim.api.nvim_set_keymap("n", "<leader>gn", "<cmd>GitGutterNextHunk<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<leader>gp", "<cmd>GitGutterPrevHunk<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<leader>gu", "<cmd>GitGutterUndoHunk<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<leader>hp", "<cmd>GitGutterPreviewHunk<CR>", {noremap = true, silent = true})
        end
    },
}
