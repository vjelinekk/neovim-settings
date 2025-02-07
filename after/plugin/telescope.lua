require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--no-ignore-vcs',
        },
    }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fa', ':Telescope find_files no_ignore=true<cr>')
vim.keymap.set('n', '<leader>fp', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
