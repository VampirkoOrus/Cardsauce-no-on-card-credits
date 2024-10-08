local jokerInfo = {
	name = 'Pepperoni Secret [WIP]',
	config = {},
	text = {
		"{C:attention}Secret Hands{} are",
		"upgraded when played",
	},
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
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
	if context.cardarea == G.jokers and context.before and not self.debuff then
		if context.scoring_name == "Five of a Kind" or context.scoring_name == "Flush House" or context.scoring_name == "Flush Five" then
			return {
				card = self,
				level_up = true,
				message = localize('k_level_up_ex')
			}
		end
	end
end



return jokerInfo
	