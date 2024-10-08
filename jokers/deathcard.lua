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
	blueprint_compat = true,
	eternal_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
	return { card.ability.extra.money, card.ability.extra.money_mod, card.ability.extra.mult, card.ability.extra.mult_mod }
end

function jokerInfo.set_ability(self, card, initial, delay_sprites)
	card.ability.extra = {
		money = 5,
		money_mod = 5,
		mult = 0,
		mult_mod = 10
	}
end

function jokerInfo.calculate(self, card, context)
	--todo
end



return jokerInfo
	