local plugins = {}

local function is_array(table)
	return type(table) == "table" and table[1] ~= nil
end

-- Read all files in the plugins directory except for the init.lua file
local files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/plugins", "*.lua", false, true)

for _, file in ipairs(files) do
	if file:match("init.lua") == nil then
		local plugin_name = file:match("plugins/(.*)"):gsub(".lua", "")
		local plugin = require("plugins." .. plugin_name)

		-- If it is an array of plugins, add them all
		if is_array(plugin) then
			for _, plugin_definition in ipairs(plugin) do
				table.insert(plugins, plugin_definition)
			end
		else
			table.insert(plugins, plugin)
		end
	end
end

return plugins
