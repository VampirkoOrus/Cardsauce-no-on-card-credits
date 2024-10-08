local jokerInfo = {
	name = 'Cryberries [WIP]',
	config = {},
	text = {
		"idfk",
	},
	rarity = 1,
	cost = 0,
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

function jokerInfo.calculate(self, card, context)
	--todo
end



return jokerInfo
	