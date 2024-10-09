local jokerInfo = {
	name = 'Deathcard [WIP]',
	config = {extra = {
		money = 5,
		money_mod = 5,
		mult = 0,
		mult_mod = 10
	}},
	rarity = 3,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
	return { vars = {card.ability.extra.money, card.ability.extra.money_mod, card.ability.extra.mult, card.ability.extra.mult_mod} }
end

--[[function jokerInfo.set_ability(self, card, initial, delay_sprites)

end]]--

function jokerInfo.calculate(self, card, context)
	--todo
end



return jokerInfo
	