local jokerInfo = {
	name = 'Pivyot Joker',
	config = {},
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	streamer = "vinny",
}


function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
	return { vars = {G.GAME.probabilities.normal} }
end

function jokerInfo.calculate(self, card, context)
	if context.cardarea == G.jokers and context.before and not self.debuff then
		if context.scoring_name == "High Card" then
			if pseudorandom('pivot') < G.GAME.probabilities.normal / 3 then
				return {
					card = card,
					level_up = true,
					message = localize('k_level_up_ex')
				}
			end
		end
	end
end



return jokerInfo
	