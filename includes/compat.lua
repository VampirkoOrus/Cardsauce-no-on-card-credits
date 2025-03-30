if Cryptid and Cryptid.food then
	local food_keys = {
	}
	for i, v in ipairs(food_keys) do
		table.insert(Cryptid.food)
	end
end

-- Talisman compat
to_big = to_big or function(num)
	return num
end