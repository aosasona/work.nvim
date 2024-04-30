return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				auto_refresh = true,
			},
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<S-Tab>",
					dismiss = "<C-]>",
					next = "<C-j>",
					prev = "<C-k>",
				}
			}
		})
	end,
}
