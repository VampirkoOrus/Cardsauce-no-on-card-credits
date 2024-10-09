local jokerInfo = {
	name = 'Odious Joker [WIP]',
	config = {},
	--[[text = {
		"{C:dark_edition}It would be in your best interests to stop.{}",
		"{C:dark_edition}These cards are my domain, and I their master.{}",
	},]]--
	rarity = 3,
	cost = 6,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false
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
	