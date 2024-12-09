local jokerInfo = {
	name = 'Speed Joker',
	config = {extra = 1},
	rarity = 1,
	cost = 4,
	unlocked = false,
	unlock_condition = {type = 'discover_sohappy'},
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.check_for_unlock(self, args)
	if args.type == "discover_sohappy" then
		return true
	end
end

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "guestartist0", set = "Other"}
	info_queue[#info_queue+1] = {key = "guestartist4", set = "Other"}
	return { vars = {card.ability.draw} }
end

function jokerInfo.add_to_deck(self, card)
	check_for_unlock({ type = "discover_speed" })
end

function jokerInfo.init(card)
	card.ability.extra = G.GAME.current_round.hands_played + 1
end

function jokerInfo.calculate(self, card, context)
	if context.setting_blind and not self.getting_sliced and not context.blueprint then
		card.ability.extra = 1
	end
end

return jokerInfo
	