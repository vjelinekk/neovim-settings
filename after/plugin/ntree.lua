require("nvim-tree").setup({
    filters = {
        dotfiles = false,
        git_ignored = false,
    },
    view = {
        adaptive_size = true,
    },
})

vim.keymap.set('n', '<leader>to', ':NvimTreeOpen<cr>')
vim.keymap.set('n', '<leader>tc', ':NvimTreeClose<cr>')
vim.keymap.set('n', '<leader>tf', ':NvimTreeFocus<cr>')
vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader>fo', ':NvimTreeFindFile<cr>')
