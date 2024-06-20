local jokerInfo = {
	name = 'Cousin\'s Club [WIP]',
	config = {},
	text = {
		"This Joker gains {C:chips}+5{} Chips",
		"for each {C:attention}unique{} {C:clubs}Club{} card scored",
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
		chip_mod = 5
	}
end

function jokerInfo.calculate(self, context)
	if context.individual and context.cardarea == G.play and not self.debuff and not (context.blueprint) then
		for k, v in ipairs(context.scoring_hand) do
			if v:is_suit('Clubs') and not (v.base.upgrade == 1) then 
				v.base.upgrade = 1
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				})) 
				self.ability.extra.chips = self.ability.extra.chips + self.ability.extra.chip_mod
				card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.CHIPS})
			end
		end
	end
	if context.joker_main and context.cardarea == G.jokers then
		return {
			message = localize{type='variable',key='a_chips',vars={self.ability.extra.chips}},
			chip_mod = self.ability.extra.chips, 
			colour = G.C.CHIPS
		}
	end
end



return jokerInfo
	