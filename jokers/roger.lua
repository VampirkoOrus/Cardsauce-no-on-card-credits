local jokerInfo = {
	name = 'Mr. Roger [WIP]',
	config = {},
	text = {
		"This Joker gains {X:mult,C:white}X0.1{} Mult",
		"for each {C:attention}finger{} played this {C:attention}Blind{}",
		"{C:inactive}(Currently {}{X:mult,C:white}X#1#{} {C:inactive}Mult){}",
	},
	rarity = 2,
	cost = 6,
	canBlueprint = false,
	canEternal = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "rogernote", set = "Other"}
end

function jokerInfo.locDef(self)
	return { self.ability.extra.x_mult }
end

function jokerInfo.init(self)
	self.ability.extra = {
		x_mult = 1
	}
end

function jokerInfo.calculate(self, context)
	if context.cardarea == G.jokers and context.before and not context.blueprint then
		local hand = context.scoring_name
		if hand == self.ability.extra.crack_hand or self.ability.extra.crack_hand == "None" then
			self.ability.extra.x_mult = self.ability.extra.x_mult + 0.1
		else
			self.ability.extra.crack_hand = hand
			if self.ability.extra.x_mult > 1 then
                self.ability.extra.x_mult = 1
                return {
                    card = self,
                    message = localize('k_reset')
                }
            end
		end
		self.ability.extra.crack_hand = hand
	  end
	if context.joker_main and context.cardarea == G.jokers then
		return {
			message = localize{type='variable',key='a_xmult',vars={self.ability.extra.x_mult}},
			Xmult_mod = self.ability.extra.x_mult, 
			--colour = G.C.MULT
		}
	end
end



return jokerInfo
	