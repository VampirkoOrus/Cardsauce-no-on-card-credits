local jokerInfo = {
	name = 'Vinesauce is HOPE [WIP]',
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
		mult = 0
	}
	G.GAME.modifiers.no_interest = true
end

function jokerInfo.calculate(self, context)
	--todo
	if context.selling_self then
		G.GAME.modifiers.no_interest = self.ability.extra.keepNoInterest --in case the joker is being used in a challenge
	end
end



return jokerInfo
	