local jokerInfo = {
	name = 'The NEW Joker!',
	config = {
		extra = {
			mult = 4
		}
	},
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	has_shiny = true,
	pools = {
		["Meme"] = true
	},
	streamer = "othervinny",
}


function jokerInfo.loc_vars(self, info_queue, card)

	return {vars = {card.ability.extra.mult}}
end

function jokerInfo.calculate(self, card, context)
	if context.individual and context.cardarea == G.play and not card.debuff then
		if context.other_card.ability.effect ~= 'Base' and not context.other_card.debuff then
			return {
				mult = card.ability.extra.mult,
				card = card
			}
		end
	end
end



return jokerInfo
	