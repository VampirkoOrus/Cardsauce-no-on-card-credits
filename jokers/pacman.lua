local jokerInfo = {
	name = 'PAC-MAN Incident',
	config = {},
	text = {
		"This Joker gains {C:mult}+5{} Mult if",
        "round ends with your chips",
        "within {C:attention}10%{} of the {C:attention}Blind{}",
        "{C:inactive}(Currently {}{C:mult}+#1#{} {C:inactive}Mult){}",
	},
	rarity = 1,
	cost = 5,
	canBlueprint = true,
	canEternal = true
}


function jokerInfo.locDef(self)
	return { self.ability.extra.mult }
end

function jokerInfo.init(self)
	self.ability.extra = {
		mult = 0,
		mult_mod = 5
	}
end


function jokerInfo.calculate(self, context)
	if context.end_of_round and not self.debuff and not context.individual and not context.repetition and not context.blueprint then
		if G.GAME.chips <= (G.GAME.blind.chips * 1.1) then
			self.ability.extra.mult = self.ability.extra.mult + self.ability.extra.mult_mod
			card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.MULT})
		end
	end
	if context.joker_main and context.cardarea == G.jokers then
		return {
			message = localize{type='variable',key='a_mult',vars={self.ability.extra.mult}},
			mult_mod = self.ability.extra.mult, 
		}
	end
end



return jokerInfo
	