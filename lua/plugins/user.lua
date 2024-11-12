return {
	{ "rcarriga/nvim-notify", as = "notify" },
	{ "tpope/vim-sleuth", lazy = false },
	{
		'MagicDuck/grug-far.nvim',
		config = function() require('grug-far').setup({}); end
	},

	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "master",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "php", "css", "html", "javascript", "lua", "regex" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},
	{ "tpope/vim-surround" },
	{
		"f-person/git-blame.nvim",
		config = function()
			require("gitblame").setup({
				enabled = false,
			})
		end,
	},
	{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({})
		end,
	},
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	},
	{
		"stevearc/resession.nvim",
		config = function()
			require("resession").setup({
				autosave = {
					enabled = true,
					interval = 60,
					notify = false,
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function() require("ibl").setup() end,
		opts = {},
	},
	{
		"uga-rosa/ccc.nvim",
		lazy = false,
		config = function ()
			require('ccc').setup {
				highlighter = {
					auto_enable = true,
					lsp = true,
				}
			}
		end
	},
}
