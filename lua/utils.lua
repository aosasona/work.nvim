local M = {}

-- This file really shows how great I am at Lua
--
-- /s
function M.create_keymap(mode, key, cmd, opts)
	opts = opts or {}

	-- set `silent` and `noremap` by default
	local noremap = opts["noremap"] or false
	opts["remap"] = not noremap

	if opts["silent"] == nil then
		opts["silent"] = true
	end

	vim.keymap.set(mode, key, cmd, opts)
end

function M.get_session_name()
	local name = vim.fn.getcwd()
	local branch = vim.trim(vim.fn.system("git branch --show-current"))
	if vim.v.shell_error == 0 then
		return name .. branch
	else
		return name
	end
end

function M.handle_eol()
	local eol = vim.api.nvim_buf_get_option(0, "eol")
	local fixeol = vim.api.nvim_buf_get_option(0, "fixeol")
	local current_filetype = vim.bo.filetype
	local current_file_format = vim.bo.fileformat

	if eol or fixeol and (current_file_format ~= "unix" or current_filetype == "php") then
		M.set_eol()
		vim.notify("Handled EOL for this buffer", vim.log.levels.INFO)
	end
end

function M.set_eol(opts)
	vim.api.nvim_buf_set_option(0, "eol", false)
	vim.api.nvim_buf_set_option(0, "fixeol", false)
	vim.cmd([[ update ]])

	if opts ~= nil and opts["save"] ~= nil and opts["save"] == true then
		vim.cmd([[ w ]])
	end
end

function M.toggle_spellcheck()
	if vim.opt.spell:get() then
		vim.opt_local.spell = false
		vim.opt_local.spelllang = "en"
	else
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "en_gb" }
	end
end

return M
