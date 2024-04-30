local utils = require("utils")

local resession = require("resession")
local builtin = require("telescope.builtin")

return {
	-- Normal mode
	n = {
		["<Esc>"] = { "<cmd>nohlsearch<CR>" },

		-- Keybinds to make split navigation easier.
		--  Use CTRL+<hjkl> to switch between windows
		--
		--  See `:help wincmd` for a list of all window commands
		["<C-h>"] = { "<C-w>h", desc = "Move focus to the left window" },
		["<C-l>"] = { "<C-w>l", desc = "Move focus to the right window" },
		["<C-j>"] = { "<C-w><C-j>", desc = "Move focus to the lower window" },
		["<C-k>"] = { "<C-w><C-k>", desc = "Move focus to the upper window" },

		-- Misc useful maps
		["<leader>Q"] = { "<cmd>:qa<CR>", desc = "Exit and close all tabs" },
		["<leader>w"] = { "<cmd>:w<CR>", desc = "Save buffer" },
		["<leader>m"] = { "<cmd>:marks<CR>", desc = "Show all marks" },
		["<leader>eo"] = {
			function()
				utils.set_eol({ save = true })
			end,
			desc = "Disable and fix DOS EOL manually",
		},
		["<leader>lH"] = {
			function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
			end,
			desc = "Toggle inlay hints",
		},

		-- Copilot
		["<leader>cc"] = {
			function()
				require("copilot.suggestion").toggle_auto_trigger()
			end,
			desc = "Toggle copilot suggestion",
		},

		-- Spell check
		["<leader>sp"] = { utils.toggle_spellcheck, desc = "Toggle spellcheck" },
		["<leader>sz"] = { "[s1z=``", desc = "Fix spelling errors" },

		-- Movements
		-- Move between wrapped lines
		["k"] = {
			function()
				return vim.v.count == 0 and "gk" or "k"
			end,
			expr = true,
			noremap = true,
		},
		["j"] = {
			function()
				return vim.v.count == 0 and "gj" or "j"
			end,
			expr = true,
			noremap = true,
		},

		-- Panes
		["<C-\\>"] = { "<cmd>:vsplit<CR>", desc = "Split vertically" },
		["<C-_>"] = { "<cmd>:split<CR>", desc = "Split horizontally" },

		-- Tabs
		["<leader>t"] = { "<cmd>:tabnew<CR>", desc = "Create tab after current tab" },
		["<leader>T"] = { "<cmd>:-tabnew<CR>", desc = "Create tab before current tab" },
		["<leader>c"] = { "<cmd>:tabclose<CR>", desc = "Close current tab" },

		-- Tab navigation
		["L"] = { "<cmd>:tabnext<CR>", desc = "Move to next tab" },
		["H"] = { "<cmd>:tabprevious<CR>", desc = "Move to previous tab" },
		["<leader>]"] = { "<cmd>:+tabmove<CR>", desc = "Move current tab to the right" },
		["<leader>["] = { "<cmd>:-tabmove<CR>", desc = "Move current tab to the left" },

		-- Trouble
		["<leader>x"] = { "", desc = "Trouble" },
		["<leader>xx"] = { "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Diagnostics (Trouble)" },
		["<leader>xb"] = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (trouble)" },
		["<leader>xs"] = {
			"<cmd>Trouble symbols toggle pinned=true results.win.relative=win results.win.position=right<cr>",
			desc = "Symbols (trouble)",
		},
		["<leader>xL"] = {
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		["<leader>xk"] = { "<cmd>Trouble diagnostics prev<cr>", desc = "Previous item" },
		["<leader>xj"] = { "<cmd>Trouble diagnostics next<cr>", desc = "Next item" },
		["<leader>xl"] = { "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		["<leader>xq"] = { "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },

		-- Code "actions" and LSP stuff
		["<leader>/"] = { "gcc", noremap = false, desc = "Toggle commenting line under cursor" },

		["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", noremap = true, desc = "Go to definition" },
		["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", noremap = true, desc = "Go to definition" },
		["gt"] = { "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", noremap = true, desc = "Go to definition in new tab" },

		["gl"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", noremap = true, desc = "Show diagnostic info" },
		["gI"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", noremap = true, desc = "Go to implementation" },
		["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", noremap = true, desc = "Show references" },
		["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", noremap = true, desc = "Hover to show documentation" },

		["<leader>l"] = { "", desc = "LSP" },
		["<leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", noremap = true, desc = "Show code action menu" },
		["<leader>lf"] = {
			"<cmd>lua vim.lsp.buf.format( async = true })<CR>",
			noremap = true,
			desc = "Format current buffer",
		},
		["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", noremap = true, desc = "Rename symbol" },
		["<leader>ls"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", noremap = true, desc = "Show signature help" },
		["]d"] = { "<cmd>lua vim.diagnostic.goto_next(buffer=0})<cr>", noremap = true, desc = "Go to next diagnosis" },
		["]D"] = {
			"<cmd>lua vim.diagnostic.goto_prev(buffer=0})<cr>",
			noremap = true,
			desc = "Go to previous diagnosis",
		},

		-- Jumplist mapping
		["go"] = { "<C-o>", noremap = true, desc = "Jump to previous location" },
		["gi"] = { "<C-i>", noremap = true, desc = "Jump to next location" },

		-- Session mappings
		["<leader>s"] = { "", desc = "Session" },
		["<leader>sf"] = { resession.list, desc = "List all available saved sessions" },
		["<leader>ss"] = { resession.save, desc = "Save session for current directory" },
		["<leader>sa"] = { resession.save_all, desc = "Save all sessions" },
		["<leader>st"] = { resession.save_tab, desc = "Save session for current tab" },
		["<leader>s."] = { resession.load, desc = "Load last session for current directory" },
		["<leader>sd"] = { resession.delete, desc = "Select and delete session" },

		-- Git stuff
		["<leader>g"] = { "", desc = "Git" },
		["<leader>gb"] = { "<cmd>GitBlameToggle<CR>", desc = "Toggle Git blame" },
		["<leader>gy"] = { "<cmd>GitBlameCopyCommitURL<CR>", desc = "Copy commit URL" },
		["<leader>gY"] = { "<cmd>GitBlameCopyFileURL<CR>", desc = "Copy file upstream URL" },

		-- Conflicts
		["<leader>gc"] = { "<cmd>GitConflictListQf<CR>", desc = "Show a quickfix list of conflicts" },

		["<leader>gcb"] = { "<cmd>GitConflictChooseBoth<CR>", desc = "Accept both changes" },
		["<leader>gco"] = { "<cmd>GitConflictChooseOurs<CR>", desc = "Select our changes" },
		["<leader>gct"] = { "<cmd>GitConflictChooseTheirs<CR>", desc = "Accept incoming changes" },
		["<leader>gcn"] = { "<cmd>GitConflictChooseNone<CR>", desc = "Select none of the changes" },

		["<leader>g]"] = { "<cmd>GitConflictNextConflict<CR>", desc = "Go to next conflict" },
		["<leader>g["] = { "<cmd>GitConflictPrevConflict<CR>", desc = "Go to previous conflict" },

		-- Telescope bindings
		["<leader>f"] = { "", desc = "Telescope" },
		["<leader>ff"] = { builtin.find_files, desc = "Search files" },
		["<leader>fw"] = { builtin.grep_string, desc = "Search current word" },
		["<leader>fg"] = { builtin.live_grep, desc = "Live grep in current directory/workspace" },
	},

	-- Select mode
	v = {
		["<leader>/"] = { "gc", noremap = false, desc = "Toggle commenting current selection" },
	},

	-- Visual mode
	x = {
		-- Movements
		-- Move lines
		["J"] = { ":move '>+1<cr>gv-gv", desc = "Move selected line(s) down" },
		["K"] = { ":move '<-2<cr>gv-gv", desc = "Move selected line(s) down" },
	},
}
