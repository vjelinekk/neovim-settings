-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- packer
    use 'wbthomason/packer.nvim'
    -- web devicons
    use 'nvim-tree/nvim-web-devicons'

    use { "catppuccin/nvim", as = "catppuccin" }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- fzf
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

    -- treesitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
    use("nvim-treesitter/playground")
    -- harpoon
    use("theprimeagen/harpoon")
    -- undotree
    use("mbbill/undotree")
    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }
    -- alpha vim
    use {
        'goolord/alpha-nvim',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    }
    -- lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    -- ntree
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }
    -- toggleterm
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end}
    -- copilot
    use {'github/copilot.vim', branch = 'release' }
    -- indentline
    use "lukas-reineke/indent-blankline.nvim"
    -- nvim-autotag
    use "windwp/nvim-ts-autotag"
    -- comments
    use 'numToStr/Comment.nvim'
    -- fugitive
    use 'tpope/vim-fugitive'
    -- aerial
    use 'stevearc/aerial.nvim'
end)
