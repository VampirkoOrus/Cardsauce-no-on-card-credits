local jokerInfo = {
	name = 'Pepperoni Secret',
	config = {},
	rarity = 3,
	cost = 8,
	unlocked = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	streamer = "vinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "artistcredit", set = "Other", vars = { csau_team.gote } }
end

local function hasPlayedSecret()
	for k, v in pairs(G.handlist) do
		if G.GAME.hands[v].visible and not SMODS.PokerHands[v].visible then
			return true
		end
	end
end

function jokerInfo.in_pool(self, args)
	if hasPlayedSecret() then
		return true
	end
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
		if not SMODS.PokerHands[context.scoring_name].visible then
			return {
				card = card,
				level_up = true,
				message = localize('k_level_up_ex')
			}
		end
	end
end

return jokerInfo
	
