local jokerInfo = {
	name = 'Quarterdumb',
	config = {},
	rarity = 4,
	cost = 20,
	unlocked = false,
	unlock_condition = {type = '', extra = '', hidden = true},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	hasSoul = true,
	streamer = "othervinny",
	origin = "redvox",
}

function jokerInfo.loc_vars(self, info_queue, card)
	return { vars = {G.GAME.probabilities.normal} }
end

function jokerInfo.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
	G.FUNCS.generate_legendary_desc(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
end

local function textIsFlush(text)
	if text == "Flush" or text == "Straight Flush" or text == "Royal Flush" or text == "Flush House" or text == "Flush Five" then
		return true
	else
		return false
	end
end

function jokerInfo.calculate(self, card, context)
	if context.cardarea == G.jokers and context.before and not card.debuff then
		if next(context.poker_hands["Flush"]) then
			ease_hands_played(1)
			return {
				card = card,
				message = localize('k_plus_hand'),
				colour = G.C.BLUE
			}
		end
	end
end

return jokerInfo