local jokerInfo = {
	name = 'Pepperoni Secret',
	config = {},
	rarity = 3,
	cost = 8,
	unlocked = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "guestartist0", set = "Other"}
end

function jokerInfo.add_to_deck(self, card)
	check_for_unlock({ type = "discover_pep" })
end

function jokerInfo.check_for_unlock(self, args)
	if args.type == "unlock_pep" then
		return true
	end
end

function jokerInfo.calculate(self, card, context)
	if context.cardarea == G.jokers and context.before and not card.debuff then
		if context.scoring_name == "Five of a Kind" or context.scoring_name == "Flush House" or context.scoring_name == "Flush Five" then
			return {
				card = self,
				level_up = true,
				message = localize('k_level_up_ex')
			}
		end
	end
end



return jokerInfo
	