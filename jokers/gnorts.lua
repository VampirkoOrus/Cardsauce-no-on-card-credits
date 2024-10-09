local jokerInfo = {
	name = 'Rekoj Gnorts',
	config = {},
	rarity = 2,
	cost = 7,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true
}

--[[
function jokerInfo.loc_vars(self, info_queue, card)
	return { G.GAME.probabilities.normal }
end

function jokerInfo.set_ability(self, card, initial, delay_sprites)

end
]]--

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "guestartist7", set = "Other"}
end

function jokerInfo.calculate(self, card, context)
	--todo
end



return jokerInfo
	