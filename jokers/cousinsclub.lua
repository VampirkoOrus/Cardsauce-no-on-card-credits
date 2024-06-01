local jokerInfo = {
	name = 'Cousin\'s Club [WIP]',
	config = {},
	text = {
		"This Joker gains {C:chips}+6{} Chips",
		"for each {C:attention}unique{} {C:clubs}Club{} card played",
		"{C:inactive}(Currently {}{C:chips}+#1#{} {C:inactive}Chips){}",
	},
	rarity = 2,
	cost = 6,
	canBlueprint = true,
	canEternal = true
}

function jokerInfo.locDef(self)
	return { self.ability.extra.chips }
end

function jokerInfo.init(self)
	self.ability.extra = {
		chips = 0,
		chip_mod = 6
	}
end

function jokerInfo.calculate(self, context)
	if context.joker_main and context.cardarea == G.jokers then
		if G.GAME.blind.triggered and not (context.blueprint or context.repetition or context.individual) then 
			self.ability.extra.chips = self.ability.extra.chips + self.ability.extra.chip_mod
			card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.CHIPS})
		end

		return {
			message = localize{type='variable',key='a_chips',vars={self.ability.extra.chips}},
			chip_mod = self.ability.extra.chips, 
			colour = G.C.CHIPS
		}
	end
end



return jokerInfo
	