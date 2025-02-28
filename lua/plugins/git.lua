return {
    {
        'tpope/vim-fugitive',
        config = function ()
            vim.api.nvim_set_keymap("n", "<leader>c", "<cmd>Gvdiffsplit!<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>Git blame<CR>", {noremap = true, silent = true})
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
