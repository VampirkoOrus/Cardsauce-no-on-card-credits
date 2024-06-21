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
	canBlueprint = true,
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
		x_mult = 1 + 0.5*(G.GAME.current_round.hands_played),
		counter = 0
	}
end

function jokerInfo.calculate(self, context)
	if context.joker_main and context.cardarea == G.jokers then
		self.ability.extra.x_mult = 1 + 0.5*(self.ability.extra.counter)
		self.ability.extra.counter = self.ability.extra.counter + 1
		if self.ability.extra.x_mult ~= 1 then
			return {
				message = localize{type='variable',key='a_xmult',vars={self.ability.extra.x_mult}},
				Xmult_mod = self.ability.extra.x_mult, 
				--colour = G.C.MULT
			}
		end
	end
	if context.end_of_round and not context.blueprint then
		self.ability.extra.x_mult = 1
		self.ability.extra.counter = 0
	end
end



return jokerInfo
	