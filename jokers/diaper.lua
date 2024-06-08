local jokerInfo = {
	name = 'Diaper Joker',
	config = {},
	text = {
		"{C:mult}+2{} Mult for each {C:attention}2",
		"in your {C:attention}full deck",
		"{C:inactive}(Currently {}{C:mult}+#1#{} {C:inactive}Mult){}",
	},
	rarity = 1,
	cost = 5,
	canBlueprint = true,
	canEternal = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "diapernote", set = "Other"}
end

function jokerInfo.locDef(self)
	return { self.ability.extra.mult }
end

function jokerInfo.init(self)
	self.ability.extra = {
		mult = 0,
		mult_mod = 2
	}
end

function jokerInfo.calculate(self, context)
	if context.joker_main and context.cardarea == G.jokers and not self.debuff then
		return {
			message = localize{type='variable',key='a_mult',vars={self.ability.extra.mult}},
			mult_mod = self.ability.extra.mult,
			colour = G.C.MULT
		}
	end

end



return jokerInfo
	