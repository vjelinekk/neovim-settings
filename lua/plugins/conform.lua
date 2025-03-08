return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				yaml = { "yamlfmt" },
                javascript = { "prettier" },
			},
		})

		vim.api.nvim_set_keymap(
			"n",
			"<leader>cf",
			'<cmd>lua require("conform").format()<cr>',
			{ noremap = true, silent = true }
		)
	end,
}
