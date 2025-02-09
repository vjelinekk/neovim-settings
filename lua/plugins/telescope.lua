return {
    'nvim-telescope/telescope.nvim',
    version = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        telescope.load_extension('fzf')

        telescope.setup({
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
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                        -- even more opts
                    }
                }
            }
        })

        require("telescope").load_extension("ui-select")

        -- Keybindings
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
        vim.keymap.set('n', '<leader>fa', function()
            builtin.find_files({ no_ignore = true })
        end, { desc = "Find all files (including ignored)" })
        vim.keymap.set('n', '<leader>fg', function()
            builtin.live_grep({ hidden = true })
        end, { desc = "Search string with grep" })
    end,
}

