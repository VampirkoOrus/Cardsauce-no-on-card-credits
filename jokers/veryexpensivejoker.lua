local jokerInfo = {
	name = 'Very Expensive Joker',
	config = {
		extra = {
			x_mult = 1,
			cost = 4
		}
	},
	--[[text = {
		"{X:mult,C:white}X0.5{} Mult for every {C:money}$10{}",
		"spent on this Joker, spend all",
		"{C:attention}money{} obtaining this",
		"{C:inactive}(Currently {}{X:mult,C:white}X#1#{} {C:inactive}Mult){}",
	},]]--
	rarity = 2,
	cost = 10,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}
function jokerInfo.loc_vars(self, info_queue, card)
	return { vars = {card.ability.extra.x_mult} }
end

function jokerInfo.add_to_deck(self, card)
	check_for_unlock({ type = "discover_dink" })
	if G.GAME.dollars == card.cost then
		if card.cost >= 60 then
			check_for_unlock({ type = "purchase_dink" })
		end
		card.ability.extra.x_mult = (math.floor(card.cost/10)/2) + 1
		G.E_MANAGER:add_event(Event({
			func = function()
				card:juice_up()
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}}, colour = G.C.MONEY, instant = true})
				card.cost = 10
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
	if card.cost ~= G.GAME.dollars then
		if G.GAME.dollars ~= 0 then
			card.ability.extra.cost = G.GAME.dollars
			card.cost = card.ability.extra.cost
		end
	end
end


return jokerInfo