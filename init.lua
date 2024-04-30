local utils = require("utils")
local map = utils.create_keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.autoformat_enabled = false

-- Netrw Config
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -28

-- ############# Lazy.nvim ############## --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- require("lazy").setup("plugins")
require("lazy").setup({
	spec = {
		-- add LazyVim and import its plugins
		-- { "LazyVim/LazyVim", import = "lazyvim.plugins" },

		-- import/override with your plugins
		{ import = "plugins" },
	},

	defaults = {
		version = "*",
	},
})

-- Use nvim-notify as default notification handler
vim.notify = require("notify")

-- Gruvbox settings
vim.opt.termguicolors = true
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1

vim.opt.spell = false
vim.opt.wrap = true
vim.opt.background = "dark"
vim.opt.cursorline = false
vim.opt.ruler = true
vim.opt.showmatch = true
vim.opt.scrolloff = 8

-- Code folding using Treesitter
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldnestmax = 3
vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 1

-- EOL fix
vim.opt.fixeol = false

-- Line number
vim.opt.number = true
vim.opt.relativenumber = true

-- General formatting settings
-- We are letting sleuth take care of this now, it auto-detects it from the file itself
--
-- vim.opt.expandtab = false -- use tab character
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4

vim.opt.fileformats = "dos,unix"

vim.cmd.colorscheme("gruvbox-material")

vim.opt.mouse = "a" -- allow mouse usage
vim.opt.showmode = false -- hide mode since it is in status line

vim.opt.clipboard = "unnamedplus" -- sync system and Neovim clipboard

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- LSP setup
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup_handlers({
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
		})
	end,
})

-- Session loading (on enter and on exit)
local resession = require("resession")
local session_name = require("utils").get_session_name

-- Auto-load sesison for current directory or branch (depending on where we"re at)
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Only load the session if nvim was started with no args
		if vim.fn.argc(-1) == 0 then
			resession.load(session_name(), { dir = "dirsession", silence_errors = true })
		end
	end,
})

-- Autosave on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		resession.save(session_name(), { dir = "dirsession", notify = false })
	end,
})

vim.g.clipboard = require("bore.clipboard").get_provider()

-- ########### Keymaps ########### --
--
-- In the future, it"ll be nice to refactor these into their own tables and files

-- Load keymaps
local keymaps_definition = require("keymaps")
for mode, keymaps in pairs(keymaps_definition) do
	for key, opts in pairs(keymaps) do
		local binding_opts = {}

		if opts["desc"] ~= nil then
			binding_opts["desc"] = opts["desc"]
		end

		if opts["noremap"] ~= nil then
			binding_opts["noremap"] = opts["noremap"]
		end

		if opts["expr"] ~= nil then
			binding_opts["expr"] = opts["expr"]
		end

		if opts["silent"] ~= nil then
			binding_opts["silent"] = opts["silent"]
		end

		map(mode, key, opts[1], binding_opts)
	end
end
