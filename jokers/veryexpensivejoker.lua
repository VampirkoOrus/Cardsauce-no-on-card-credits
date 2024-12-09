local jokerInfo = {
	name = 'Very Expensive Joker',
	config = {
		extra = {
			x_mult = 1,
			cost = 4
		}
	},
	rarity = 2,
	cost = 10,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}
function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "guestartist0", set = "Other"}
	return { vars = {card.ability.extra.x_mult} }
end

function jokerInfo.add_to_deck(self, card)
	check_for_unlock({ type = "discover_dink" })
	if G.GAME.dollars == card.cost then
		if card.cost >= 60 then
			check_for_unlock({ type = "purchase_dink" })
		end
		card.ability.extra.x_mult = (math.floor(card.cost/10)/2) + 1
		card.sell_cost = math.max(1, math.floor(card.cost/2))
		G.E_MANAGER:add_event(Event({
			func = function()
				card:juice_up()
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}}, colour = G.C.MONEY, instant = true})
				return true
			end
		}))
	end
end

function jokerInfo.calculate(self, card, context)
	if context.joker_main and context.cardarea == G.jokers then
		return {
			message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
			Xmult_mod = card.ability.extra.x_mult, 
		}
	end
end

function jokerInfo.update(self, card)
	if card.area.config.type ~= "joker" then
		if card.cost ~= G.GAME.dollars and G.GAME.dollars ~= 0 then
			card.ability.extra.cost = G.GAME.dollars
			card.cost = card.ability.extra.cost
		end
	end
end


return jokerInfo