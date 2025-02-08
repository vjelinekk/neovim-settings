return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'theHamsta/nvim-dap-virtual-text',
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
    },
    lazy = false,
    config = function ()
        local dap = require('dap')
        local dapui = require('dapui')

        dapui.setup()
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        -- adapters
        dap.adapters.lldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = '/Users/vojtechjelinek/.local/share/nvim/mason/bin/codelldb',
                args = {"--port", "${port}"},
            },
        }

        dap.configurations.c = {
            {
                name = 'Launch',
                type = 'lldb',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
            },
        }

        -- keybindings
        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('n', '<F1>', '<cmd>lua require"dap".continue()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<F2>', '<cmd>lua require"dap".step_over()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<F3>', '<cmd>lua require"dap".step_into()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<F4>', '<cmd>lua require"dap".step_out()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require"dap".close()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>B', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>dt', '<cmd> lua require"dapui".toggle()<CR>', opts)
    end
}
