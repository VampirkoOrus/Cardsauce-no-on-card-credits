local jokerInfo = {
	name = 'Deathcard [WIP]',
	config = {},
	text = {
		"When {C:attention}sold{}, reappears in the next shop",
		"with {C:mult}+#4#{} Mult and {C:money}+$#2#{} Cost",
		"{C:inactive}(Currently {}{C:mult}#3#{}{C:inactive} Mult, {}{C:money}$#1#{} {C:inactive}Cost){}",
	},
	rarity = 3,
	cost = 5,
	canBlueprint = true,
	canEternal = true
}

function jokerInfo.locDef(self)
	return { self.ability.extra.money, self.ability.extra.money_mod, self.ability.extra.mult, self.ability.extra.mult_mod }
end

function jokerInfo.init(self)
	self.ability.extra = {
		money = 5,
		money_mod = 5,
		mult = 0,
		mult_mod = 10
	}
end

function jokerInfo.calculate(self, context)
	--todo
end



return jokerInfo
	