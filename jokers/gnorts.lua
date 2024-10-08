local jokerInfo = {
	name = 'Rekoj Gnorts',
	config = {},
	text = {
		"Allows {C:attention}Straights{} to be made",
		"with {C:attention}Aces{} in the middle",
		"{C:inactive}(ex:{} {C:attention}3 2 A K Q{}{C:inactive}){}",
	},
	rarity = 2,
	cost = 7,
	blueprint_compat = false,
	eternal_compat = true
}

--[[
function jokerInfo.loc_vars(self, info_queue, card)
	return { G.GAME.probabilities.normal }
end

function jokerInfo.set_ability(self, card, initial, delay_sprites)

end
]]--

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "guestartist7", set = "Other"}
end

function jokerInfo.calculate(self, card, context)
	--todo
end



return jokerInfo
	