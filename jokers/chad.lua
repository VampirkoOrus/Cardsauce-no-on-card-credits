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

local speed = G.SETTINGS.GAMESPEED

local function tableSlot(card, speech_key, bubble_side, end_delay)
	return {card = card or chad, speech_key = speech_key or 'chad_greeting1', bubble_side=bubble_side or 'bm', end_delay=end_delay or nil}
end

local function readSpeed(inputText)
	local wordsPerSecond = 3
	local wordCount = 0
	for _ in string.gmatch(inputText, "%S+") do wordCount = wordCount + 1 end
	local time = math.ceil(wordCount / wordsPerSecond)
	return time
end

local function chadTalk(messages, index, delay, end_flag)
	index = index or 1
	delay = delay or 0.1
	end_flag = end_flag or nil
	local card = messages[index].card or chad
	local speech_key = 'chad_'..messages[index].speech_key or 'chad_greeting1'
	local bubble_side = messages[index].bubble_side or 'bm'
	local end_delay = messages[index].end_delay or nil
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = delay,
		blocking = false,
		func = function()
			local speech_key = speech_key
			local text = G.localization.misc.quips[speech_key]
			local current_mod = #text*2+1 or 5
			if current_mod < 5 then current_mod = 5 end
			local dynDelay
			if end_delay then
				dynDelay = end_delay
			else
				dynDelay = readSpeed(tableToString(text)) + 2
			end
			sendDebugMessage(dynDelay)
			if card.ability.talking then
				sendDebugMessage("talking exists")
				local cancelling = false
				for k, v in pairs(card.ability.talking) do
					if k ~= end_flag and v == true then
						sendDebugMessage("Gotta cancel "..k)
						cancelling = true
						if not card.ability.cancel then card.ability.cancel = {} end
						card.ability.cancel[k] = true
					end
				end
				if cancelling then
					card:vic_remove_speech_bubble()
				end
			else
				card.ability.talking = {}
			end
			card:vic_say_stuff(current_mod, nil, true)
			card:vic_add_speech_bubble(speech_key, bubble_side, nil, {text_alignment = "cm"})
			card.ability.talking[end_flag] = true
			send(card.ability.talking)
			send(card.ability.cancel)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = dynDelay*speed,
				blocking = false,
				func = function()
					card.ability.talking[end_flag] = false
					card:vic_remove_speech_bubble()
					if not card.ability.cancel then card.ability.cancel = {} end
					if messages[index+1] and not card.ability.cancel[end_flag] then
						chadTalk(messages, index+1, 0, end_flag)
					else
						if end_flag and not card.ability.cancel[end_flag] then
							card.ability.quips[end_flag] = true
						end
						if #card.ability.cancel > 0 then
							for k, v in pairs(card.ability.talking) do
								if v == true then
									card.ability.cancel[k] = false
								end
							end
						end
					end
					return true
				end
			}))
			return true
		end
	}))
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
				dialogue[#dialogue + 1] = tableSlot(card, 'thanks', 'bm')
				for i = 1, 6 do
					local delay = nil
					if i == 1 then delay = 8 else delay = nil end
					dialogue[#dialogue + 1] = tableSlot(card, 'explain'..i, 'bm', delay)
				end
				chadTalk(dialogue, nil, nil, 'explain_finished')
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
						dialogue[#dialogue + 1] = tableSlot(card, 'greeting1', 'tm')
						dialogue[#dialogue + 1] = tableSlot(card, 'greeting2', 'tm')
						if card.area.config.type == "shop" then
							dialogue[#dialogue + 1] = tableSlot(card, 'greeting3shop1', 'tm', 6)
							dialogue[#dialogue + 1] = tableSlot(card, 'greeting3shop2', 'tm')
						elseif card.area.config.type1 == "pack" then
							dialogue[#dialogue + 1] = tableSlot(card, 'chad_greeting3pack1', 'tm')
							dialogue[#dialogue + 1] = tableSlot(card, 'chad_greeting3pack2', 'tm')
						end
						chadTalk(dialogue, nil, nil, 'greeting_finished')
						card.ability.quips.greeting = true
					end
					if not G.SETTINGS.chad.remember then
						G.SETTINGS.chad.remember = true
						G:save_settings()
					end
				elseif card.area.config.type == "joker" and card.ability.chadNum == 1 then
					if G.GAME.chad_showman_detected and not card.ability.quips.showman then
						sendDebugMessage("Triggering Chadley Showman Dialogue")
						local dialogue = {}
						dialogue[#dialogue + 1] = tableSlot(card, 'showman1', 'bm')
						if G.GAME.chad_showman_detected == "shop" then
							dialogue[#dialogue + 1] = tableSlot(card, 'showman2_shop', 'bm')
						end
						dialogue[#dialogue + 1] = tableSlot(card, 'showman3', 'bm')
						chadTalk(dialogue, nil, nil, 'showman_finished')
						card.ability.quips.showman = true
					end
				end
			end
		end
	end
end

return jokerInfo