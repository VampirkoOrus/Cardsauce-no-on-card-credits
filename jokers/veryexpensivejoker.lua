local jokerInfo = {
	name = 'Very Expensive Joker [WIP]',
	config = {},
	text = {
		"{X:mult,C:white}X0.5{} Mult for every {C:money}$10{}",
		"spent on this Joker, spend all",
		"{C:attention}money{} buying this",
		"{C:inactive}(Currently {}{X:mult,C:white}X#1#{} {C:inactive}Mult){}",
	},
	rarity = 2,
	cost = 0,
	canBlueprint = false,
	canEternal = true
}
function jokerInfo.locDef(self)
	return { self.ability.extra.x_mult }
end

function jokerInfo.init(self)
	self.ability.extra = {
		x_mult = 1,
		dollars = 0
	}
end

function jokerInfo.calculate(self, context)
	--todo
end



return jokerInfo
	