local jokerInfo = {
	name = 'I\'m So Happy [WIP]',
	config = {},
	--[[text = {
		"{C:blue}+2{} hands, {C:red}-1{} discard",
		"{C:inactive}(Turns upside-down after",
		"{C:inactive}each round played)",
	},]]--
	rarity = 2,
	cost = 6,
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

function jokerInfo.calculate(self, card, context)
	--todo
end



return jokerInfo
	