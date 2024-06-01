local jokerInfo = {
	name = 'Green Needle [WIP]',
	config = {},
	text = {
		"Copies the ability",
		"of rightmost {C:attention}Joker{}",
	},
	rarity = 3,
	cost = 10,
	canBlueprint = true,
	canEternal = true
}

--[[
function jokerInfo.locDef(self)
	return { G.GAME.probabilities.normal }
end

function jokerInfo.init(self)

end
]]--

function jokerInfo.calculate(self, context)
	local other_joker = G.jokers.cards[#G.jokers.cards]
	if other_joker and other_joker ~= self then
		context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
		context.blueprint_card = context.blueprint_card or self
		if context.blueprint > #G.jokers.cards + 1 then return end
		local other_joker_ret = other_joker:calculate_joker(context)
		if other_joker_ret then 
			other_joker_ret.card = context.blueprint_card or self
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
	