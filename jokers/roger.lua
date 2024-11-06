local jokerInfo = {
	name = 'Mr. Roger [WIP]',
	config = {
		extra = {
			x_mult = 1
		}
	},
	--[[text = {
		"This Joker gains {X:mult,C:white}X0.1{} Mult",
		"for each {C:attention}finger{} played this {C:attention}Blind{}",
		"{C:inactive}(Currently {}{X:mult,C:white}X#1#{} {C:inactive}Mult){}",
	},]]--
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "rogernote", set = "Other"}
	return { vars = {card.ability.extra.x_mult} }
end

function jokerInfo.calculate(self, card, context)
	if context.joker_main and context.cardarea == G.jokers and not card.debuff then
		sendInfoMessage("Hands played: "..G.GAME.current_round.hands_played)
		sendInfoMessage("Roger Mult Before: X"..card.ability.extra.x_mult)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.0,
			func = (function()
				card.ability.extra.x_mult = 1 + 0.5*(G.GAME.current_round.hands_played)
				sendInfoMessage("Roger Mult After: X"..card.ability.extra.x_mult)
				return true
			end)}))
		if card.ability.extra.x_mult > 1 then
			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
	end
	if context.end_of_round and not context.blueprint and card.ability.extra.x_mult > 1 then
		sendInfoMessage("Resetting Roger Mult...")
		card.ability.extra.x_mult = 1
		sendInfoMessage("Roger Mult is now X"..card.ability.extra.x_mult..". Sending reset message...")
		return {
			message = localize('k_reset'),
			colour = G.C.RED
		}
	end
end



return jokerInfo
	