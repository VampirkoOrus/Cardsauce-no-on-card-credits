local jokerInfo = {
	name = 'Very Expensive Joker',
	config = {
		extra = {
			x_mult = 1,
			dollars = 0
		}
	},
	--[[text = {
		"{X:mult,C:white}X0.5{} Mult for every {C:money}$10{}",
		"spent on this Joker, spend all",
		"{C:attention}money{} obtaining this",
		"{C:inactive}(Currently {}{X:mult,C:white}X#1#{} {C:inactive}Mult){}",
	},]]--
	rarity = 1,
	cost = 0,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true
}
function jokerInfo.loc_vars(self, info_queue, card)
	return { vars = {card.ability.extra.x_mult} }
end

local add_to_deck_ref = Card.add_to_deck

function Card:add_to_deck(from_debuff)
	add_to_deck_ref(self, from_debuff)
	if self.config.center_key == 'j_veryexpensivejoker' then
		if G.GAME.dollars > 0 then 
			card.ability.extra.dollars = G.GAME.dollars
		else
			card.ability.extra.dollars = 0
		end
		card.ability.extra.x_mult = (math.floor(card.ability.extra.dollars/10)/2) + 1
		ease_dollars(-(card.ability.extra.dollars) +1)
		card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}}})
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



return jokerInfo
	