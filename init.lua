local utils = require("utils")
local kmap = utils.create_keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.autoformat_enabled = false

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

require("lazy").setup("plugins")

-- Gruvbox settings
vim.opt.termguicolors = true
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1

vim.opt.spell = false
vim.opt.wrap = true
vim.opt.background = "dark"
vim.opt.cursorline = true
vim.opt.ruler = true
vim.opt.showmatch = true
vim.opt.scrolloff = 12

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

vim.cmd([[colorscheme gruvbox-material]])

vim.opt.mouse = "a"               -- allow mouse usage
vim.opt.showmode = false          -- hide mode since it is in status line

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

-- Handle EOL and no EOL
-- If the file already has noeol set, we want to leave it as it is
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  desc = "Handle EOL automatically depending on previous setting",
  callback = utils.handle_eol,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
kmap("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
kmap("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
kmap("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
kmap("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
kmap("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

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

-- ########### Keymaps ########### --
--
-- In the future, it"ll be nice to refactor these into their own tables and files

local function set_eol()
  utils.set_eol({ save = true })
end
-- Misc
kmap("n", "<leader>w", "<cmd>:w<CR>", { desc = "Save buffer" })
kmap("n", "<leader>Q", "<cmd>:qa<CR>", { desc = "Exit and close all tabs" })
kmap("n", "<leader>m", "<cmd>:marks<CR>", { desc = "Show all marks" })
kmap("n", "<leader>eo", set_eol, { desc = "Disable and fix DOS EOL manually" })

-- Move Lines
kmap("x", "J", ":move '>+1<cr>gv-gv", { desc = "Move selected line(s) down" })
kmap("x", "K", ":move '<-2<cr>gv-gv", { desc = "Move selected line(s) down" })

-- Panes
kmap("n", "<C-\\>", "<cmd>:vsplit<CR>", { desc = "Split vertically" })
kmap("n", "<C-_>", "<cmd>:split<CR>", { desc = "Split horizontally" })

-- Tabs
kmap("n", "<leader>t", "<cmd>:tabnew<CR>", { desc = "Create tab after current tab" })
kmap("n", "<leader>T", "<cmd>:-tabnew<CR>", { desc = "Create tab before current tab" })
kmap("n", "<leader>c", "<cmd>:tabclose<CR>", { desc = "Close current tab" })

-- Tab navigation
kmap("n", "L", "<cmd>:tabnext<CR>", { desc = "Move to next tab" })
kmap("n", "H", "<cmd>:tabprevious<CR>", { desc = "Move to previous tab" })
kmap("n", "<leader>]", "<cmd>:+tabmove<CR>", { desc = "Move current tab to the right" })
kmap("n", "<leader>[", "<cmd>:-tabmove<CR>", { desc = "Move current tab to the left" })

-- Trouble
kmap("n", "<leader>xx", "<cmd>:TroubleToggle<CR>", { desc = "Toggle trouble" })
kmap("n", "<leader>xr", "<cmd>:TroubleRefresh<CR>", { desc = "Refresh trouble" })

-- Code "actions" and LSP stuff
kmap("v", "<leader>/", "gc", { noremap = false, desc = "Toggle commenting current selection" })
kmap("n", "<leader>/", "gcc", { noremap = false, desc = "Toggle commenting line under cursor" })

kmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, desc = "Go to definition" })
kmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, desc = "Go to definition" })
kmap("n", "gt", "<cmd>tabnew | vim.lsp.buf.definition()<CR>", { noremap = true, desc = "Go to definition in new tab" })

kmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, desc = "Show diagnostic info" })
kmap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, desc = "Go to implementation" })
kmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, desc = "Show references" })
kmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, desc = "Hover to show documentation" })

-- Jumplist mapping
kmap("n", "go", "<C-o>", { noremap = true, desc = "Jump to previous location" })
kmap("n", "gi", "<C-i>", { noremap = true, desc = "Jump to next location" })

kmap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { noremap = true, desc = "Show code action menu" })
kmap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", {
  noremap = true,
  desc = "Format current buffer",
})
kmap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { noremap = true, desc = "Rename symbol" })
kmap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, desc = "Show signature help" })
kmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", { noremap = true, desc = "Go to next diagnosis" })
kmap("n", "]D", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", {
  noremap = true,
  desc = "Go to previous diagnosis",
})

-- Disabled on purpose
-- kmap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", { noremap = true, desc = "Format buffer" })

-- Session mappings
kmap("n", "<leader>sf", resession.list, { desc = "List all available saved sessions" })
kmap("n", "<leader>ss", resession.save, { desc = "Save session for current directory" })
kmap("n", "<leader>sa", resession.save_all, { desc = "Save all sessions" })
kmap("n", "<leader>st", resession.save_tab, { desc = "Save session for current tab" })
kmap("n", "<leader>s.", resession.load, { desc = "Load last session for current directory" })
kmap("n", "<leader>sd", resession.delete, { desc = "Select and delete session" })

-- Git stuff
kmap("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", { desc = "Toggle Git blame" })
kmap("n", "<leader>gc", "<cmd>GitBlameCopyCommitURL<CR>", { desc = "Copy commit URL" })
kmap("n", "<leader>gC", "<cmd>GitBlameCopyFileURL<CR>", { desc = "Copy file upstream URL" })