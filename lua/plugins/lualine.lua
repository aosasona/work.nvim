return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({})
	end,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons",           enabled = vim.g.have_nerd_font },
	},
}
