local jokerInfo = {
	name = 'Green Needle',
	config = {},
	rarity = 3,
	cost = 10,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.calculate(self, card, context)
	local rightmost_joker = G.jokers.cards[#G.jokers.cards]
	if rightmost_joker and rightmost_joker ~= card then
		context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
		context.blueprint_card = context.blueprint_card or card
		if context.blueprint > #G.jokers.cards + 1 then return end
		context.no_callback = true
		local other_joker_ret = rightmost_joker:calculate_joker(context)
		if other_joker_ret then
			other_joker_ret.card = context.blueprint_card or card
			context.no_callback = false
			other_joker_ret.colour = G.C.RED
			return other_joker_ret
		end
	end
end

function jokerInfo.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
	full_UI_table.name = localize{type = 'name', key = self.key, set = self.set, name_nodes = {}, vars = specific_vars or {}}
	localize{type = 'descriptions', key = self.key, set = self.set, nodes = desc_nodes, vars = vars}
	if card.area and card.area == G.jokers then
		desc_nodes[#desc_nodes+1] = {
			{n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
				{n=G.UIT.C, config={ref_table = self, align = "m", colour = card.ability.blueprint_compat == 'compatible' and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06}, nodes={
					{n=G.UIT.T, config={text = ' '..localize('k_'..card.ability.blueprint_compat)..' ',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.8}},
				}}
			}}
		}
	end
end

function jokerInfo.update(self, card)
	if G.STAGE == G.STAGES.RUN then
		local other_joker = G.jokers.cards[#G.jokers.cards]
		if other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat then
			card.ability.blueprint_compat = 'compatible'
		else
			card.ability.blueprint_compat = 'incompatible'
		end
	end
end

return jokerInfo
	