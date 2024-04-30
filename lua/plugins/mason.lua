return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function() require("mason").setup() end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({ ensure_installed = { "lua_ls" }, })
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				handlers = {},
			})
		end,
	},

	{ "neovim/nvim-lspconfig", lazy = false }
}
