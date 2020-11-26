-- Library
--------------------------------
local awful = require("awful")
local s     = mouse.screen

local clients = { }

-- this function returns the list of clients to be shown.
-------------------------------------------------------------
function clients.getAll()
	local list = {}
	-- Get focus history for current tag
	local idx = 0
	local c = awful.client.focus.history.get(s, idx)
    -- insert client's in list table
	while c do
		table.insert(list, c)
		idx = idx + 1
		c = awful.client.focus.history.get(s, idx)
	end

	-- Minimized list will not appear in the focus history
	-- Find them by cycling through all list, and adding them to the list
	-- if not already there.
	-- This will preserve the history AND enable you to focus on minimized list
	local t = s.selected_tag
	local all = client.get(s)

	for i = 1, #all do
		local c = all[i]
		local ctags = c:tags();

		-- check if the client is on the current tag
		local isCurrentTag = false
		for j = 1, #ctags do
			if t == ctags[j] then
				isCurrentTag = true
				break
			end
		end

		if isCurrentTag then
			-- check if client is already in the history
			-- if not, add it
			local addToTable = true
			for k = 1, #list do
				if list[k] == c then
					addToTable = false
					break
				end
			end

			if addToTable then
				table.insert(list, c)
			end
		end
	end
	return list
end

return clients