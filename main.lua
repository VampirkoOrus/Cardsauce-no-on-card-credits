--- STEAMODDED HEADER
--- MOD_NAME: Cardsauce
--- MOD_ID: Cardsauce
--- MOD_AUTHOR: [BarrierTrio/Gote]
--- MOD_DESCRIPTION: A set of Jokers based on Vinesauce!
--- BADGE_COLOUR: 32A852
--- DISPLAY_NAME: Cardsauce

local conf_cardsauce = {
	jokersToLoad = {

		'meat',
		'twoface',
		'newjoker',
		'pivot',
		'speen',
		'diaper',
		'roche',
		'pacman',
		'besomeone',
		'disguy',
		'speedjoker',
		'disturbedjoker',
		'chad',
		'emmanuel',
		'reyn',
		'depressedbrother',
		'werewolves',
		'greyjoker',
		'cousinsclub',
		'gnorts',
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
		'quarterdumb'
	},

}

local jokerInfoDefault = {
	name = 'NONE',
	config = nil,
	text = {'text'},
	baseEffect = nil,
	rarity = 1,
	cost = 1,
	canBlueprint = true,
	canEternal = true,
	hasSoul = false,
	--functions
	locDef = nil,
	init = nil,
	calculate = nil,
	tooltip = nil,
	
	update = nil,
	draw = nil
}

local function fillInDefaults(t,d)
	for k,v in pairs(d) do
		if t[k] == nil then t[k] = v end
	end
end


function SMODS.INIT.Cardsauce()
	local mod = SMODS.findModByID('Cardsauce')
	
	sendDebugMessage("AchievementsEnabler Activated!")
  	G.F_NO_ACHIEVEMENTS = false

	Add_Custom_Sound_Global("Cardsauce")
	--register_sound('roche', "", 'RochePlanetCard.wav')
	


	--misc localization stuff
	G.localization.misc.dictionary.ph_armageddon = "Annihilated by Odio"


	G.localization.descriptions.Other["guestartist1"] = {
			name = "Guest Artist",
			text = {
				"{E:1}SagaciousCejai{}"
			},
		}

	G.localization.descriptions.Other["guestartist2"] = {
			name = "Guest Coder",
			text = {
			  "{E:1}DPS2004{}"
			},
	}
	G.localization.descriptions.Other["guestartist3"] = {
		name = "Guest Coder",
		text = {
		  "{E:1}Nether{}"
		},
	}
	G.localization.descriptions.Other["guestartist4"] = {
		name = "Guest Coder",
		text = {
		  "{E:1}Mysthaps{}"
		},
	}
	G.localization.descriptions.Other["guestartist5"] = {
		name = "Voice Acting",
		text = {
		  "{E:1}AmtraxVA{}"
		},
	}
	G.localization.descriptions.Other["guestartist6"] = {
		name = "Guest Artist",
		text = {
		  "{E:1}Cody Savoie{}"
		},
	}
	G.localization.descriptions.Other["guestartist7"] = {
		name = "Guest Coder",
		text = {
		  "{E:1}Numbuh214{}"
		},
	}
	G.localization.descriptions.Other["diapernote"] = {
		name = "Author's Note",
		text = {
		  "I'm not drawing",
		  "this one.",
		  "Fuck you."
		},
	}
	G.localization.descriptions.Other["rogernote"] = {
		name = "Conversion Table",
		text = {
			  "5 {C:attention}fingers{} =",
			  "1 {C:attention}hand{}"
		},
	}
	--fix compatibility with G.GAME.probabilities.normal later
	G.localization.descriptions.Other["wheel2"] = {
		name = "The Wheel of Fortune",
        text = {
            "{C:green}1 in 4{} chance to add",
            "{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
            "{C:dark_edition}Polychrome{} edition",
            "to a random {C:attention}Joker"
        },
	}
	
	
	--lose quip replace

	G.localization.misc.quips['lq_'..1] = {'HUGE waste of', 'brain cells!'}
	G.localization.misc.quips['lq_'..2] = {'Melpert? Melpert!?', 'MELLLLLPERRRRRRRTTTT!!!'}
	G.localization.misc.quips['lq_'..3] = {'"I am better at this', 'game now" -Vinny'}
	G.localization.misc.quips['lq_'..4] = {'Your seed... it was', 'not strong enough...'}
	G.localization.misc.quips['lq_'..5] = {'What do you mean, Chat.', 'WHAT DO YOU MEAN.'}
	G.localization.misc.quips['lq_'..6] = {'AGGA'}
	G.localization.misc.quips['lq_'..7] = {'I\'m watching', 'Northernlion now.'}
	G.localization.misc.quips['lq_'..8] = {'Oh, fuck you, Luigi!'}
	G.localization.misc.quips['lq_'..9] = {'"What a bimbo!"', '-Eiko'}
	G.localization.misc.quips['lq_'..10] = {'Don\'t worry, Johnny', 'will cut this out.', 'Right?'}

	--win quip replace

	G.localization.misc.quips['wq_'..1] = {'WHO\'S THE BIG MEAT', 'NOW, MOTHERFUCKER?'}
	G.localization.misc.quips['wq_'..2] = {'YEAHHHH INJECT THE', 'BALATRO DIRECTLY', 'INTO MY COCKVEIN'}
	G.localization.misc.quips['wq_'..3] = {'Chat... I love', 'this game.'}
	G.localization.misc.quips['wq_'..4] = {'Ah, is that another', 'Pluto? Don\'t mind', 'if I do.'}
	G.localization.misc.quips['wq_'..5] = {'Beaauuuuutiful.', 'Give it up, baby!'}
	G.localization.misc.quips['wq_'..6] = {'You wanna talk about', 'some dedication?'}
	G.localization.misc.quips['wq_'..7] = {'IT\'S BECAUSE OF OSE, J--', 'wait, wrong streamer'}

	--functions that are used by many cards go here.

	G.localization.descriptions.Blind.bl_wall.text = {"THAT'S THE WALL BROTHER"}
	G.localization.descriptions.Blind.bl_final_vessel.text = {"HEY WALL"}

	localizations = {}
	function mod.addLocalization(key,str)
		localizations[key] = str
	end
	
	function mod.getCardPosition(card)
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				return i
			end
		end
		return nil
	end

	
	G.FUNCS.can_discard = function(e)
		if next(find_joker('Grey Joker')) then
			if G.GAME.current_round.discards_left <= 0 or #G.hand.highlighted <= 4 then 
				e.config.colour = G.C.UI.BACKGROUND_INACTIVE
				e.config.button = nil
			else
				e.config.colour = G.C.RED
				e.config.button = 'discard_cards_from_highlighted'
			end
		else
			if G.GAME.current_round.discards_left <= 0 or #G.hand.highlighted <= 0 then 
				e.config.colour = G.C.UI.BACKGROUND_INACTIVE
				e.config.button = nil
			else
				e.config.colour = G.C.RED
				e.config.button = 'discard_cards_from_highlighted'
			end
		end
	end

	local draw_from_deck_to_handref = G.FUNCS.draw_from_deck_to_hand
	function G.FUNCS.draw_from_deck_to_hand(self, e)
    	draw_from_deck_to_handref(self, e)

    	for _, v in ipairs(G.jokers.cards) do
        	if G.STATE == G.STATES.DRAW_TO_HAND and not v.debuff then
            	if v.config.center.key == "j_speedjoker" and G.GAME.current_round.hands_played == v.ability.extra or
            	v.config.center.key == "j_disturbedjoker" and G.GAME.current_round.discards_used == v.ability.extra then
                	draw_card(G.deck, G.hand, 100, 'up', true)
                	v.ability.extra = v.ability.extra + 1
            	end
        	end
    	end
	end

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
			local _next = nil
			for val=0, #hand*2-1 do
			local i = val%#hand + 1
			sendDebugMessage("Card "..i.." is "..hand[i].base.value)
			if #verified > 0 then
				if SMODS.Ranks[verified[#verified].base.value].next[1] == hand[i].base.value then
				sendDebugMessage(hand[i].base.value.." comes after "..hand[(val-1)%#hand + 1].base.value..".")
				table.insert(verified,hand[i])
				skipped = false
				else
				if skip_var and not skipped then
					sendDebugMessage("Skipping because Shortcut.")
					skipped = true
				else
					sendDebugMessage(hand[i].base.value.." does not come after "..hand[(val-1)%#hand + 1].base.value..".")
					verified = {}
					val = val - 1
					skipped = false
				end
				end
			end
			if #verified == 0 then
				sendDebugMessage("Starting new straight.")
				table.insert(verified,hand[i])
				skipped = false
			end
			if #verified == target then
				break
			end
			end
			if #verified < target then return {} end
			return {verified}
		end
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
	
	for i,v in ipairs(conf_cardsauce.jokersToLoad) do
		local jokerInfo = love.filesystem.load(mod.path .. 'jokers/'..v..'.lua')()
		fillInDefaults(jokerInfo,jokerInfoDefault)
		
		local spritePos = {x=0,y=0}
		local soulPos = nil
		if jokerInfo.hasSoul then
			spritePos = {x=1,y=0}
			soulPos = {x=2,y=0}
		end
		
		joker = SMODS.Joker:new(
			jokerInfo.name,
			v,
			jokerInfo.config,
			spritePos,
			{name = jokerInfo.name,text = jokerInfo.text},
			jokerInfo.rarity,
			jokerInfo.cost,
			true,
			true,
			jokerInfo.canBlueprint,
			jokerInfo.canEternal,
			jokerInfo.baseEffect,
			nil,
			soulPos
		)
		
		joker:register()
		
		local jself = SMODS.Jokers['j_'..v]
		
		
		if jokerInfo.locDef then
			jself.loc_def = jokerInfo.locDef
		end
		if jokerInfo.init then
			jself.set_ability = jokerInfo.init
		end
		if jokerInfo.calculate then
			jself.calculate = jokerInfo.calculate
		end
		if jokerInfo.tooltip then
			jself.tooltip = jokerInfo.tooltip
		end
		
		if jokerInfo.update then
			table.insert(jokerUpdates,{name = jokerInfo.name, func = jokerInfo.update})
		end
		if jokerInfo.draw then
			table.insert(jokerDraws,{name = jokerInfo.name, func = jokerInfo.draw})
		end
		
		
		--load sprite
		SMODS.Sprite:new('j_'..v,mod.path,v..'.png',71,95,'asset_atli'):register()
		
	end
	
	--card updates

	local card_updateref = Card.update
	function Card.update(self, dt)
		if G.STAGE == G.STAGES.RUN then
			if self.config.center.key == "j_diaper" then
				self.ability.extra.mult = 0
            	for k, v in pairs(G.playing_cards) do
                	if v:get_id() == 2 then self.ability.extra.mult = self.ability.extra.mult+self.ability.extra.mult_mod end
				end
            end
		end
		card_updateref(self, dt)
	end

	-- SMODS.Spectral:new(name, slug, config, pos, loc_txt, cost, consumeable, discovered, atlas)
	local c_quixotic = SMODS.Spectral:new('Quixotic', 'quixotic', { }, { x = 0, y = 0 }, {
    	name = 'Quixotic',
    	text = { 'Gain an {C:attention}Ethereal Tag' }
	}, 4, true, true, 'quixotic')
	c_quixotic:register()
	local sprite = SMODS.Sprite:new("quixotic", SMODS.findModByID("Cardsauce").path, "quixotic.png", 71, 95, "asset_atli")
	sprite:register()

	function SMODS.Spectrals.c_quixotic.loc_def(center, info_queue)
		info_queue[#info_queue+1] = G.P_TAGS.tag_ethereal
		return {}
	end

	function SMODS.Spectrals.c_quixotic.can_use(card)
		-- stop_use and whatnot are handled by the loader, so you don't need to worry about it
		return true
	end

	function SMODS.Spectrals.c_quixotic.use(card, area, copier)
			G.E_MANAGER:add_event(Event({
				func = (function()
					add_tag(Tag('tag_ethereal'))
					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
					play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
					return true
				end)
			}))
	end

	--updates
	local card_updateRef = Card.update
	function Card.update(self, dt)
		if G.STAGE == G.STAGES.RUN then
			for i,v in ipairs(jokerUpdates) do
				if self.ability.name == v.name then
					v.func(self,dt)
				end
			end
		end
		card_updateRef(self,dt)
	end
	
	--draws
	local card_drawRef = Card.draw
	function Card.draw(self, layer)
		for i,v in ipairs(jokerDraws) do
			if self.ability.name == v.name then
				v.func(self,dt)
			end
		end
		card_drawRef(self,layer)
	end
	
	for k,v in pairs(localizations) do
		G.localization.misc.dictionary[k] = v
	end
    init_localization()
	
	



end