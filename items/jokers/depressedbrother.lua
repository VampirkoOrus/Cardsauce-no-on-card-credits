local jokerInfo = {
	name = 'Depressed Brother',
	config = {
		extra = {
			mult_mod = 1,
			prob = 2,
		}
	},
	rarity = 2,
	cost = 4,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	streamer = "vinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.cejai } }
	return { vars = {G.GAME.probabilities.normal, card.ability.extra.prob, card.ability.extra.mult_mod } }
end

function jokerInfo.calculate(self, card, context)
	local bad_context = context.repetition or context.individual or context.blueprint
	if context.cardarea == G.jokers and context.before and not card.debuff and not bad_context then
		local proc = false
		for i, v in ipairs(context.full_hand) do
			if not table.contains(context.scoring_hand, v) then
				if pseudorandom('soak') < G.GAME.probabilities.normal / card.ability.extra.prob then
					proc = true
					v.ability.perma_mult = v.ability.perma_mult or 0
					v.ability.perma_mult = v.ability.perma_mult + card.ability.extra.mult_mod
					card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.MULT, func = function() card:juice_up() end})
				end
			end
		end
	end
end

return jokerInfo
	