--- STEAMODDED HEADER
--- MOD_NAME: Cardsauce
--- MOD_ID: Cardsauce
--- MOD_AUTHOR: [BarrierTrio/Gote]
--- MOD_DESCRIPTION: A set of Jokers based on Vinesauce!
--- BADGE_COLOUR: 32A852
--- DISPLAY_NAME: Cardsauce
--- PREFIX: csau

local mod_path = SMODS.current_mod.path

local conf_cardsauce = {
	jokersToLoad = {

		'meat',
		'twoface',
		'newjoker',
		'pivot',
		--'speen',
		'diaper',
		'roche',
		'pacman',
		'besomeone',
		'speedjoker',
		'disturbedjoker',
		'disguy',
		'chad',
		'emmanuel',
		'reyn',
		'depressedbrother',
		'werewolves',
		'greyjoker',
		'cousinsclub',
		--'gnorts',
		'roger',
		'shrimp',
		'veryexpensivejoker',
		'sohappy',
		'maskedjoker',
		'thisiscrack',
		'charity',
		'pepsecret',
		'odio0',
		'greenneedle',
		'fisheye',
		'code',
		'anotherlight',
		'deathcard',
		'hell',
		'vincenzo',
		'quarterdumb',
		'wingsoftime',
		'miracle',
		'garbagehand',
		'supper'
	},
}
	
-- sendDebugMessage("AchievementsEnabler Activated!")
-- G.F_NO_ACHIEVEMENTS = false

-- unused
function getCardPosition(card)
	for i = 1, #G.jokers.cards do
		if G.jokers.cards[i] == card then
			return i
		end
	end
	return nil
end

local can_discardref = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
	if next(SMODS.find_card('j_csau_greyjoker')) then
		if G.GAME.current_round.discards_left <= 0 or #G.hand.highlighted <= 4 then
			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			e.config.button = nil
		else
			e.config.colour = G.C.RED
			e.config.button = 'discard_cards_from_highlighted'
		end
	else
		can_discardref(e)
	end
end

local draw_from_deck_to_handref = G.FUNCS.draw_from_deck_to_hand
function G.FUNCS.draw_from_deck_to_hand(self, e)
    draw_from_deck_to_handref(self, e)
    for _, v in ipairs(G.jokers.cards) do
    	if G.STATE == G.STATES.DRAW_TO_HAND and not v.debuff then
        	if v.config.center.key == "j_csau_speedjoker" and G.GAME.current_round.hands_played == v.ability.extra or
        	v.config.center.key == "j_csau_disturbedjoker" and G.GAME.current_round.discards_used == v.ability.extra then
               	draw_card(G.deck, G.hand, 100, 'up', true)
            	v.ability.extra = v.ability.extra + 1
        	end
    	end
    end
end


-- these two functions are *very* bad since they override base functions. need lovely patch
	local get_straight_ref = get_straight
	function get_straight(hand)
	local base = get_straight_ref(hand)
	local results = {}
	local vals = {}
	local verified = {}
	local can_loop = next(find_joker('Rekoj Gnorts'))
	local target = next(find_joker('Four Fingers')) and 4 or 5
	local skip_var = next(find_joker('Shortcut'))
	local skipped = false
	if not(can_loop) or #hand < target then
		return base
	else
		table.sort(hand, function(a,b) return a:get_id() < b:get_id() end)
		local ranks = {}
		local _next = nil
		local val = 0
		for k, v in pairs(G.P_CARDS) do

		if (ranks[v.pos.x+1] == nil) then
			ranks[v.pos.x+1] = v.value
		end
		end

		while val < #hand*2 do
		local i = val%#hand + 1
		local id = hand[i]:get_id()-1
		val = val + 1
		if _next == nil then

			table.insert(results,hand[i])
			_next = ranks[id%#ranks+1]
			skipped = false
		else
			if (ranks[id] == _next) then

			table.insert(results,hand[i])
			_next = ranks[id%#ranks+1]
			skipped = false
			elseif skip_var and not skipped then

			_next = ranks[id%#ranks+1]
			skipped = true
			else

			_next = nil
			val = val-1
			results = {}
			skipped = false
			end
		end
		if (#results == target) then
			table.sort(hand, function(a,b) return a.T.x < b.T.x end)
			table.sort(results, function(a,b) return a.T.x < b.T.x end)

			return {results}
		elseif _next ~= nil then

		end
		end
	end

	return {}
	end

	G.FUNCS.evaluate_round = function()
		local pitch = 0.95
		local dollars = 0
	
		if G.GAME.chips - G.GAME.blind.chips >= 0 then
			add_round_eval_row({dollars = G.GAME.blind.dollars, name='blind1', pitch = pitch})
			pitch = pitch + 0.06
			dollars = dollars + G.GAME.blind.dollars
		else
			add_round_eval_row({dollars = 0, name='blind1', pitch = pitch, saved = true})
			pitch = pitch + 0.06
		end
	
		G.E_MANAGER:add_event(Event({
			trigger = 'before',
			delay = 1.3*math.min(G.GAME.blind.dollars+2, 7)/2*0.15 + 0.5,
			func = function()
			  G.GAME.blind:defeat()
			  return true
			end
		  }))
		delay(0.2)
		G.E_MANAGER:add_event(Event({
			func = function()
				ease_background_colour_blind(G.STATES.ROUND_EVAL, '')
				return true
			end
		}))
		G.GAME.selected_back:trigger_effect({context = 'eval'})
	
		if G.GAME.current_round.hands_left > 0 and not G.GAME.modifiers.no_extra_hand_money then
			add_round_eval_row({dollars = G.GAME.current_round.hands_left*(G.GAME.modifiers.money_per_hand or 1), disp = G.GAME.current_round.hands_left, bonus = true, name='hands', pitch = pitch})
			pitch = pitch + 0.06
			dollars = dollars + G.GAME.current_round.hands_left*(G.GAME.modifiers.money_per_hand or 1)
		end
		if G.GAME.current_round.discards_left > 0 and G.GAME.modifiers.money_per_discard then
			add_round_eval_row({dollars = G.GAME.current_round.discards_left*(G.GAME.modifiers.money_per_discard), disp = G.GAME.current_round.discards_left, bonus = true, name='discards', pitch = pitch})
			pitch = pitch + 0.06
			dollars = dollars +  G.GAME.current_round.discards_left*(G.GAME.modifiers.money_per_discard)
		end
		for i = 1, #G.jokers.cards do
			local ret = G.jokers.cards[i]:calculate_dollar_bonus()
			if ret then
				add_round_eval_row({dollars = ret, bonus = true, name='joker'..i, pitch = pitch, card = G.jokers.cards[i]})
				pitch = pitch + 0.06
				dollars = dollars + ret
			end
		end
		for i = 1, #G.GAME.tags do
			local ret = G.GAME.tags[i]:apply_to_run({type = 'eval'})
			if ret then
				add_round_eval_row({dollars = ret.dollars, bonus = true, name='tag'..i, pitch = pitch, condition = ret.condition, pos = ret.pos, tag = ret.tag})
				pitch = pitch + 0.06
				dollars = dollars + ret.dollars
			end
		end
		if G.GAME.dollars >= 5 and not G.GAME.modifiers.no_interest and not next(find_joker('Vinesauce is HOPE')) then
			add_round_eval_row({bonus = true, name='interest', pitch = pitch, dollars = G.GAME.interest_amount*math.min(math.floor(G.GAME.dollars/5), G.GAME.interest_cap/5)})
			pitch = pitch + 0.06
			if not G.GAME.seeded and not G.GAME.challenge then
				if G.GAME.interest_amount*math.min(math.floor(G.GAME.dollars/5), G.GAME.interest_cap/5) == G.GAME.interest_amount*G.GAME.interest_cap/5 then 
					G.PROFILES[G.SETTINGS.profile].career_stats.c_round_interest_cap_streak = G.PROFILES[G.SETTINGS.profile].career_stats.c_round_interest_cap_streak + 1
				else
					G.PROFILES[G.SETTINGS.profile].career_stats.c_round_interest_cap_streak = 0
				end
			end
			check_for_unlock({type = 'interest_streak'})
			dollars = dollars + G.GAME.interest_amount*math.min(math.floor(G.GAME.dollars/5), G.GAME.interest_cap/5)
		end
	
		pitch = pitch + 0.06
	
		add_round_eval_row({name = 'bottom', dollars = dollars})
	end
	
local jokerUpdates = {}
local jokerDraws = {}

for i, v in ipairs(conf_cardsauce.jokersToLoad) do
	local jokerInfo = SMODS.load_file("jokers/" .. v .. ".lua")()

	jokerInfo.key = v
	jokerInfo.atlas = v
	jokerInfo.pos = { x = 0, y = 0 }
	if jokerInfo.hasSoul then
		jokerInfo.pos = { x = 1, y = 0 }
		jokerInfo.soul_pos = { x = 2, y = 0 }
	end

	local joker = SMODS.Joker(jokerInfo)
	for k_, v_ in pairs(joker) do
		if type(v_) == 'function' then
			joker[k_] = jokerInfo[k_]
		end
	end

	--load sprite
	SMODS.Atlas({ key = v, path ="jokers/" .. v .. ".png", px = 71, py = 95 })
end

--card updates
local card_updateref = Card.update
function Card.update(self, dt)
	if G.STAGE == G.STAGES.RUN then
		if self.config.center.key == "j_diaper" then
			self.ability.extra.mult = 0
			for k, v in pairs(G.playing_cards) do
				if v:get_id() == 2 then self.ability.extra.mult = self.ability.extra.mult + self.ability.extra.mult_mod end
			end
		end
	end
	card_updateref(self, dt)
end

SMODS.Atlas({ key = "quixotic", path = "consumables/quixotic.png", px = 71, py = 95 })
local quixotic = SMODS.Consumable({ key = "quixotic", cost = 4, set = "Spectral", discovered = false, alerted = true, atlas = "quixotic" })

function quixotic.loc_vars(self, info_queue, card)
	info_queue[#info_queue + 1] = G.P_TAGS.tag_ethereal
	return {}
end

function quixotic.use(self, card, area, copier)
	G.E_MANAGER:add_event(Event({
		func = (function()
			add_tag(Tag('tag_ethereal'))
			play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
			play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
			return true
		end)
	}))
end

--draws
local card_drawRef = Card.draw
function Card.draw(self, layer)
	local obj = self.config.center
	if obj.draw and type(obj.draw) == 'function' then
		obj:draw(self, layer)
	end
	card_drawRef(self, layer)
end

for suit, color in pairs(G.C.SUITS) do
	local c
	if suit == "Hearts" then c = HEX("e14e62")
	elseif suit == "Diamonds" then c = HEX("3c56a4")
	elseif suit == "Clubs" then c = HEX("4dac84")
	elseif suit == "Spades" then c = HEX("8d619a")
	end
	SMODS.Suits[suit].keep_base_colours = false
	SMODS.Suits[suit].lc_colour = c
	SMODS.Suits[suit].hc_colour = c
	if G.VANILLA_COLLABS then
		G.VANILLA_COLLABS.lc_colours[suit] = c
		G.VANILLA_COLLABS.hc_colours[suit] = c
	end
	G.C.SO_1[suit] = c
	G.C.SO_2[suit] = c
end

-- Base Deck Textures
SMODS.Atlas {
	key = "cards_1",
	path = "BaseDeck.png",
	px = 71,
	py = 95,
	prefix_config = { key = false }
}

-- Base Deck UI Assets
for i = 1, 2 do
	SMODS.Atlas {
		key = "ui_"..i,
		path = "ui_assets.png",
		px = 18,
		py = 18,
		prefix_config = { key = false }
	}
end

-- Title Screen Logo Texture
SMODS.Atlas {
	key = "balatro",
	path = "Logo.png",
	px = 333,
	py = 216,
	prefix_config = { key = false }
}

-- Mod Icon in Mods tab
SMODS.Atlas({
	key = "modicon",
	path = "icon.png",
	px = 32,
	py = 32
}):register()

-- Credits Tab in Mods
SMODS.current_mod.credits_tab = function()
	local text_scale = 0.9
	chosen = true
	return {n=G.UIT.ROOT, config={align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.1, emboss = 0.05, minh = 6, minw = 10}, nodes={
		{n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
			{n=G.UIT.R, config={align = "tm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
				{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
					{n=G.UIT.T, config={text = localize('vs_credits1'), scale = text_scale*0.6, colour = G.C.GOLD, shadow = true}},
				}},
				{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
					{n=G.UIT.C, config={align = "cm", padding = 0.05}, nodes={
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = 'BarrierTrio', scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
						}},
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = 'Keku', scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
						}},
					}},
				}},
			}},
			{n=G.UIT.R, config={align = "tm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
				{n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
					{n=G.UIT.T, config={text = localize('vs_credits2'), scale = text_scale*0.6, colour = G.C.RED, shadow = true}},
				}},
				{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
					{n=G.UIT.C, config={align = "cm", padding = 0.05}, nodes={
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = 'BarrierTrio', scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
						}},
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = 'SagaciousCejai', scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
						}},
					}},
				}},
			}},
		}},
		{n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
			{n=G.UIT.R, config={align = "tm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
				{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
					{n=G.UIT.T, config={text = localize('vs_credits3'), scale = text_scale*0.6, colour = G.C.ORANGE, shadow = true}},
				}},
				{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
					{n=G.UIT.C, config={align = "cm", padding = 0.05}, nodes={
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = 'DPS2004', scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
						}},
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = 'Nether', scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
						}},
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = 'Mysthaps', scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
						}},
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = 'Aurelius7309', scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
						}},
					}},
				}},
			}},
			{n=G.UIT.R, config={align = "tm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
				{n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
					{n=G.UIT.T, config={text = localize('vs_credits4'), scale = text_scale*0.6, colour = G.C.PURPLE, shadow = true}},
				}},
				{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
					{n=G.UIT.C, config={align = "cm", padding = 0.05}, nodes={
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = 'Infarctus', scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
						}},
					}},
				}},
			}},
			{n=G.UIT.R, config={align = "tm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
				{n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
					{n=G.UIT.T, config={text = localize('vs_credits5'), scale = text_scale*0.6, colour = G.C.GREEN, shadow = true}},
				}},
				{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
					{n=G.UIT.C, config={align = "cm", padding = 0.05}, nodes={
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = 'Lyman (from JankJonklers)', scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
						}},
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = 'Akai (from BalatroStuck)', scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
						}},
					}},
				}},
			}},
		}},
	}}
end
