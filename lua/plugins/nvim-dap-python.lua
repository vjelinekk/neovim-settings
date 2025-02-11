return {
    'mfussenegger/nvim-dap-python',
    config = function ()
        require("dap-python").setup("~/.virtualenvs/debugpy/bin/python3")
    end
}
