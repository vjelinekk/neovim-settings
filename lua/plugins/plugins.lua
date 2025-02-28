return {
    -- Web devicons
    { 'nvim-tree/nvim-web-devicons' },

    -- FZF
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },

    -- Undo tree
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },

    -- Alpha Vim
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('alpha').setup(require('alpha.themes.startify').config)
        end
    },

    -- Copilot
    { 'github/copilot.vim', branch = 'release' },

    -- Indent line
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('ibl').setup()
        end
    },

    -- Commenting
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    -- Aerial (code outline)
    {
        'stevearc/aerial.nvim',
        config = function ()
            require('aerial').setup()
        end
    },

    -- File browser
    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        config = function ()
            require("telescope").load_extension("file_browser")

            vim.keymap.set("n", "<space>fb", function()
                require("telescope").extensions.file_browser.file_browser()
            end)
        end
    },

    -- Telescope UI Select
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Vim-Tmux Navigator
    { 'christoomey/vim-tmux-navigator' },

    -- Auto Pairs
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup({})
        end
    }
}

