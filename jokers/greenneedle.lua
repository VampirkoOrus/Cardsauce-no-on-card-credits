local jokerInfo = {
	name = 'Green Needle [WIP]',
	config = {},
	rarity = 3,
	cost = 10,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}

--[[
function jokerInfo.loc_vars(self, info_queue, card)
	return { G.GAME.probabilities.normal }
end

function jokerInfo.set_ability(self, card, initial, delay_sprites)

end
]]--

-- need rework into generate_ui
--[[loc_vars = function(self, info_queue, card)
	if not nether_util.is_in_your_collection(card) then 
		local jokers = G.jokers.cards
		local other_joker = jokers[#jokers]
		if other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat then
			card.ability.blueprint_compat = 'compatible'
		else
			card.ability.blueprint_compat = 'incompatible'
		end
	end
	card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ''; card.ability.blueprint_compat_check = nil
	return { main_end = (card.area and card.area == G.jokers) and {
		{n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
			{n=G.UIT.C, config={ref_table = card, align = "m", colour = G.C.JOKER_GREY, r = 0.05, padding = 0.06, func = 'blueprint_compat'}, nodes={
				{n=G.UIT.T, config={ref_table = card.ability, ref_value = 'blueprint_compat_ui',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.8}},
			}}
		}}
	} or nil }
end]]

function jokerInfo.calculate(self, card, context)
	local other_joker = G.jokers.cards[#G.jokers.cards]
	if other_joker and other_joker ~= card then
		context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
		context.blueprint_card = context.blueprint_card or card
		if context.blueprint > #G.jokers.cards + 1 then return end
		local other_joker_ret = other_joker:calculate_joker(context)
		if other_joker_ret then 
			other_joker_ret.card = context.blueprint_card or card
			other_joker_ret.colour = G.C.RED
			return other_joker_ret
		end
	end

	--[[G.FUNCS.blueprint_compat = function(e)
	if e.config.ref_table.ability.blueprint_compat ~= e.config.ref_table.ability.blueprint_compat_check then 
		if e.config.ref_table.ability.blueprint_compat == 'compatible' then 
			e.config.colour = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
		elseif e.config.ref_table.ability.blueprint_compat == 'incompatible' then
			e.config.colour = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
		end
		e.config.ref_table.ability.blueprint_compat_ui = ' '..localize('k_'..e.config.ref_table.ability.blueprint_compat)..' '
		e.config.ref_table.ability.blueprint_compat_check = e.config.ref_table.ability.blueprint_compat
		end
	end]]--
end



return jokerInfo
	