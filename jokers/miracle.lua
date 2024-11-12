local jokerInfo = {
	name = 'Miracle of Life',
	config = {},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}


function jokerInfo.loc_vars(self, info_queue, card)
	return { vars = {G.GAME.probabilities.normal} }
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

local function starts_with(str, start)
    return str:sub(1, 1) == start
end

function jokerInfo.calculate(self, card, context)
	if context.cardarea == G.jokers and context.before and not card.debuff then
		if next(context.poker_hands["Pair"]) then
			local id_count = {}
			local pair_count = 0
			local pairs_list = {}
			
			for k, v in ipairs(context.scoring_hand) do
				local id = v:get_id()
				
				-- Add the item to the id_count
				if not id_count[id] then
					id_count[id] = {count = 0, items = {}} -- Track both count and items
				end
				id_count[id].count = id_count[id].count + 1
				table.insert(id_count[id].items, v) -- Store the item (v) itself for later use
			end
			

			-- Check how many pairs we can get from the occurrences
			for id, data in pairs(id_count) do
				-- Calculate number of pairs from this id
				local num_pairs = math.floor(data.count / 2)
				pair_count = pair_count + num_pairs
				
				-- Store pairs (each pair will have 2 items)
				for i = 1, num_pairs do
					-- Add the first two items as a pair, then move to the next pair
					table.insert(pairs_list, {data.items[2 * i - 1], data.items[2 * i]})
				end
			end

			-- Third loop to log the suits of items in the pairs
			for i, pair in ipairs(pairs_list) do
				local item1 = pair[1]
				local item2 = pair[2]
				local items = {item1, item2}
				
				local pair_suits = {}
				local pair_effects = {}
				local pair_seals = {}
				local pair_editions = {}
				
				sendInfoMessage("Pair " .. i .. ": ")
				
				for _i, item in ipairs(items) do
					sendInfoMessage("Item " .. _i .. " Suit: " .. item.base.suit)
					table.insert(pair_suits, item.base.suit)
					sendInfoMessage("Item " .. _i .. " Effect: " .. item.ability.effect .. " (Type: " .. type(item.ability.effect) .. ")")
					table.insert(pair_effects, item.ability.effect)
					sendInfoMessage("pair_effects after insertion: " .. table.concat(pair_effects, ", "))
					if item.seal then
						sendInfoMessage("Item " .. _i .. " Seal: " .. item.seal)
						table.insert(pair_seals, item.seal)
					end
					if item.edition then
						sendInfoMessage("Item " .. _i .. " Edition: " .. item.edition.type)
						table.insert(pair_editions, item.edition.type)
					end
				end
				
				if pseudorandom('miracle') < G.GAME.probabilities.normal / 2 then
					sendInfoMessage("Birthed!")
					G.E_MANAGER:add_event(Event({
                    func = function() 
						local filtered_cards = deepcopy(G.P_CARDS)
						for key in pairs(filtered_cards) do
							if not string.find(filtered_cards[key].name, pair_suits[1]) and not string.find(filtered_cards[key].name, pair_suits[2]) then
								sendInfoMessage("Child will not be a ".. filtered_cards[key].name)
								filtered_cards[key] = nil
							end
						end
						local _card = create_playing_card({front = pseudorandom_element(filtered_cards, pseudoseed('miracle_card')), center = G.P_CENTERS.c_base}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
						for k, v in ipairs(pair_effects) do
							sendInfoMessage("Index " .. k .. ": " .. v)
						end
						if pseudorandom('miracle_eff') < G.GAME.probabilities.normal / 2 then
							local rand_eff = pseudorandom_element(pair_effects, pseudoseed('miracle_effects'))
							if rand_eff == "Bonus" then
								_card:set_ability(G.P_CENTERS.m_bonus, nil, true)
							elseif rand_eff == "Mult" then
								_card:set_ability(G.P_CENTERS.m_mult, nil, true)
							elseif rand_eff == "Wild Card" then
								_card:set_ability(G.P_CENTERS.m_wild, nil, true)
							elseif rand_eff == "Glass Card" then
								_card:set_ability(G.P_CENTERS.m_glass, nil, true)
							elseif rand_eff == "Steel Card" then
								_card:set_ability(G.P_CENTERS.m_steel, nil, true)
							elseif rand_eff == "Stone Card" then
								_card:set_ability(G.P_CENTERS.m_stone, nil, true)
							elseif rand_eff == "Gold Card" then
								_card:set_ability(G.P_CENTERS.m_gold, nil, true)
							elseif rand_eff == "Lucky Card" then
								_card:set_ability(G.P_CENTERS.m_lucky, nil, true)
							end
							if rand_eff ~= "Base" then
								sendInfoMessage("Child inherited Enhancement! Assigned: " .. rand_eff)
							end
							G.E_MANAGER:add_event(Event({
								func = function()
									_card:juice_up()
									return true
								end
							})) 
						end
						if #pair_seals > 0 then
							if pseudorandom('miracle_s') < G.GAME.probabilities.normal / 2 then
								local rand_seal = pseudorandom_element(pair_seals, pseudoseed('miracle_seals'))
								sendInfoMessage("Child inherited Seal! Assigned: " .. rand_seal)
								_card:set_seal(rand_seal, true)
							end
						end
						if #pair_editions > 0 then
							if pseudorandom('miracle_e') < G.GAME.probabilities.normal / 2 then
								local rand_edition = pseudorandom_element(pair_editions, pseudoseed('miracle_editions'))
								sendInfoMessage("Child inherited Edition! Assigned: " .. rand_edition)
								if rand_edition == "foil" then
									_card:set_edition({foil = true}, true)
								elseif rand_edition == "holo" then
									_card:set_edition({holo = true}, true)
								elseif rand_edition == "polychrome" then
									_card:set_edition({polychrome = true}, true)
								end
							end
						end
						G.GAME.blind:debuff_card(_card)
                        G.hand:sort()
                        if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
                        return true
                    end}))
					playing_card_joker_effects({true})
				else
					sendInfoMessage("Miscarried!")
				end
				
				-- Log the suit values for the pair
				
			end
		end
	end
end



return jokerInfo
	