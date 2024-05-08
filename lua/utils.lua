local M = {}

-- This file really shows how great I am at Lua 
--
-- /s
function M.create_keymap(mode, key, cmd, opts)
	opts = opts or {}

	-- set `silent` and `noremap` by default
	local noremap = opts['noremap'] or false
	opts['remap'] = not noremap

	if opts['silent'] == nil then
		opts['silent'] = true
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


return M
