return {
    'mfussenegger/nvim-lint',
    config = function ()
        local lint = require("lint")
        lint.linters_by_ft = {
            python = { 'pylint', 'mypy' }
        }

        -- Keymaps
        vim.keymap.set('n', '<leader>l', lint.try_lint, { desc = "Lint" })

        lint.linters.mypy.args = {
            '--strict',
            '--disallow-untyped-defs'
        }
    end
}
