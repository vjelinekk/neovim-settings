return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Completion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "saadparwaiz1/cmp_luasnip",

        -- Snippets
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        -- MASON SETUP
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "rust_analyzer",
                "phpactor",
                "clangd",
            },
            automatic_installation = true,
        })

        -- CMP SETUP
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
            }),
            sources = cmp.config.sources(
                {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
                {
                    { name = "buffer" },
                }
            ),
        })

        cmp.setup.filetype( { "sql" }, {
            sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
            }
        })

        -- CAPABILITIES
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- LSP SERVER CONFIG
        local lspconfig = require("lspconfig")

        local jumpFunction = function(direction)
            return function()
                vim.diagnostic.jump({
                    count = direction,
                    float = true,
                })
            end
        end

        local hoverFormat = function ()
            return function ()
                vim.lsp.buf.hover({
                    border = "rounded",
                })
            end
        end

        local on_attach = function(_, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            local map = vim.keymap.set
            map("n", "gd", vim.lsp.buf.definition, opts)
            map("n", "gh", hoverFormat(), opts)
            map("n", "ge", vim.diagnostic.open_float, opts)
            map("n", "gn", jumpFunction(1), opts)
            map("n", "gp", jumpFunction(-1), opts)
            map("n", "ga", vim.lsp.buf.code_action, opts)
            map("n", "<leader>fu", vim.lsp.buf.references, opts)
            map("n", "<leader>rn", vim.lsp.buf.rename, opts)
            map("i", "<C-h>", vim.lsp.buf.signature_help, opts)
        end

        -- Setup each LSP server
        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            },
            ts_ls = {},
            phpactor = {},
            clangd = {},
        }

        for name, config in pairs(servers) do
            config.capabilities = capabilities
            config.on_attach = on_attach
            lspconfig[name].setup(config)
        end

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = { border = "rounded" },
        })
    end,
}
