local jokerInfo = {
	name = 'No No No No No No No No No No No',
	config = {
		extra = 2,
		chadNum = nil,
		talking = {},
		cancel = {},
		quips = {}
	},
	rarity = 1,
	cost = 0,
	blueprint_compat = false,
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

function jokerInfo.init(card)
	chad = card
	if csau_enabled['chadSay'] then
		if G.localization.descriptions["Joker"]["j_csau_chad"] ~= G.localization.descriptions["Joker"]["j_csau_chad_speaking"] then
			G.localization.descriptions["Joker"]["j_csau_chad"] = G.localization.descriptions["Joker"]["j_csau_chad_speaking"]
		end
	else
		if G.localization.descriptions["Joker"]["j_csau_chad"] ~= G.localization.descriptions["Joker"]["j_csau_chad_muted"] then
			G.localization.descriptions["Joker"]["j_csau_chad"] = G.localization.descriptions["Joker"]["j_csau_chad_muted"]
		end
	end
end


function jokerInfo.calculate(self, card, context)
	if context.other_joker and not card.debuff and not context.blueprint then
		if (context.other_joker.config.center.name == ('No No No No No No No No No No No') or context.other_joker.ability.name == 'Hanging Chad' or context.other_joker.ability.name == 'Showman') and card ~= context.other_joker then
			G.E_MANAGER:add_event(Event({
				func = function()
					context.other_joker:juice_up(0.5, 0.5)
					return true
				end
			}))
			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra}},
            	Xmult_mod = card.ability.extra
			}
		end
	end
end

function jokerInfo.add_to_deck(self, card)
	if csau_enabled['chadSay'] then
		if not next(find_joker('No No No No No No No No No No No')) then
			card.ability.chadNum = 1
			sendDebugMessage("Chadley #"..card.ability.chadNum)
			if card.ability.quips.greeting and not card.ability.quips.explain then
				sendDebugMessage("Triggering Chadley Explanation")
				local dialogue = {}
				dialogue[#dialogue + 1] = tableSlot('chad_thanks', 'bm', chad)
				for i = 1, 6 do
					local delay = nil
					if i == 1 then delay = 8 else delay = nil end
					dialogue[#dialogue + 1] = tableSlot('chad_explain'..i, 'bm', delay, chad)
				end
				card:jokerTalk(dialogue, nil, nil, 'chad_explain_finished', chad)
				card.ability.quips.explain = true
			end
		else
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0,
				blocking = false,
				func = function()
					local chadNum = #find_joker('No No No No No No No No No No No')
					sendDebugMessage("Chadley #"..chadNum)
					card.ability.chadNum = chadNum
					return true
				end
			}))
		end
	end
end

function jokerInfo.remove_from_deck(self, card)
	if not G.GAME.Renumbering then
		G.GAME.Renumbering = true
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0,
			blocking = false,
			func = function()
				if find_joker('No No No No No No No No No No No') then
					local sequence = {}
					for i, v in ipairs(find_joker('No No No No No No No No No No No')) do
						sequence[#sequence + 1] = v.Mid.ability.chadNum
					end
					table.sort(sequence)
					for i, num in ipairs(sequence) do
						for _, v in ipairs(find_joker('No No No No No No No No No No No')) do
							if v.Mid.ability.chadNum == num then
								v.Mid.ability.chadNum = i
							end
						end
					end
				end
				G.GAME.Renumbering = false
			end
		}))
	end
end

local testtimer = true
local timer = 1000
function jokerInfo.update(self, card, context)
	if testtimer then
		if timer ~= 0 then
			timer = timer - 1
		end
		if timer == 0 then
			if G.booster_pack then
				send(G.booster_pack)
			end
			timer = 1000
		end
	end
	if csau_enabled['chadSay'] then
		if G.shop_jokers and G.shop_jokers.cards then
			local showman = nil
			for i, v in ipairs(G.shop_jokers.cards) do
				if v.config.center_key then
					if v.config.center_key == 'j_ring_master' then
						showman = "shop"
					end
				end
			end
			if showman then
				G.GAME.chad_showman_detected = showman
			else
				G.GAME.chad_showman_detected = nil
			end
		end
		if card.area then
			if not card.area.config.collection then
				if card.area.config.type ~= "title" and card.area.config.type ~= "joker" then
					if not G.SETTINGS.chad then
						G.SETTINGS.chad = {}
						G.SETTINGS.chad.remember = false
						G:save_settings()
					end
					if not next(find_joker('No No No No No No No No No No No')) and not card.ability.quips.greeting then
						sendDebugMessage("Triggering Chadley Greeting")
						local dialogue = {}
						dialogue[#dialogue + 1] = tableSlot('chad_greeting1', 'tm', chad)
						dialogue[#dialogue + 1] = tableSlot('chad_greeting2', 'tm', chad)
						if card.area.config.type == "shop" then
							dialogue[#dialogue + 1] = tableSlot('chad_greeting3shop1', 'tm', 6, chad)
							dialogue[#dialogue + 1] = tableSlot('chad_greeting3shop2', 'tm', chad)
						elseif card.area.config.type1 == "pack" then
							dialogue[#dialogue + 1] = tableSlot('chad_chad_greeting3pack1', 'tm', chad)
							dialogue[#dialogue + 1] = tableSlot('chad_greeting3pack2', 'tm', chad)
						end
						card:jokerTalk(dialogue, nil, nil, 'chad_greeting_finished', chad)
						card.ability.quips.greeting = true
					end
					if not G.SETTINGS.chad.remember then
						G.SETTINGS.chad.remember = true
						G:save_settings()
					end
				elseif card.area.config.type == "joker" and card.ability.chadNum == 1 then
					if G.GAME.chad_showman_detected and not card.ability.quips.showman then
						sendDebugMessage("Triggering Chadley Showman Dialogue", chad)
						local dialogue = {}
						dialogue[#dialogue + 1] = tableSlot('chad_showman1', 'bm', chad)
						if G.GAME.chad_showman_detected == "shop" then
							dialogue[#dialogue + 1] = tableSlot('chad_showman2_shop', 'bm', chad)
						end
						dialogue[#dialogue + 1] = tableSlot('chad_showman3', 'bm', chad)
						card:jokerTalk(dialogue, nil, nil, 'chad_showman_finished', chad)
						card.ability.quips.showman = true
					end
				end
			end
		end
	end
end

return jokerInfo