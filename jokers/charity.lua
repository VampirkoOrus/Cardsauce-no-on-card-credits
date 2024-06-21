local jokerInfo = {
	name = 'Vinesauce is HOPE',
	config = {},
	text = {
		"Earn no {C:money}Interest{} at the end of",
		"each round. This Joker gains {C:mult}+1{} Mult",
		"for each {C:money}$1{} lost this way",
		"{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}",
	},
	rarity = 3,
	cost = 7,
	canBlueprint = false,
	canEternal = true
}


function jokerInfo.locDef(self)
	return { self.ability.extra.mult }
end

function jokerInfo.init(self)
	self.ability.extra = {
		keepNoInterest = G.GAME.modifiers.no_interest,
		mult = 0,
		mult_gain = 0
	}
end

function jokerInfo.calculate(self, context)
	
	if context.end_of_round and not self.debuff and not context.individual and not context.repetition and not context.blueprint then
		self.ability.extra.mult_gain = 0
		if not G.GAME.modifiers.no_interest then
			self.ability.extra.mult_gain = G.GAME.interest_amount*math.min(math.floor(G.GAME.dollars/5), G.GAME.interest_cap/5)
		end
		self.ability.extra.mult = self.ability.extra.mult + self.ability.extra.mult_gain
		if self.ability.extra.mult_gain ~= 0 then
			card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{ type = 'variable', key = 'a_mult', vars = {self.ability.extra.mult_gain} }, colour = G.C.MULT})
		end
	end
	
	if context.joker_main and context.cardarea == G.jokers then
		if self.ability.extra.mult ~= 0 then
			return {
				message = localize { type = 'variable', key = 'a_mult', vars = {self.ability.extra.mult} },
				mult_mod = self.ability.extra.mult,
			}
		end
	end
end



return jokerInfo
	