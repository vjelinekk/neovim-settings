return {
    {
        'tpope/vim-fugitive',
        config = function ()
            vim.api.nvim_set_keymap("n", "<leader>c", "<cmd>Gvdiffsplit!<CR>", {noremap = true, silent = true})
        end
    },
    {
        'airblade/vim-gitgutter',
        config = function ()
            vim.g.gitgutter_map_keys = 0
        end
    },
}
