--- STEAMODDED HEADER
--- MOD_NAME: Cardsauce
--- MOD_ID: Cardsauce
--- MOD_AUTHOR: [BarrierTrio/Gote & Keku]
--- MOD_DESCRIPTION: A Vinesauce-themed expansion for Balatro, made in collaboration with the Balatro Discord and Vinesauce communities!
--- BADGE_COLOUR: 32A852
--- DISPLAY_NAME: Cardsauce
--- PREFIX: csau
--- VERSION: 1.3.4
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-1406b]

SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
	cardareas = {
		deck = true,
		discard = true,
	},
}

local mod = SMODS.current_mod
local mod_path = SMODS.current_mod.path
local usable_path = mod_path:match("Mods/[^/]+")
local path_pattern_replace = usable_path:gsub("(%W)","%%%1")  -- shoot me in the foot, why doesn't lua just have a str.replace
csau_config = SMODS.current_mod.config
csau_enabled = copy_table(csau_config)

local hook_list = {
	"card",
	"UI_definitions",
	"misc_functions"
}

function recursiveEnumerate(folder)
	local fileTree = ""
	for _, file in ipairs(love.filesystem.getDirectoryItems(folder)) do
		local path = folder .. "/" .. file
		local info = love.filesystem.getInfo(path)
		fileTree = fileTree .. "\n" .. path .. (info.type == "directory" and " (DIR)" or "")
		if info.type == "directory" then
			fileTree = fileTree .. recursiveEnumerate(path)
		end
	end
	return fileTree
end

local skin_files = {}
for s in recursiveEnumerate(usable_path .. "/assets/1x/skins/"):gmatch("[^\r\n]+") do
	skin_files[#skin_files + 1] = s:gsub(path_pattern_replace .. "/assets/1x/skins/", "")
end

local deck_skins = {}
for _, file in ipairs(skin_files) do
	deck_skins[#deck_skins + 1] = file:sub(2, -5)
end

local collab_files = {}
for s in recursiveEnumerate(usable_path .. "/assets/1x/collabs/"):gmatch("[^\r\n]+") do
	if s:match("%.png$") then
		collab_files[#collab_files + 1] = s:gsub(path_pattern_replace .. "/assets/1x/collabs/", "")
	end
end

local collab_skins = {}
for _, file in ipairs(collab_files) do
	collab_skins[#collab_skins + 1] = file:sub(2, -5)
end

for _, hook in ipairs(hook_list) do
	local init, error = NFS.load(SMODS.current_mod.path .. "hooks/" .. hook ..".lua")
	if error then sendErrorMessage("[Cardsauce] Failed to load "..hook.." with error "..error) else
		local data = init()
		sendDebugMessage("[Cardsauce] Loaded hook: " .. hook)
	end
end

local conf_cardsauce = {
	jokersToLoad = {
		-- Common
		'twoface',
		'newjoker',
		'depressedbrother',
		'pivot',
		'fisheye',
		'diaper',
		'speen',
		'pacman',
		'besomeone',
		'disguy',
		'roche',
		'reyn',
		'emmanuel',
		'gnorts',
		'chad',

		'purple',
		'garbagehand',
		-- Uncommon
		'meat',
		'greyjoker',
		'veryexpensivejoker',
		'roger',
		'cousinsclub',
		'anotherlight',
		'sohappy',
		'code',
		'deathcard',
		'maskedjoker',
		'dontmind',
		'kerosene',
		'businesstrading',

		'red',
		'fate',
		'miracle',
		'chromedup',
		-- Rare
		'thisiscrack',
		'werewolves',
		'hell',
		'odio',
		-- Common (Locked)
		'speedjoker',
		'disturbedjoker',

		-- Uncommon (Locked)
		'shrimp',
		'muppet',
		-- Rare (Locked)
		'charity',
		'supper',
		'pepsecret',

		'greenneedle',
		'wingsoftime',
		'kings',
		-- Legendary
		'vincenzo',
		'quarterdumb',

		-- Update 1.2
		'fantabulous',
		'grand',
		'ten',
		'beginners',
		'joeycastle',
		'voice',
		'rotten',
		'rapture',
		'villains',
		'killjester',

		-- Update 1.3
		'crudeoil',
		'grannycream',
		'bjbros',
		'koffing',
		'drippy',
		'sts',
		'meteor',
		'dud',
		'frich',
		'bunji',
	},
	consumablesToLoad = {
		--Spectral
		'quixotic',
		'protojoker',
	},
	vhsToLoad = {
	},
	standsToLoad = {
	},
	packsToLoad = {
	},
	decksToLoad = {
		'vine',
	},
	tagsToLoad = {
	},
	vouchersToLoad = {
	},
	challengesToLoad = {
		'tucker',
	},
	blindsToLoad = {
		'hog',
		'tray',
		'vod',
		'finger',
		'mochamike',
	},
	trophiesToLoad = {}
}

local twoPointO = true

if twoPointO then
	conf_cardsauce.vhsToLoad = {
		'blackspine',
		'doubledown',
		'topslots',
		'donbeveridge',
		'tbone',
		'remlezar',
		'calibighunks',
		'twistedpair',
		'suburbansasquatch',
	}
	conf_cardsauce.standsToLoad = {
		'starplatinum',
		'diosworld',
		'tohth',
		'crazydiamond',
		'moodyblues',
		'metallica',
		'd4c',
	}
	conf_cardsauce.tagsToLoad = {
		'spirit',
	}
	conf_cardsauce.vouchersToLoad = {
		'scavenger',
		'raffle',
		'ff',
	}
	local consumables = {
		'arrow',
		'lutetia',
		'varuna',
	}
	for i, k in ipairs(consumables) do
		conf_cardsauce.consumablesToLoad[#conf_cardsauce.consumablesToLoad+1] = k
	end
	local jokers = {
		--Common
		'frens',
		'powers',
		'memehouse',
		'nutbuster',
		'chips',
		'bonzi',
		'bbq',
		'lidl',
		'toeofsatan',
		'superghostbusters',
		'facade',
		'vomitblast',
		'itsmeaustin',
		'bootleg',
		'bald',
		'protogent',
		--Uncommon
		'scam',
		'monkey',
		'skeletor',
		'agga',
		'triptoamerica',
		'passport',
		'fireworks',
		'sprunk',
		'flusher',
		'vinewrestle',
		'plaguewalker',
		'duane',
		'april',
		'mrkill',
		'itsafeature',
		'bulk',
		'mug',
		'blackjack',
		'bsi',
		--Rare
		'tetris',

		-- Jojo Jokers
		'jokerdrive',
		'no2joker',
		'sotw',
	}
	for i, k in ipairs(jokers) do
		conf_cardsauce.jokersToLoad[#conf_cardsauce.jokersToLoad+1] = k
	end
	conf_cardsauce.decksToLoad[#conf_cardsauce.decksToLoad+1] = 'varg'
	conf_cardsauce.decksToLoad[#conf_cardsauce.decksToLoad+1] = 'wheel'
	conf_cardsauce.decksToLoad[#conf_cardsauce.decksToLoad+1] = 'disc'
	conf_cardsauce.packsToLoad = {
		'analog1',
		'analog2',
		'analog3',
		'analog4',
	}
end

local start = Game.start_run
function Game:start_run(args)
	start(self, args)
	if G.GAME.selected_back.effect.center.key == "b_csau_disc" then
		G.GAME.unlimited_stands = true
	end
	G.GAME.max_stands = G.GAME.modifiers.max_stands or 1
end

G.csau_collab_credits = {
	-- Vine
	csau_wildcards = {
		King = {key = "guestartist23", set = "Other"}, --fradavovan
		Queen = {key = "guestartist26", set = "Other"}, --CheesyDraws
		Jack = {key = "guestartist26", set = "Other"}, --CheesyDraws
	},
	csau_mascots = {
		King = {key = "guestartist26", set = "Other"}, --CheesyDraws
		Queen = {key = "guestartist27", set = "Other"}, --Greeeg
		Jack = {key = "guestartist12", set = "Other"}, --WhimsyCherry
	},
	csau_classics = {
		King = {key = "guestartist10", set = "Other"}, --Arthur Effgus
		Queen = {key = "guestartist10", set = "Other"}, --Arthur Effgus
		Jack = {key = "guestartist10", set = "Other"}, --Arthur Effgus
	},
	csau_confidants = {
		King = {key = "guestartist17", set = "Other"}, --Jazz_Jen
		Queen = {key = "guestartist17", set = "Other"}, --Jazz_Jen
		Jack = {key = "guestartist17", set = "Other"}, --Jazz_Jen
	},
	-- Varg
	csau_americans = {
		King = {key = "guestartist21", set = "Other"}, --Burdrehnar
		Queen = {key = "guestartist16", set = "Other"}, --GuffNFluff
		Jack = nil,
	},
	csau_voices = {
		King = {key = "guestartist13", set = "Other"}, --Lyzerus
		Queen = {key = "guestartist22", set = "Other"}, --Crisppyboat
		Jack = {key = "guestartist13", set = "Other"}, --Lyzerus
	},
	csau_duendes = {
		King = nil,
		Queen = {key = "guestartist1", set = "Other"}, --SagaciousCejai
		Jack = nil,
	},
	csau_powerful = {
		King = nil,
		Queen =nil,
		Jack = {key = "guestartist1", set = "Other"}, --SagaciousCejai
	},
	-- Mike
	csau_poops = {
		King = {key = "twoartists0", set = "Other", plural = true}, --Gote + SagaciousCejai
		Queen = {key = "guestartist0", set = "Other"}, --Gote
		Jack = {key = "guestartist1", set = "Other"}, --SagaciousCejai
	},
	csau_ocs = {
		King = nil,
		Queen = {key = "guestartist16", set = "Other"}, --GuffNFluff
		Jack = nil,
	},
}

upc_ref = G.FUNCS.update_collab_cards
G.FUNCS.update_collab_cards = function(key, suit, silent)
	upc_ref(key, suit, silent)
	if type(key) == "number" then
		key = G.COLLABS.options[suit][key]
	end
	if G.csau_collab_credits[key] then
		for i, card in ipairs(G.cdds_cards.cards) do
			if G.csau_collab_credits[key][card.config.card.value] then
				card.no_ui = false
				card.csau_collab_credit = G.csau_collab_credits[key][card.config.card.value]
			else
				card.no_ui = true
				card.csau_collab_credit = nil
			end
		end
	else
		for i, card in ipairs(G.cdds_cards.cards) do
			card.no_ui = true
			card.csau_collab_credit = nil
		end
	end
end

G.FUNCS.csau_set_big_sprites = function(self, card)
	if card.config.center.discovered or card.bypass_discovery_center then
		card.children.center.scale = {x=self.width,y=self.height}
		card.children.center.scale_mag = math.min(self.width/card.children.center.T.w,self.height/card.children.center.T.h)
		card.children.center:reset()

		if self.hasSoul then
			card.children.floating_sprite.scale = {x=self.width,y=self.height}
			card.children.floating_sprite.scale_mag = math.min(self.width/card.children.floating_sprite.T.w,self.height/card.children.floating_sprite.T.h)
			card.children.floating_sprite:reset()
		end
	end
end

G.FUNCS.csau_generate_detail_desc = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table, key)
	key = key or card.config.center.key
	if card.config.center.discovered then
		-- If statement makes it so that this function doesnt activate in the "Joker Unlocked" UI and cause 'Not Discovered' to be stuck in the corner
		full_UI_table.name = localize{type = 'name', key = key, set = self.set, name_nodes = {}, vars = specific_vars or {}}
	end
	if mod.config['detailedDescs'] and G.localization.descriptions.Joker[key.."_detailed"] then
		localize{type = 'descriptions', key = key.."_detailed", set = self.set, nodes = desc_nodes, vars = self.loc_vars and self.loc_vars(self, info_queue, card).vars or {}}
	else
		localize{type = 'descriptions', key = key, set = self.set, nodes = desc_nodes, vars = self.loc_vars and self.loc_vars(self, info_queue, card).vars or {}}
	end
end

G.foodjokers = {
	'j_gros_michel',
	'j_ice_cream',
	'j_cavendish',
	'j_turtle_bean',
	'j_popcorn',
	'j_ramen',
	'j_selzer',
	'j_diet_cola',
	'j_csau_meat',
	'j_csau_fantabulous',
	'j_csau_crudeoil',
	'j_csau_grannycream',
	'j_csau_toeofsatan',
}

function G.FUNCS.is_food(key)
	for i, k in ipairs(G.foodjokers) do
		if k == key then
			return true
		end
	end
	return false
end

G.loadTrophies = true
if csau_enabled['enableTrophies'] then
	for s in recursiveEnumerate(usable_path .. "/achievements/"):gmatch("[^\r\n]+") do
		conf_cardsauce.trophiesToLoad[#conf_cardsauce.trophiesToLoad + 1] = s:gsub(path_pattern_replace .. "/achievements/", "")
	end
else
	G.loadTrophies = false
end

-- Talisman compat
to_big = to_big or function(num)
	return num
end

-- unused
function getCardPosition(card)
	for i = 1, #G.jokers.cards do
		if G.jokers.cards[i] == card then
			return i
		end
	end
	return nil
end

function containsKey(table, key)
	return table[key] ~= nil
end

function starts_with(str, start)
	return string.sub(str, 1, #start) == start
end

function ends_with(str, ending)
	return string.sub(str, -#ending) == ending
end

function send(message, level)
	level = level or 'debug'
	if level == 'debug' then
		if type(message) == 'table' then
			sendDebugMessage(tprint(message))
		else
			sendDebugMessage(message)
		end
	elseif level == 'info' then
		if type(message) == 'table' then
			sendInfoMessage(tprint(message))
		else
			sendInfoMessage(message)
		end
	elseif level == 'error' then
		if type(message) == 'table' then
			sendErrorMessage(tprint(message))
		else
			sendErrorMessage(message)
		end
	end
end

if Cryptid and Cryptid.food then
	local food_keys = {
	}
	for i, v in ipairs(food_keys) do
		table.insert(Cryptid.food)
	end
end

function containsString(str, substring)
	local lowerStr = string.lower(str)
	local lowerSubstring = string.lower(substring)
	return string.find(lowerStr, lowerSubstring, 1, true) ~= nil
end

function table.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

local draw_from_deck_to_handref = G.FUNCS.draw_from_deck_to_hand
function G.FUNCS.draw_from_deck_to_hand(self, e)
	draw_from_deck_to_handref(self, e)
	if G.GAME.csau_dj_drawextra then
		draw_card(G.deck, G.hand, 100, 'up', true)
		G.GAME.csau_dj_drawextra = false
	end
	if G.GAME.csau_sj_drawextra then
		draw_card(G.deck, G.hand, 100, 'up', true)
		G.GAME.csau_sj_drawextra = false
	end
	if G.GAME.csau_stss_drawthreeextra and G.GAME.csau_stss_drawthreeextra > 0 then
		for i = 1, G.GAME.csau_stss_drawthreeextra do
			for i = 1, 3 do
				draw_card(G.deck, G.hand, 100, 'up', true)
			end
			G.GAME.csau_stss_drawthreeextra = G.GAME.csau_stss_drawthreeextra - 1
		end
	end
end

function SMODS.current_mod.reset_game_globals(run_start)
	G.GAME.current_round.choicevoice = { suit = 'Clubs' }
	local valid_choicevoice_cards = {}
	for _, v in ipairs(G.playing_cards) do
		if not SMODS.has_no_suit(v) then
			valid_choicevoice_cards[#valid_choicevoice_cards+1] = v
		end
	end
	if valid_choicevoice_cards[1] then
		local randCard = pseudorandom_element(valid_choicevoice_cards, pseudoseed('marrriooOOO'..G.GAME.round_resets.ante))
		G.GAME.current_round.choicevoice.suit = randCard.base.suit
		G.GAME.current_round.choicevoice.rank = randCard.base.value
		G.GAME.current_round.choicevoice.id = randCard.base.id
	end
	G.GAME.current_round.joeycastle = { suit = 'Clubs' }
	local valid_joeycastle_cards = {}
	for _, v in ipairs(G.playing_cards) do
		if not SMODS.has_no_suit(v) then
			valid_joeycastle_cards[#valid_joeycastle_cards+1] = v
		end
	end
	if valid_joeycastle_cards[1] then
		local randCard = pseudorandom_element(valid_joeycastle_cards, pseudoseed('fent'..G.GAME.round_resets.ante))
		G.GAME.current_round.joeycastle.suit = randCard.base.suit
	end
	local randCard = pseudorandom_element(G.playing_cards, pseudoseed('DUANE'..G.GAME.round_resets.ante))
	G.GAME.current_round.duane_suit = randCard.base.suit
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
		G.GAME.gnortstraight = false
		return base
	else
		local hand_ref = {}
		for k, v in pairs(hand) do
			table.insert(hand_ref, v)
		end
		table.sort(hand_ref, function(a,b) return a:get_id() < b:get_id() end)
		local ranks = {}
		local _next = nil
		local val = 0
		for k, v in pairs(G.P_CARDS) do
			if (ranks[v.pos.x+1] == nil) then
				ranks[v.pos.x+1] = v.value
			end
		end
		while val < #hand_ref*2 do
			local i = val%#hand_ref + 1
			local id = hand_ref[i]:get_id()-1
			val = val + 1
			if _next == nil then
				table.insert(results,hand_ref[i])
				_next = ranks[id%#ranks+1]
				skipped = false
			else
				if (ranks[id] == _next) then

					table.insert(results,hand_ref[i])
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

-- Based on code from Ortalab
G.FUNCS.transform_card = function(card, to_key)
	local new_card = G.P_CENTERS[to_key]
	card.children.center = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[new_card.atlas], new_card.pos)
	card.children.center.states.hover = card.states.hover
	card.children.center.states.click = card.states.click
	card.children.center.states.drag = card.states.drag
	card.children.center.states.collide.can = false
	card.children.center:set_role({major = card, role_type = 'Glued', draw_major = card})
	card:set_ability(new_card)
	card:set_cost()
	if new_card.soul_pos then
		card.children.floating_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[new_card.atlas], new_card.soul_pos)
		card.children.floating_sprite.role.draw_major = card
		card.children.floating_sprite.states.hover.can = false
		card.children.floating_sprite.states.click.can = false
	end
	if not card.edition then
		card:juice_up()
		play_sound('generic1')
	else
		card:juice_up(1, 0.5)
		if card.edition.foil then play_sound('foil1', 1.2, 0.4) end
		if card.edition.holo then play_sound('holo1', 1.2*1.58, 0.4) end
		if card.edition.polychrome then play_sound('polychrome1', 1.2, 0.7) end
		if card.edition.negative then play_sound('negative', 1.5, 0.4) end
	end
end

function get_stand_overlay(card)
	return mod[card.config.center.key..'_overlay']
end

local G_FUNCS_can_buy_and_use_ref=G.FUNCS.can_buy_and_use
G.FUNCS.can_buy_and_use = function(e)
	G_FUNCS_can_buy_and_use_ref(e)
	if e.config.ref_table.ability.set=='VHS' then
		e.UIBox.states.visible = false
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.C.MUG = HEX('db9a4d')
function csau_loc_colors()
	G.ARGS.LOC_COLOURS['mug'] = G.C.MUG
end

-- Modified Code from Malverk
local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local use = nil
	if card.ability.set == "VHS" then
		if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then --Add a use button
			local spacer = {n=G.UIT.R, config={minh = 0.8}}
			local pull = {n=G.UIT.R, config={minh = 0.55}}
			use = {n=G.UIT.R, config={align = 'cm'}, nodes={
				{n=G.UIT.C, config={align = "cm"}, nodes={
					{n=G.UIT.C, config={align = "bm", maxw = G.CARD_W * 0.65, shadow = true, padding = 0.1, r=0.08, minw = 0.5 * G.CARD_W, minh = 0.8, hover = true, colour = G.C.RED, button = "use_card", func = "can_reserve_card", ref_table = card, activate = true}, nodes={
						{n=G.UIT.T, config={text = localize('b_activate'), colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
					}}
				}}
			}}
			if not card.config.center.unpauseable then
				pull = {n=G.UIT.R, config={align = 'cr', minw = 1.7*G.CARD_W}, nodes={
					{n=G.UIT.R, config={minh = 0.65}},
					{n=G.UIT.R, nodes = {
						{n=G.UIT.C, config={minw = G.CARD_W, minh = 0.8, colour = G.C.IMPORTANT, r = 0.1, align = 'cr', shadow = true, padding = 0.1, hover = true, button = "use_card", func = "can_reserve_card", ref_table = card, pull = true}, nodes = {
							{n=G.UIT.T, config={text = localize('b_pull'), colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
						}}
					}}
				}}
			end
			spacer = {n=G.UIT.R, config={minh = 0.7}}
			local t = {n=G.UIT.ROOT, config = {align = 'cm', padding = 0, colour = G.C.CLEAR}, nodes={
				{n=G.UIT.C, config={align = 'cm'}, nodes={
					pull,
					spacer,
					use
				}},
			}}
			return t
		end
	end
	if card.ability.set == "Stand" then
		local sell = {n=G.UIT.C, config={align = "cr"}, nodes={
			{n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card'}, nodes={
				{n=G.UIT.B, config = {w=0.1,h=0.6}},
				{n=G.UIT.C, config={align = "tm"}, nodes={
					{n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
						{n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
					}},
					{n=G.UIT.R, config={align = "cm"}, nodes={
						{n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
						{n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
					}}
				}}
			}},
		}}
		local t = {
			n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
				{n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
					{n=G.UIT.R, config={align = 'cl'}, nodes={
						sell
					}},
				}},
			}}
		return t
	end
	return G_UIDEF_use_and_sell_buttons_ref(card)
end

--Modified Code from Betmma's Vouchers
G.FUNCS.can_reserve_card = function(e)
	if #G.consumeables.cards < G.consumeables.config.card_limit then
		if not e.config.colour == G.C.IMPORTANT then
			e.config.colour = G.C.RED
		end
		if (e.config.ref_table.config.center.activation and e.config.activate) or e.config.pull then
			e.config.button = "reserve_card"
		else
			e.config.button = "use_card"
		end
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end
G.FUNCS.reserve_card = function(e)
	local c1 = e.config.ref_table
	if e.config.activate then
		G.FUNCS.tape_activate(c1)
	end
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.1,
		func = function()
			c1.area:remove_card(c1)
			c1:add_to_deck()
			if c1.children.price then
				c1.children.price:remove()
			end
			c1.children.price = nil
			if c1.children.buy_button then
				c1.children.buy_button:remove()
			end
			c1.children.buy_button = nil
			remove_nils(c1.children)
			G.consumeables:emplace(c1)
			G.GAME.pack_choices = G.GAME.pack_choices - 1
			if G.GAME.pack_choices <= 0 then
				G.FUNCS.end_consumeable(nil, delay_fac)
			end
			return true
		end,
	}))
end

G.FUNCS.csau_all_suit = function(context, suit)
	local all = true
	for k, v in ipairs(context.full_hand) do
		if not v:is_suit(suit, nil, true) then
			all = false
		end
	end
	return all
end

G.FUNCS.csau_add_chance = function(num, multiply, startAtOne)
	multiply = multiply or false
	startAtOne = startAtOne or false
	if G.FUNCS.powers_active and G.FUNCS.powers_active() then
		return 0
	else
		if multiply then
			if G.GAME.probabilities and G.GAME.probabilities.normal then
				if startAtOne then
					return (1 + num) * G.GAME.probabilities.normal
				else
					return (num <= 0 and 0 or (1 + num)) * G.GAME.probabilities.normal
				end
			else
				if startAtOne then
					return 1 + num
				else
					return num
				end
			end
		else
			if startAtOne then
				return 1 + num
			else
				return num
			end
		end
	end
end


SMODS.Atlas({ key = 'csau_undiscovered', path ="undiscovered.png", px = 71, py = 95 })

if twoPointO and #conf_cardsauce.vhsToLoad > 0 then
	G.C.VHS = HEX('a2615e')

	SMODS.ConsumableType{
		key = "VHS",
		primary_colour = G.C.VHS,
		secondary_colour = G.C.VHS,
		collection_rows = { 8, 8 },
		shop_rate = 0,
		loc_txt = {},
		default = "c_csau_blackspine",
		can_stack = false,
		can_divide = false,
	}

	SMODS.UndiscoveredSprite{
		key = "VHS",
		atlas = "csau_undiscovered",
		pos = { x = 0, y = 0 }
	}

	G.FUNCS.tape_activate = function(card)
		if not card.config.center.activation then return end
		if card.ability.activated then
			card.ability.activated = false
			play_sound('csau_vhsclose', 0.9 + math.random()*0.1, 0.4)
		else
			card.ability.tape_move = 9
			card.ability.sleeve_move = -9
			card.ability.activated = true
			play_sound('csau_vhsopen', 0.9 + math.random()*0.1, 0.4)
		end
	end

	G.FUNCS.destroy_tape = function(card, delay, ach, silent)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = delay,
			func = function()
				if not silent then
					play_sound('tarot1')
				end
				card.T.r = -0.2
				card:juice_up(0.3, 0.4)
				card.states.drag.is = true
				card.children.center.pinch.x = true
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
					 func = function()
						 card:start_dissolve({ G.C.VHS, G.C.RED })
						 --G.consumeables:remove_card(card)
						 --card:remove()
						 --card = nil
						 return true
					 end
				}))
				if ach then
					check_for_unlock({ type = ach })
				end
				return true
			end
		}))
	end
end

if twoPointO and #conf_cardsauce.standsToLoad > 0 then
	G.C.Stand = HEX('b85f8e')
	SMODS.ConsumableType{
		key = "Stand",
		primary_colour = G.C.Stand,
		secondary_colour = G.C.Stand,
		collection_rows = { 8, 8 },
		shop_rate = 0,
		loc_txt = {},
		default = "c_csau_blackspine",
		can_stack = false,
		can_divide = false,
	}

	SMODS.UndiscoveredSprite{
		key = "Stand",
		atlas = "csau_undiscovered",
		pos = { x = 1, y = 0 },
        overlay_pos = {x = 2, y = 0}
	}
end

-- Load Jokers
for i, v in ipairs(conf_cardsauce.jokersToLoad) do
	local jokerInfo = assert(SMODS.load_file("items/jokers/" .. v .. ".lua"))()
	local enabled = false
	if jokerInfo.streamer then
		if ((jokerInfo.streamer == 'vinny' or jokerInfo.streamer == 'othervinny') and csau_enabled['enableVinkers'])
				or ((jokerInfo.streamer == 'joel' or jokerInfo.streamer == 'otherjoel') and csau_enabled['enableJoelkers'])
				or ((jokerInfo.streamer == 'other' or jokerInfo.streamer == 'othervinny') and csau_enabled['enableOtherJokers']) then
			enabled = true
		end
	end
	if enabled then
		jokerInfo.key = v
		jokerInfo.atlas = v
		local atlasKey = v
		if jokerInfo.texture then
			atlasKey = jokerInfo.texture
			jokerInfo.atlas = jokerInfo.texture
		end
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

		SMODS.Atlas({ key = atlasKey, path ="jokers/" .. atlasKey .. ".png", px = jokerInfo.width or 71, py = jokerInfo.height or  95 })
	end
end

local loadConsumable = function(folder, v)
	local consumInfo = assert(SMODS.load_file("items/"..folder.."/" .. v .. ".lua"))()

	consumInfo.key = consumInfo.key or v
	consumInfo.atlas = v

	consumInfo.pos = { x = 0, y = 0 }
	if consumInfo.hasSoul then
		consumInfo.pos = { x = 1, y = 0 }
		consumInfo.soul_pos = { x = 2, y = 0 }
	end

	local consum = SMODS.Consumable(consumInfo)
	for k_, v_ in pairs(consum) do
		if type(v_) == 'function' then
			consum[k_] = consumInfo[k_]
		end
	end

	SMODS.Atlas({ key = v, path =folder.."/" .. v .. ".png", px = consum.width or 71, py = consum.height or  95 })
end

-- Load Consumables
for i, v in ipairs(conf_cardsauce.consumablesToLoad) do
	loadConsumable('consumables', v)
end
for i, v in ipairs(conf_cardsauce.vhsToLoad) do
	loadConsumable('vhs', v)
end
for i, v in ipairs(conf_cardsauce.standsToLoad) do
	loadConsumable('stands', v)
end

for i, v in ipairs(conf_cardsauce.packsToLoad) do
	local packInfo = assert(SMODS.load_file("items/packs/" .. v .. ".lua"))()

	packInfo.key = v
	packInfo.atlas = v

	packInfo.pos = { x = 0, y = 0 }

	local pack = SMODS.Booster(packInfo)
	for k_, v_ in pairs(pack) do
		if type(v_) == 'function' then
			pack[k_] = packInfo[k_]
		end
	end

	SMODS.Atlas({ key = v, path ="packs/" .. v .. ".png", px = pack.width or 71, py = pack.height or  95 })
end

for i, v in ipairs(conf_cardsauce.tagsToLoad) do
	local tagInfo = assert(SMODS.load_file("items/tags/" .. v .. ".lua"))()

	tagInfo.key = v
	tagInfo.atlas = v
	tagInfo.pos = { x = 0, y = 0 }

	local tag = SMODS.Tag(tagInfo)
	for k_, v_ in pairs(tag) do
		if type(v_) == 'function' then
			tag[k_] = tagInfo[k_]
		end
	end

	SMODS.Atlas({ key = v, path ="tags/" .. v .. ".png", px = tag.width or 34, py = tag.height or 34 })
end
for i, v in ipairs(conf_cardsauce.vouchersToLoad) do
	local voucherInfo = assert(SMODS.load_file("items/vouchers/" .. v .. ".lua"))()

	voucherInfo.key = v
	voucherInfo.atlas = v
	voucherInfo.pos = { x = 0, y = 0 }

	local voucher = SMODS.Voucher(voucherInfo)
	for k_, v_ in pairs(voucher) do
		if type(v_) == 'function' then
			voucher[k_] = voucherInfo[k_]
		end
	end

	SMODS.Atlas({ key = v, path ="vouchers/" .. v .. ".png", px = voucher.width or 71, py = voucher.height or 95 })
end

if csau_enabled['enableDecks'] then
	for i, v in ipairs(conf_cardsauce.decksToLoad) do
		local deckInfo = assert(SMODS.load_file("items/decks/" .. v .. ".lua"))()

		deckInfo.key = v
		deckInfo.atlas = v
		deckInfo.pos = { x = 0, y = 0 }
		if deckInfo.hasSoul then
			deckInfo.pos = { x = 1, y = 0 }
			deckInfo.soul_pos = { x = 2, y = 0 }
		end

		local deck = SMODS.Back(deckInfo)
		for k_, v_ in pairs(deck) do
			if type(v_) == 'function' then
				deck[k_] = deckInfo[k_]
			end
		end

		SMODS.Atlas({ key = v, path ="decks/" .. v .. ".png", px = deck.width or 71, py = deck.height or  95 })
	end
end
if csau_enabled['enableChallenges'] then
	for i, v in ipairs(conf_cardsauce.challengesToLoad) do
		local chalInfo = assert(SMODS.load_file("items/challenges/" .. v .. ".lua"))()

		chalInfo.key = v

		local chal = SMODS.Challenge(chalInfo)
		for k_, v_ in pairs(chal) do
			if type(v_) == 'function' then
				chal[k_] = chalInfo[k_]
			end
		end
	end
end
if csau_enabled['enableBosses'] then
	for i, v in ipairs(conf_cardsauce.blindsToLoad) do
		local blindInfo = assert(SMODS.load_file("items/blinds/" .. v .. ".lua"))()

		blindInfo.key = v
		blindInfo.atlas = v
		if blindInfo.color then
			blindInfo.boss_colour = blindInfo.color
			blindInfo.color = nil
		end

		local blind = SMODS.Blind(blindInfo)
		for k_, v_ in pairs(blind) do
			if type(v_) == 'function' then
				blind[k_] = blindInfo[k_]
			end
		end

		SMODS.Atlas({ key = v, atlas_table = "ANIMATION_ATLAS", path = "blinds/" .. v .. ".png", px = 34, py = 34, frames = 21, })
	end
end
for i, v in ipairs(conf_cardsauce.trophiesToLoad) do
	local trophyInfo = assert(SMODS.load_file("items/achievements/" .. v))()

	trophyInfo.key = v:sub(2, -5)
	trophyInfo.atlas = 'csau_achievements'
	if trophyInfo.rarity then
		if trophyInfo.rarity == 1 then
			trophyInfo.pos = { x = 1, y = 0 }
		elseif trophyInfo.rarity == 2 then
			trophyInfo.pos = { x = 2, y = 0 }
		elseif trophyInfo.rarity == 3 then
			trophyInfo.pos = { x = 3, y = 0 }
		elseif trophyInfo.rarity == 4 then
			trophyInfo.pos = { x = 4, y = 0 }
		end
	end

	SMODS.Achievement(trophyInfo)
end

SMODS.Atlas({ key = 'csau_achievements', path = "csau_achievements.png", px = 66, py = 66})

local card_drawRef = Card.draw
function Card.draw(self, layer)
	local obj = self.config.center
	if obj.draw and type(obj.draw) == 'function' then
		obj:draw(self, layer)
	end
	card_drawRef(self, layer)
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

math.randomseed(os.time())
function externalPsuedorandom(chance, total)
	if total <= 0 then return false end
	local randomNumber = math.random(1, total)
	return randomNumber <= chance
end

ach_checklists = {
	band = {
		4,
		'the_band',
		{
			'Be Someone Forever',
			'Garbage Hand',
			'Another Light',
			'Kerosene',
			'Vincenzo',
			'Quarterdumb'
		},
	},
	high = {
		2,
		'high_one',
		{
			'Be Someone Forever',
			'Pivyot',
			'Meat',
			"Don't Mind If I Do",
		},
	},
	ff7 = {
		3,
		'triple_seven',
		{
			'Motorcyclist Joker',
			'No No No No No No No No No No No',
			'Meteor',
		}
	}
}

function ach_jokercheck(card, table)
	local counter = 0
	for i, name in ipairs(table[3]) do
		if next(find_joker(name)) or card.name == name then
			counter = counter + 1
		end
	end
	if counter >= table[1] then
		check_for_unlock({ type = table[2] })
	end
end

function G.FUNCS.ach_pepsecretunlock(text)
	for k, v in pairs(SMODS.PokerHands) do
		if k == text then
			if v.visible == false then
				check_for_unlock({ type = "unlock_pep" })
			end
		end
	end
end

function G.FUNCS.ach_characters_check()
	if G.SETTINGS.CUSTOM_DECK.Collabs.Spades == "collab_CYP" and
	   G.SETTINGS.CUSTOM_DECK.Collabs.Hearts == "collab_TBoI" and
	   G.SETTINGS.CUSTOM_DECK.Collabs.Diamonds == "collab_SV" and
	   G.SETTINGS.CUSTOM_DECK.Collabs.Clubs == "collab_STS" then
		check_for_unlock({ type = "skin_characters" })
	end
end

function G.FUNCS.ach_vineshroom_check()
	if ends_with(G.SETTINGS.CUSTOM_DECK.Collabs.Clubs, 'vineshroom') or G.SETTINGS.CUSTOM_DECK.Collabs.Clubs == "collab_PC" or G.SETTINGS.CUSTOM_DECK.Collabs.Clubs == "collab_WF" then
		check_for_unlock({ type = "skin_vineshroom" })
	end
end

if csau_enabled['enableSkins'] then
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
end

if csau_enabled['enableEasterEggs'] then
	G.chadnova = externalPsuedorandom(1, 1000)
end

if G.chadnova then
	G.TITLE_SCREEN_CARD = 'j_csau_chad'
else
	G.TITLE_SCREEN_CARD = G.P_CARDS.C_A
end

function G.FUNCS.title_screen_card(self, SC_scale)
	if G.chadnova then
		if type(G.TITLE_SCREEN_CARD) == "table" then
			return Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.TITLE_SCREEN_CARD, G.P_CENTERS.c_base)
		elseif type(G.TITLE_SCREEN_CARD) == "string" then
			return  Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS.empty, G.P_CENTERS[G.TITLE_SCREEN_CARD])
		else
			return Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS.C_A, G.P_CENTERS.c_base)
		end
	elseif csau_enabled['enableLogo'] then
		return Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS.C_A, G.P_CENTERS.c_base)
	else
		return Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS.S_A, G.P_CENTERS.c_base)
	end
end

function G.FUNCS.center_splash_screen_card(SC_scale)
	if G.chadnova then
		return Card(G.ROOM.T.w/2 - SC_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC_scale*G.CARD_H/2, SC_scale*G.CARD_W, SC_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[G.TITLE_SCREEN_CARD])
	else
		return Card(G.ROOM.T.w/2 - SC_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC_scale*G.CARD_H/2, SC_scale*G.CARD_W, SC_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['j_joker'])
	end
end

function G.FUNCS.splash_screen_card(card_pos, card_size)
	if G.chadnova then
		return Card(  card_pos.x + G.ROOM.T.w/2 - G.CARD_W*card_size/2,
				card_pos.y + G.ROOM.T.h/2 - G.CARD_H*card_size/2,
				card_size*G.CARD_W, card_size*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[G.TITLE_SCREEN_CARD])
	else
		return Card(  card_pos.x + G.ROOM.T.w/2 - G.CARD_W*card_size/2,
				card_pos.y + G.ROOM.T.h/2 - G.CARD_H*card_size/2,
				card_size*G.CARD_W, card_size*G.CARD_H, pseudorandom_element(G.P_CARDS), G.P_CENTERS.c_base)
	end
end

mgt = {"m", "e", "t", "a", "l", "g", "e", "a", "r", "t", "a", "c", "o"}
mgt_num = 1

local color_presets = {
	{
		"GREEN",
		"PURPLE",
		{'50846e', "BAL_DEF_SMALLBIGGREEN"},
		{"4f6367", "BAL_DEF_ENDLESSBLUEGREY"},
		'default_csau'
	},
	{
		"RED",
		"BLUE",
		{'50846e', "BAL_DEF_SMALLBIGGREEN"},
		{"4f6367", "BAL_DEF_ENDLESSBLUEGREY"},
		'default_bal'
	},
	{
		{'2c997f', "DS_GREENCYAN"},
		{'09271d', "DS_DARKGREEN"},
		{'3a6658', "DS_BGGREEN"},
		'darkshroom',
	},
	{
		{'60b283', "VS_GREEN"},
		{'a3c86f', "VS_YELLOWGREEN"},
		{'3a664c', "VS_BGGREEN"},
		'vineshroom',
	},
	{
		{"547bb8", "FS_BLUE"},
		{"67b874", "FS_PALEGREEN"},
		{"3a4b66", "FS_BGBLUE"},
		'fullsauce',
	},
	{
		{'e26565', "ES_PALERED"},
		{'a53b38', "ES_DARKRED"},
		{'704b4b', "ES_BGRED"},
		'extrasauce',
	},
	{
		{'9967a7', "TWITCH_PALEPURPLE"},
		{'483062', "TWITCH_DARKPURPLE"},
		{'655478', "TWITCH_BGPURPLE"},
		'twitch',
	},
	{
		{"b5e61d", "FREN_NEONGREEN"},
		{"04a1e5", "FREN_LIGHTBLUE"},
		{"446138", "FREN_BGGREEN"},
		'fren',
	},
	{
		"PURPLE",
		"YELLOW",
		{"655478", "JM_BGPURPLE"},
		'jabroni',
	},
	{
		"JOKER_GREY",
		"BLACK",
		{'404040', "UZU_BGGRAY"},
		'uzumaki',
	},
	{
		"customhex"
	}
}

local color_presets_nums = {}
local color_presets_strings = {}
for i, v in ipairs(color_presets) do
	local k = v[#v]
	table.insert(color_presets_strings, k)
	color_presets_nums[k] = i
	if k ~= "customhex" then
		for i = 1, #v - 1 do
			local func_name, color_name
			if type(v[i]) == "string" then
				func_name = "cs_"..v[i].."c"
				color_name = v[i]
			elseif type(v[i]) == "table" then
				G.C[v[i][2]] = HEX(v[i][1])
				func_name = "cs_"..v[i][2].."c"
				color_name = v[i][2]
			end
		end
	end
end

if csau_enabled['enableColors'] then
	if not G.SETTINGS.CS_COLOR1 then
		G.SETTINGS.CS_COLOR1 = G.C.GREEN
	end
	if not G.SETTINGS.CS_COLOR2 then
		G.SETTINGS.CS_COLOR2 = G.C.PURPLE
	end
	G.C.COLOUR1 = G.SETTINGS.CS_COLOR1 or G.C.RED
	G.C.COLOUR2 = G.SETTINGS.CS_COLOR2 or G.C.BLUE
	G.C.BLIND.Small = G.SETTINGS.CS_COLOR3 or HEX('50846e')
	G.C.BLIND.Big = G.SETTINGS.CS_COLOR3 or HEX('50846e')
	G.C.BLIND.won = G.SETTINGS.CS_COLOR4 or HEX('50846e')
	G.CUSTOMHEX1 = ""
	G.CUSTOMHEX2 = ""
	G.CUSTOMHEX3 = ""
	G.CUSTOMHEX4 = ""

	local function get_matching_color(name)
		for i, v in ipairs(color_presets) do
			if type(v[1]) == "string" then
				if name == v[1] then
					return G.C[name]
				end
			elseif type(v[1]) == "table" then
				if name == v[1][2] then
					return HEX(v[1][1])
				end
			end
			if type(v[2]) == "string" then
				if name == v[2] then
					return G.C[name]
				end
			elseif type(v[2]) == "table" then
				if name == v[2][2] then
					return HEX(v[2][1])
				end
			end
		end
	end

	function csau_save_color(colour, val)
		local color = get_matching_color(val)
		local set = 'CS_COLOR'..colour
		G.SETTINGS[set] = color
		G:save_settings()
	end

	local colors = {}
	for _, preset in ipairs(color_presets) do
		if preset[#preset] ~= "customhex" then
			for i = 1, #preset - 1 do
				if type(preset[i]) == "string" then
					colors[preset[i]] = true
				elseif type(preset[i]) == "table" then
					colors[preset[i][2]] = true
				end
			end
		end
	end

	local function isRed(color)
		if type(color) ~= "table" or #color < 3 then
			return false, "Invalid color table"
		end
		local r, g, b = color[1], color[2], color[3]
		return r > g and r > b and r > 0.5
	end

	local function isBlack(color)
		if type(color) ~= "table" or #color < 3 then
			return false, "Invalid color table"
		end
		local r, g, b = color[1], color[2], color[3]
		local tolerance = 0.2
		local darkness_threshold = 0.3
		local is_grayish = math.abs(r - g) <= tolerance and math.abs(g - b) <= tolerance and math.abs(r - b) <= tolerance
		local is_dark = r <= darkness_threshold and g <= darkness_threshold and b <= darkness_threshold
		return is_grayish and is_dark
	end

	local function renoColors(color1, color2)
		local red = false
		local black = false
		if isRed(G.C.COLOUR1) and not isBlack(G.C.COLOUR1) then
			red = true
		elseif isBlack(G.C.COLOUR1) and not isRed(G.C.COLOUR1) then
			black = true
		end
		if isRed(G.C.COLOUR2) and not isBlack(G.C.COLOUR2) then
			if red == true then
				return false
			end
			red = true
		elseif isBlack(G.C.COLOUR2) and not isRed(G.C.COLOUR2) then
			if black == true then
				return false
			end
			black = true
		end
		return red and black
	end

	local function ach_reno_check()
		if renoColors(G.C.COLOUR1, G.C.COLOUR2) then
			check_for_unlock({ type = "reno_colors" })
		end
	end

	for color, _ in pairs(colors) do
		G.FUNCS["change_color_1_" .. color] = function()
			G.C.COLOUR1 = G.C[color]
			csau_save_color(1, color)
			ach_reno_check()
		end

		G.FUNCS["change_color_2_" .. color] = function()
			G.C.COLOUR2 = G.C[color]
			csau_save_color(2, color)
			ach_reno_check()
		end

		G.FUNCS["change_color_3_" .. color] = function()
			G.C.BLIND.Small = G.C[color]
			G.C.BLIND.Big = G.C[color]
			if G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante < 9 then
				ease_background_colour{new_colour = G.C[color], contrast = 1}
			end
			csau_save_color(3, color)
		end

		G.FUNCS["change_color_4_" .. color] = function()
			G.C.BLIND.won = G.C[color]
			if G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante >= 9 then
				ease_background_colour{new_colour = G.C[color], contrast = 1}
			end
			csau_save_color(3, color)
		end
	end

	for i=1, 4 do
		G.FUNCS["paste_hex_"..i] = function(e)
			G.CONTROLLER.text_input_hook = e.UIBox:get_UIE_by_ID('hex_set_'..i).children[1].children[1]
			G.CONTROLLER.text_input_id = 'hex_set_'..i
			for i = 1, 6 do
				G.FUNCS.text_input_key({key = 'right'})
			end
			for i = 1, 6 do
				G.FUNCS.text_input_key({key = 'backspace'})
			end
			local clipboard = (G.F_LOCAL_CLIPBOARD and G.CLIPBOARD or love.system.getClipboardText()) or ''
			for i = 1, #clipboard do
				local c = clipboard:sub(i,i)
				if c ~= "#" then
					G.FUNCS.text_input_key({key = c})
				end
			end
			G.FUNCS.text_input_key({key = 'return'})
		end
	end

	local function validHEX(str)
		local hex = str:match("^#?(%x%x%x%x%x%x)$") or str:match("^#?(%x%x%x)$")
		return hex ~= nil
	end

	local function replaceReplacedChars(str)
		return str:gsub("[Oo]", "0")
	end

	G.FUNCS.apply_colors = function()
		for i=1, 4 do
			if G["CUSTOMHEX"..i] then
				local hex = replaceReplacedChars(G["CUSTOMHEX"..i])
				if validHEX(hex) then
					if i== 4 then
						G.C.BLIND.won = HEX(hex)
						if G.GAME and G.GAME..round_resets.ante >= 9 then
							ease_background_colour{new_colour = HEX(hex), contrast = 1}
						end
						G:save_settings()
					end
					if i==3 then
						G.C.BLIND.Small = HEX(hex)
						G.C.BLIND.Big = HEX(hex)
						if G.GAME and G.GAME..round_resets.ante < 9 then
							ease_background_colour{new_colour = HEX(hex), contrast = 1}
						end
						G.SETTINGS["CS_COLOR"..i] = HEX(hex)
						G:save_settings()
					elseif i == 1 or i == 2 then
						G.C["COLOUR"..i] = HEX(hex)
						G.SETTINGS["CS_COLOR"..i] = HEX(hex)
						G:save_settings()
					end
				end
			end
		end
		ach_reno_check()
	end

	if not G.SETTINGS.csau_color_selection then
		G.SETTINGS.csau_color_selection = "default_csau"
	end

	if not G.SETTINGS.music_selection then
		G.SETTINGS.music_selection = "cardsauce"
	end
end

local function initPostMainMenu()
	if csau_enabled['enableChallenges'] then
		csau_tucker_addBanned()
	end
end

local main_menuRef = Game.main_menu
function Game:main_menu(change_context)
	main_menuRef(self, change_context)

	initPostMainMenu()

	if csau_enabled['enableColors'] then
		local splash_args = {mid_flash = change_context == 'splash' and 1.6 or 0.}
		ease_value(splash_args, 'mid_flash', -(change_context == 'splash' and 1.6 or 0), nil, nil, nil, 4)

		G.SPLASH_BACK:define_draw_steps({{
			 shader = 'splash',
			 send = {
				 {name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
				 {name = 'vort_speed', val = 0.4},
				 {name = 'colour_1', ref_table = G.C, ref_value = 'COLOUR1'},
				 {name = 'colour_2', ref_table = G.C, ref_value = 'COLOUR2'},
				 {name = 'mid_flash', ref_table = splash_args, ref_value = 'mid_flash'},
				 {name = 'vort_offset', val = 0},
			 }}})
	end
end

if csau_enabled['enableColors'] then
	G.FUNCS.change_color_buttons = function()
		if G.OVERLAY_MENU then
			local swap_node = G.OVERLAY_MENU:get_UIE_by_ID('color_buttons')
			local focused_color_preset = G.SETTINGS.QUEUED_CHANGE.color_change
			local color = {}
			local key
			for _, v in ipairs(color_presets) do
				if v[#v] == focused_color_preset then
					key = v[#v]
					if v[#v] ~= "customhex" then
						for i=1, #v - 1 do
							color[i] = v[i][2] or v[i]
						end
					end
				end
			end
			if swap_node then
				for i=1, #swap_node.children do
					swap_node.children[i]:remove()
					swap_node.children[i] = nil
				end

				local new_color_buttons = {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={}}
				new_color_buttons.nodes[#new_color_buttons.nodes + 1] = {n=G.UIT.T, config={text = localize('b_color_selector_outer'), scale = 0.35, colour = G.C.WHITE, shadow = true}}
				if key == "customhex" then
					new_color_buttons.nodes[#new_color_buttons.nodes + 1] = create_text_input({id = 'hex_set_1', h = 0.05, w = 2, text_scale = 0.35, ref_table = G, ref_value = 'CUSTOMHEX1', max_length = 6, prompt_text = localize('b_color_selector_hex'), extended_corpus = true, config = { align = "cm" }})
					new_color_buttons.nodes[#new_color_buttons.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
						UIBox_button({minw = 1.25, minh = 0.5, button = "paste_hex_1", colour = G.C.RED, label = localize('b_color_selector_paste_hex'), scale = 0.35})
					}}
				else
					for i, color in ipairs(color) do
						new_color_buttons.nodes[#new_color_buttons.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
							UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_1_"..color, colour = G.C[color], label = {" "}, scale = 0.35})
						}}
					end
				end
				new_color_buttons.nodes[#new_color_buttons.nodes + 1] = {n=G.UIT.T, config={text = "|", scale = 0.35, colour = G.C.WHITE, shadow = true}}
				if key == "customhex" then
					new_color_buttons.nodes[#new_color_buttons.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
						UIBox_button({minw = 1.25, minh = 0.5, button = "paste_hex_2", colour = G.C.RED, label = localize('b_color_selector_paste_hex'), scale = 0.35})
					}}
					new_color_buttons.nodes[#new_color_buttons.nodes + 1] = create_text_input({id = 'hex_set_2', h = 0.05, w = 2, text_scale = 0.35, ref_table = G, ref_value = 'CUSTOMHEX2', max_length = 6, prompt_text = localize('b_color_selector_hex'), config = { align = "cm" }})
				else
					for i, color in ipairs(color) do
						new_color_buttons.nodes[#new_color_buttons.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
							UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_2_"..color, colour = G.C[color], label = {" "}, scale = 0.35})
						}}
					end
				end
				new_color_buttons.nodes[#new_color_buttons.nodes + 1] = {n=G.UIT.T, config={text = localize('b_color_selector_inner'), scale = 0.35, colour = G.C.WHITE, shadow = true}}
				local new_sub_caption = { n=G.UIT.R, config={ align = "cm", padding = 0}, nodes={ { n=G.UIT.T, config={ text = localize('b_color_selector_game'), scale = 0.35, colour = G.C.WHITE, shadow = true}}}}
				local new_sub_buttons = {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={}}
				if key == "customhex" then
					new_sub_buttons.nodes[#new_sub_buttons.nodes + 1] = create_text_input({id = 'hex_set_3', h = 0.05, w = 2, text_scale = 0.35, ref_table = G, ref_value = 'CUSTOMHEX3', max_length = 6, prompt_text = localize('b_color_selector_hex'), config = { align = "cm" }})
					new_sub_buttons.nodes[#new_sub_buttons.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2, align = "cm", }, nodes = {
						UIBox_button({minw = 1.25, minh = 0.5, button = "paste_hex_3", colour = G.C.RED, label = localize('b_color_selector_paste_hex'), scale = 0.35})
					}}
				else
					for i, color in ipairs(color) do
						new_sub_buttons.nodes[#new_sub_buttons.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
							UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_3_"..color, colour = G.C[color], label = {" "}, scale = 0.35})
						}}
					end
				end
				local new_sub_caption_2 = { n=G.UIT.R, config={ align = "cm", padding = 0}, nodes={ { n=G.UIT.T, config={ text = localize('b_color_selector_game_2'), scale = 0.35, colour = G.C.WHITE, shadow = true}}}}
				local new_sub_buttons_2 = {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={}}
				if key == "customhex" then
					new_sub_buttons_2.nodes[#new_sub_buttons_2.nodes + 1] = create_text_input({id = 'hex_set_4', h = 0.05, w = 2, text_scale = 0.35, ref_table = G, ref_value = 'CUSTOMHEX4', max_length = 6, prompt_text = localize('b_color_selector_hex'), config = { align = "cm" }})
					new_sub_buttons_2.nodes[#new_sub_buttons_2.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2, align = "cm", }, nodes = {
						UIBox_button({minw = 1.25, minh = 0.5, button = "paste_hex_4", colour = G.C.RED, label = localize('b_color_selector_paste_hex'), scale = 0.35})
					}}
				else
					for i, color in ipairs(color) do
						new_sub_buttons_2.nodes[#new_sub_buttons_2.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
							UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_4_"..color, colour = G.C[color], label = {" "}, scale = 0.35})
						}}
					end
				end
				local apply_button = {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={}}
				if key == "customhex" then
					apply_button.nodes[#apply_button.nodes + 1] = {n = G.UIT.C, config = {padding = 0.05,align = "cm", }, nodes = {
						UIBox_button({minw = 2, minh = 0.5, button = "apply_colors", colour = G.C.RED, label = localize('b_color_selector_hex_set'), scale = 0.35})
					}}
				end
				swap_node.UIBox:add_child(new_color_buttons, swap_node)
				swap_node.UIBox:add_child(new_sub_caption, swap_node)
				swap_node.UIBox:add_child(new_sub_buttons, swap_node)
				swap_node.UIBox:add_child(new_sub_caption_2, swap_node)
				swap_node.UIBox:add_child(new_sub_buttons_2, swap_node)
				swap_node.UIBox:add_child(apply_button, swap_node)
			end
		end
	end

	G.FUNCS.change_color_preset = function(args)
		G.ARGS.color_vals = G.ARGS.color_vals or color_presets_strings
		G.SETTINGS.QUEUED_CHANGE.color_change = G.ARGS.color_vals[args.to_key]
		G.SETTINGS.csau_color_selection = G.ARGS.color_vals[args.to_key]
		G.FUNCS.change_color_buttons()
	end
end

local music_nums = {
	cardsauce = 1,
	balatro = 2
}

local music_strings = {
	"cardsauce",
	"balatro"
}

G.FUNCS.change_music = function(args)
	G.ARGS.music_vals = G.ARGS.music_vals or music_strings
	G.SETTINGS.QUEUED_CHANGE.music_change = G.ARGS.music_vals[args.to_key]
	G.SETTINGS.music_selection = G.ARGS.music_vals[args.to_key]
end


setting_tabRef = G.UIDEF.settings_tab
function G.UIDEF.settings_tab(tab)
	local setting_tab = setting_tabRef(tab)
	if tab == 'Audio' and csau_enabled['enableMusic'] then
		local musicSelector = {n=G.UIT.R, config = {align = 'cm', r = 0}, nodes= {
			create_option_cycle({ w = 6, scale = 0.8, label = localize('b_music_selector'), options = localize('ml_music_selector_opt'), opt_callback = 'change_music', current_option = ((music_nums)[G.SETTINGS.music_selection] or 1) })
		}}
		setting_tab.nodes[#setting_tab.nodes + 1] = musicSelector
	end
	if tab == 'Colors' and csau_enabled['enableColors'] then
		local color = {}
		local key
		for _, v in ipairs(color_presets) do
			if v[#v] == G.SETTINGS.csau_color_selection then
				key = v[#v]
				if v[#v] ~= "customhex" then
					for i=1, #v - 1 do
						color[i] = v[i][2] or v[i]
					end
				end
			end
		end
		local nodes = {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={}}
		nodes.nodes[#nodes.nodes + 1] = {n=G.UIT.T, config={text = localize('b_color_selector_outer'), scale = 0.35, colour = G.C.WHITE, shadow = true}}
		if key == "customhex" then
			nodes.nodes[#nodes.nodes + 1] = create_text_input({id = 'hex_set_1', h = 0.05, w = 2, text_scale = 0.35, ref_table = G, ref_value = 'CUSTOMHEX1', max_length = 6, prompt_text = localize('b_color_selector_hex'), extended_corpus = true, config = { align = "cm" }})
			nodes.nodes[#nodes.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
				UIBox_button({minw = 1.25, minh = 0.5, button = "paste_hex_1", colour = G.C.RED, label = localize('b_color_selector_paste_hex'), scale = 0.35})
			}}
		else
			for i, color in ipairs(color) do
				nodes.nodes[#nodes.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
					UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_1_"..color, colour = G.C[color], label = {" "}, scale = 0.35})
				}}
			end
		end
		nodes.nodes[#nodes.nodes + 1] = {n=G.UIT.T, config={text = "|", scale = 0.35, colour = G.C.WHITE, shadow = true}}
		if key == "customhex" then
			nodes.nodes[#nodes.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
				UIBox_button({minw = 1.25, minh = 0.5, button = "paste_hex_2", colour = G.C.RED, label = localize('b_color_selector_paste_hex'), scale = 0.35})
			}}
			nodes.nodes[#nodes.nodes + 1] = create_text_input({id = 'hex_set_2', h = 0.05, w = 2, text_scale = 0.35, ref_table = G, ref_value = 'CUSTOMHEX2', max_length = 6, prompt_text = localize('b_color_selector_hex'), extended_corpus = true, config = { align = "cm" }})
		else
			for i, color in ipairs(color) do
				nodes.nodes[#nodes.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
					UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_2_"..color, colour = G.C[color], label = {" "}, scale = 0.35})
				}}
			end
		end
		nodes.nodes[#nodes.nodes + 1] = {n=G.UIT.T, config={text = localize('b_color_selector_inner'), scale = 0.35, colour = G.C.WHITE, shadow = true}}
		local sub_caption = { n=G.UIT.R, config={ align = "cm", padding = 0}, nodes={ { n=G.UIT.T, config={ text = localize('b_color_selector_game'), scale = 0.35, colour = G.C.WHITE, shadow = true}}}}
		local sub_buttons = {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={}}
		if key == "customhex" then
			sub_buttons.nodes[#sub_buttons.nodes + 1] = create_text_input({id = 'hex_set_3', h = 0.05, w = 2, text_scale = 0.35, ref_table = G, ref_value = 'CUSTOMHEX3', max_length = 6, prompt_text = localize('b_color_selector_hex'), extended_corpus = true, config = { align = "cm" }})
			sub_buttons.nodes[#sub_buttons.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
				UIBox_button({minw = 1.25, minh = 0.5, button = "paste_hex_3", colour = G.C.RED, label = localize('b_color_selector_paste_hex'), scale = 0.35})
			}}
		else
			for i, color in ipairs(color) do
				sub_buttons.nodes[#sub_buttons.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
					UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_3_"..color, colour = G.C[color], label = {" "}, scale = 0.35})
				}}
			end
		end
		local sub_caption_2 = { n=G.UIT.R, config={ align = "cm", padding = 0}, nodes={ { n=G.UIT.T, config={ text = localize('b_color_selector_game_2'), scale = 0.35, colour = G.C.WHITE, shadow = true}}}}
		local sub_buttons_2 = {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={}}
		if key == "customhex" then
			sub_buttons_2.nodes[#sub_buttons_2.nodes + 1] = create_text_input({id = 'hex_set_4', h = 0.05, w = 2, text_scale = 0.35, ref_table = G, ref_value = 'CUSTOMHEX4', max_length = 6, prompt_text = localize('b_color_selector_hex'), extended_corpus = true, config = { align = "cm" }})
			sub_buttons_2.nodes[#sub_buttons_2.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
				UIBox_button({minw = 1.25, minh = 0.5, button = "paste_hex_4", colour = G.C.RED, label = localize('b_color_selector_paste_hex'), scale = 0.35})
			}}
		else
			for i, color in ipairs(color) do
				sub_buttons_2.nodes[#sub_buttons_2.nodes + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
					UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_4_"..color, colour = G.C[color], label = {" "}, scale = 0.35})
				}}
			end
		end
		local apply_button = {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={}}
		if key == "customhex" then
			apply_button.nodes[#apply_button.nodes + 1] = {n = G.UIT.C, config = {padding = 0.05,align = "cm", }, nodes = {
				UIBox_button({minw = 2, minh = 0.5, button = "apply_colors", colour = G.C.RED, label = localize('b_color_selector_hex_set'), scale = 0.35})
			}}
		end
		local colorSelector = {n=G.UIT.R, config = {align = 'cm', r = 0}, nodes={
			create_option_cycle({w = 5,scale = 0.8, label = localize('b_color_selector'), options = localize('ml_color_selector_opt'), opt_callback = 'change_color_preset', current_option = ((color_presets_nums)[G.SETTINGS.csau_color_selection] or 1)}),
			{n=G.UIT.R, config={align = "cm", id = 'color_buttons'}, nodes={nodes, sub_caption, sub_buttons, sub_caption_2, sub_buttons_2, apply_button}},
		}}
		setting_tab.nodes[#setting_tab.nodes + 5] = colorSelector
	end
	return setting_tab
end

-- Mod Icon in Mods tab
SMODS.Atlas({
	key = "modicon",
	path = "csau_icon.png",
	px = 32,
	py = 32
}):register()

if csau_enabled['enableLogo'] then
	-- Title Screen Logo Texture
	local logo = "Logo.png"
	if G.chadnova and csau_enabled['enableEasterEggs'] then
		logo = "Logo-C.png"
	end
	SMODS.Atlas {
		key = "balatro",
		path = logo,
		px = 333,
		py = 216,
		prefix_config = { key = false }
	}
end

-- Tarot Atlas
SMODS.Atlas{
	key = "tarotreskins",
	path = "tarotreskins.png",
	px = 71,
	py = 95,
	atlas_table = "ASSET_ATLAS"
}
SMODS.Atlas{
	key = 'alt_color_jokers',
	path = "colorjokers.png",
	px = 71,
	py = 95,
	atlas_table = "ASSET_ATLAS",
}

if AltTexture and TexturePack then
	AltTexture({
		key = 'jokers',
		set = 'Joker',
		path = 'colorjokers.png',
		loc_txt = {
			name = 'Jokers'
		},
		keys = {
			'j_gluttenous_joker',
			'j_greedy_joker',
			'j_lusty_joker',
			'j_wrathful_joker',
			'j_onyx_agate',
			'j_rough_gem'
		},
		original_sheet = true
	})

	AltTexture({
		key = 'tarot',
		set = 'Tarot',
		path = 'tarotreskins.png',
		loc_txt = {
			name = 'Tarot'
		},
		keys = {
			'c_hermit',
			'c_moon',
		},
		original_sheet = true
	})

	TexturePack{
		key = 'csau',
		textures = {
			'csau_jokers',
			'csau_tarot',
		},
		loc_txt = {
			name = 'Cardsauce Malverk Compatibility',
			text = {
				"Enables the Cardsauce reskins of the Suit Color",
				"Jokers + 2 Tarot cards to work with Malverk!",
			}
		}
	}
end

if csau_enabled['enableTarotSkins'] then
	SMODS.Consumable:take_ownership('moon', {
		atlas = 'csau_tarotreskins'
	}, true)
	SMODS.Consumable:take_ownership('hermit', {
		atlas = 'csau_tarotreskins'
	}, true)
end

if csau_enabled['enableSkins'] then
	SMODS.Joker:take_ownership('greedy_joker', {
		atlas = 'csau_alt_color_jokers'
	}, true)
	SMODS.Joker:take_ownership('lusty_joker', {
		atlas = 'csau_alt_color_jokers'
	}, true)
	SMODS.Joker:take_ownership('wrathful_joker', {
		atlas = 'csau_alt_color_jokers'
	}, true)
	SMODS.Joker:take_ownership('gluttenous_joker', {
		atlas = 'csau_alt_color_jokers'
	}, true)

	SMODS.Joker:take_ownership('onyx_agate', {
		atlas = 'csau_alt_color_jokers'
	}, true)
	SMODS.Joker:take_ownership('rough_gem', {
		atlas = 'csau_alt_color_jokers'
	}, true)

	local suits = {'hearts', 'diamonds', 'clubs', 'spades'}
	local full_ranks = {"Ace", "King", "Queen", "Jack", "10", "9", "8", "7", "6", "5", "4", "3", "2"}
	local face_ace = {"Ace", "King", "Queen", "Jack"}
	local face = {"King", "Queen", "Jack"}
	local color = {
		Hearts = HEX("e14e62"),
		Diamonds = HEX("3c56a4"),
		Clubs = HEX("4dac84"),
		Spades = HEX("8d619a"),
	}

	SMODS.Atlas{
		key = 'balcolor_shrooms_lc',
		px = 71,
		py = 95,
		path = 'cards/balcolor_shrooms_lc.png',
	}
	SMODS.Atlas{
		key = 'balcolor_shrooms_hc',
		px = 71,
		py = 95,
		path = 'cards/balcolor_shrooms_hc.png',
	}
	SMODS.Atlas{
		key = 'varg_aces',
		px = 71,
		py = 95,
		path = 'cards/csau_varg_aces.png',
	}
	SMODS.Atlas{
		key = 'balcolor_varg_lc',
		px = 71,
		py = 95,
		path = 'cards/balcolor_varg_lc.png',
	}
	SMODS.Atlas{
		key = 'balcolor_varg_hc',
		px = 71,
		py = 95,
		path = 'cards/balcolor_varg_hc.png',
	}
	SMODS.Atlas{
		key = 'varg_willo',
		px = 71,
		py = 95,
		path = 'cards/csau_varg_willo.png',
	}
	SMODS.Atlas{
		key = 'color_aces',
		px = 71,
		py = 95,
		path = 'cards/csau_color_aces.png',
	}
	SMODS.Atlas{
		key = 'c_vineshroom',
		px = 71,
		py = 95,
		path = 'cards/c_vineshroom.png',
	}
	SMODS.Atlas{
		key = 'csau_default',
		px = 71,
		py = 95,
		path = 'cards/csau_default.png',
		prefix_config = {key = false},
	}

	SMODS.Atlas{ key = 'suits', px = 18, py = 18, path = 'cards/suits.png', }
	SMODS.Atlas{ key = 'hearts_willo', px = 18, py = 18, path = 'cards/hearts_willo.png', }

	-- Recolored Clubs Collabs
	SMODS.Atlas{ key = 'csau_c_collab_VS', px = 71, py = 95, path = 'cards/recolored/csau_c_collab_VS.png', prefix_config = {key = false},}
	SMODS.Atlas{ key = 'csau_c_collab_STS', px = 71, py = 95, path = 'cards/recolored/csau_c_collab_STS.png', prefix_config = {key = false},}
	SMODS.Atlas{ key = 'csau_c_collab_PC', px = 71, py = 95, path = 'cards/recolored/csau_c_collab_PC.png', prefix_config = {key = false},}
	SMODS.Atlas{ key = 'csau_c_collab_WF', px = 71, py = 95, path = 'cards/recolored/csau_c_collab_WF.png', prefix_config = {key = false},}
	-- Recolored Diamonds Collabs
	SMODS.Atlas{ key = 'csau_d_collab_DTD', px = 71, py = 95, path = 'cards/recolored/csau_d_collab_DTD.png', prefix_config = {key = false},}
	SMODS.Atlas{ key = 'csau_d_collab_SV', px = 71, py = 95, path = 'cards/recolored/csau_d_collab_SV.png', prefix_config = {key = false},}
	SMODS.Atlas{ key = 'csau_d_collab_EG', px = 71, py = 95, path = 'cards/recolored/csau_d_collab_EG.png', prefix_config = {key = false},}
	SMODS.Atlas{ key = 'csau_d_collab_XR', px = 71, py = 95, path = 'cards/recolored/csau_d_collab_XR.png', prefix_config = {key = false},}
	-- Recolored Hearts Collabs
	SMODS.Atlas{ key = 'csau_h_collab_AU', px = 71, py = 95, path = 'cards/recolored/csau_h_collab_AU.png', prefix_config = {key = false},}
	SMODS.Atlas{ key = 'csau_h_collab_TBoI', px = 71, py = 95, path = 'cards/recolored/csau_h_collab_TBoI.png', prefix_config = {key = false},}
	SMODS.Atlas{ key = 'csau_h_collab_CL', px = 71, py = 95, path = 'cards/recolored/csau_h_collab_CL.png', prefix_config = {key = false},}
	SMODS.Atlas{ key = 'csau_h_collab_D2', px = 71, py = 95, path = 'cards/recolored/csau_h_collab_D2.png', prefix_config = {key = false},}
	-- Recolored Spades Collabs
	SMODS.Atlas{ key = 'csau_s_collab_TW', px = 71, py = 95, path = 'cards/recolored/csau_s_collab_TW.png', prefix_config = {key = false}, }
	SMODS.Atlas{ key = 'csau_s_collab_CYP', px = 71, py = 95, path = 'cards/recolored/csau_s_collab_CYP.png', prefix_config = {key = false}, }
	SMODS.Atlas{ key = 'csau_s_collab_SK', px = 71, py = 95, path = 'cards/recolored/csau_s_collab_SK.png', prefix_config = {key = false}, }
	SMODS.Atlas{ key = 'csau_s_collab_DS', px = 71, py = 95, path = 'cards/recolored/csau_s_collab_DS.png', prefix_config = {key = false}, }

	-- Vine Characters
	SMODS.Atlas{ key = 'c_mascots', px = 71, py = 95, path = 'cards/csau/c_mascots.png',}
	SMODS.Atlas{ key = 'd_classics', px = 71, py = 95, path = 'cards/csau/d_classics.png',}
	SMODS.Atlas{ key = 'h_wildcards', px = 71, py = 95, path = 'cards/csau/h_wildcards.png',}
	SMODS.Atlas{ key = 's_confidants', px = 71, py = 95, path = 'cards/csau/s_confidants.png',}

	-- Varg Characters
	SMODS.Atlas{ key = 'c_voices', px = 71, py = 95, path = 'cards/csau/c_voices.png',}
	SMODS.Atlas{ key = 'd_duendes', px = 71, py = 95, path = 'cards/csau/d_duendes.png',}
	SMODS.Atlas{ key = 'h_americans', px = 71, py = 95, path = 'cards/csau/h_americans.png',}
	SMODS.Atlas{ key = 's_powerful', px = 71, py = 95, path = 'cards/csau/s_powerful.png',}

	-- Mike Characters
	SMODS.Atlas{ key = 'h_poops', px = 71, py = 95, path = 'cards/csau/h_poops.png',}
	SMODS.Atlas{ key = 's_ocs', px = 71, py = 95, path = 'cards/csau/s_ocs.png',}

	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_VS'], { key = 'csau_collab_VS', ranks = full_ranks,
	   display_ranks = face, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_c_collab_VS', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_c_collab_VS', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_c_collab_VS', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 0} }
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors"
	   },
	   colour = color.Clubs,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_VS'], { key = 'csau_collab_VS_shroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_c_collab_VS', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_c_collab_VS', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_c_collab_VS', pos = {x = 2, y = 0} },
	   },
	   loc_txt = {
		   ['en-us'] = "CSAU Colors & Darkshroom"
	   },
	   colour = color.Clubs,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_VS'], { key = 'csau_collab_VS_vineshroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_c_collab_VS', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_c_collab_VS', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_c_collab_VS', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_c_vineshroom', pos = {x = 0, y = 0} }
	   },
	   loc_txt = {
		   ['en-us'] = "CSAU Colors & Vineshroom"
	   },
	   colour = color.Clubs,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})



	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_STS'], { key = 'csau_collab_STS', ranks = full_ranks,
		display_ranks = face, atlas = 'csau_default',
		pos_style = {
			fallback_style = 'deck',
			Jack = { atlas = 'csau_c_collab_STS', pos = {x = 0, y = 0} },
			Queen = { atlas = 'csau_c_collab_STS', pos = {x = 1, y = 0} },
			King = { atlas = 'csau_c_collab_STS', pos = {x = 2, y = 0} },
			Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 0} }
		},
		loc_txt = {
			['en-us'] = "Cardsauce Colors"
		},
		colour = color.Clubs,
		suit_icon = {
			atlas = 'csau_suits'
		}
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_STS'], { key = 'csau_collab_STS_shroom', ranks = full_ranks,
		display_ranks = face_ace, atlas = 'csau_default',
		pos_style = {
			fallback_style = 'deck',
			Jack = { atlas = 'csau_c_collab_STS', pos = {x = 0, y = 0} },
			Queen = { atlas = 'csau_c_collab_STS', pos = {x = 1, y = 0} },
			King = { atlas = 'csau_c_collab_STS', pos = {x = 2, y = 0} },
		},
		loc_txt = {
			['en-us'] = "CSAU Colors & Darkshroom"
		},
		colour = color.Clubs,
		suit_icon = {
			atlas = 'csau_suits'
		}
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_STS'], { key = 'csau_collab_STS_vineshroom', ranks = full_ranks,
		display_ranks = face_ace, atlas = 'csau_default',
		pos_style = {
			fallback_style = 'deck',
			Jack = { atlas = 'csau_c_collab_STS', pos = {x = 0, y = 0} },
			Queen = { atlas = 'csau_c_collab_STS', pos = {x = 1, y = 0} },
			King = { atlas = 'csau_c_collab_STS', pos = {x = 2, y = 0} },
			Ace = { atlas = 'csau_c_vineshroom', pos = {x = 0, y = 0} }
		},
		loc_txt = {
			['en-us'] = "CSAU Colors & Vineshroom"
		},
		colour = color.Clubs,
		suit_icon = {
			atlas = 'csau_suits'
		}
	})



	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_PC'], { key = 'csau_collab_PC', ranks = full_ranks,
	   display_ranks = face, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_c_collab_PC', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_c_collab_PC', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_c_collab_PC', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 0} }
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors"
	   },
	   colour = color.Clubs,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_PC'], { key = 'csau_collab_PC_shroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_c_collab_PC', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_c_collab_PC', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_c_collab_PC', pos = {x = 2, y = 0} },
	   },
	   loc_txt = {
		   ['en-us'] = "CSAU Colors & Darkshroom"
	   },
	   colour = color.Clubs,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_PC'], { key = 'csau_collab_PC_vineshroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_c_collab_PC', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_c_collab_PC', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_c_collab_PC', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_c_vineshroom', pos = {x = 0, y = 0} }
	   },
	   loc_txt = {
		   ['en-us'] = "CSAU Colors & Vineshroom"
	   },
	   colour = color.Clubs,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})



	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_WF'], { key = 'csau_collab_WF', ranks = full_ranks,
	   display_ranks = face, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_c_collab_WF', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_c_collab_WF', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_c_collab_WF', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 0} }
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors"
	   },
	   colour = color.Clubs,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_WF'], { key = 'csau_collab_WF_shroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_c_collab_WF', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_c_collab_WF', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_c_collab_WF', pos = {x = 2, y = 0} },
	   },
	   loc_txt = {
		   ['en-us'] = "CSAU Colors & Darkshroom"
	   },
	   colour = color.Clubs,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_WF'], { key = 'csau_collab_WF_vineshroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_c_collab_WF', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_c_collab_WF', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_c_collab_WF', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_c_vineshroom', pos = {x = 0, y = 0} }
	   },
	   loc_txt = {
		   ['en-us'] = "CSAU Colors & Vineshroom"
	   },
	   colour = color.Clubs,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})





	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_DTD'], { key = 'csau_collab_DTD', ranks = full_ranks,
		display_ranks = face, atlas = 'csau_default',
		pos_style = {
			fallback_style = 'deck',
			Jack = { atlas = 'csau_d_collab_DTD', pos = {x = 0, y = 0} },
			Queen = { atlas = 'csau_d_collab_DTD', pos = {x = 1, y = 0} },
			King = { atlas = 'csau_d_collab_DTD', pos = {x = 2, y = 0} },
			Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 2} }
		},
		loc_txt = {
			['en-us'] = "Cardsauce Colors"
		},
		colour = color.Diamonds,
		suit_icon = {
			atlas = 'csau_suits'
		}
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_DTD'], { key = 'csau_collab_DTD_shroom', ranks = full_ranks,
		display_ranks = face_ace, atlas = 'csau_default',
		pos_style = {
			fallback_style = 'deck',
			Jack = { atlas = 'csau_d_collab_DTD', pos = {x = 0, y = 0} },
			Queen = { atlas = 'csau_d_collab_DTD', pos = {x = 1, y = 0} },
			King = { atlas = 'csau_d_collab_DTD', pos = {x = 2, y = 0} },
		},
		loc_txt = {
			['en-us'] = "Cardsauce Colors & Shroom"
		},
		colour = color.Diamonds,
		suit_icon = {
			atlas = 'csau_suits'
		}
	})



	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_SV'], { key = 'csau_collab_SV', ranks = full_ranks,
	   display_ranks = face, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_d_collab_SV', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_d_collab_SV', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_d_collab_SV', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 2} }
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors"
	   },
	   colour = color.Diamonds,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_SV'], { key = 'csau_collab_SV_shroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_d_collab_SV', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_d_collab_SV', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_d_collab_SV', pos = {x = 2, y = 0} },
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors & Shroom"
	   },
	   colour = color.Diamonds,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})



	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_EG'], { key = 'csau_collab_EG', ranks = full_ranks,
	   display_ranks = face, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_d_collab_EG', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_d_collab_EG', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_d_collab_EG', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 2} }
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors"
	   },
	   colour = color.Diamonds,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_EG'], { key = 'csau_collab_EG_shroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_d_collab_EG', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_d_collab_EG', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_d_collab_EG', pos = {x = 2, y = 0} },
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors & Shroom"
	   },
	   colour = color.Diamonds,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})



	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_XR'], { key = 'csau_collab_XR', ranks = full_ranks,
	   display_ranks = face, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_d_collab_XR', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_d_collab_XR', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_d_collab_XR', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 2} }
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors"
	   },
	   colour = color.Diamonds,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_XR'], { key = 'csau_collab_XR_shroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_d_collab_XR', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_d_collab_XR', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_d_collab_XR', pos = {x = 2, y = 0} },
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors & Shroom"
	   },
	   colour = color.Diamonds,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})





	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_AU'], { key = 'csau_collab_AU', ranks = full_ranks,
	   display_ranks = face, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_h_collab_AU', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_h_collab_AU', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_h_collab_AU', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 0} }
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors"
	   },
	   colour = color.Hearts,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_AU'], { key = 'csau_collab_AU_shroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_h_collab_AU', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_h_collab_AU', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_h_collab_AU', pos = {x = 2, y = 0} },
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors & Shroom"
	   },
	   colour = color.Hearts,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})



	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_TBoI'], { key = 'csau_collab_TBoI', ranks = full_ranks,
		 display_ranks = face, atlas = 'csau_default',
		 pos_style = {
			 fallback_style = 'deck',
			 Jack = { atlas = 'csau_h_collab_TBoI', pos = {x = 0, y = 0} },
			 Queen = { atlas = 'csau_h_collab_TBoI', pos = {x = 1, y = 0} },
			 King = { atlas = 'csau_h_collab_TBoI', pos = {x = 2, y = 0} },
			 Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 0} }
		 },
		 loc_txt = {
			 ['en-us'] = "Cardsauce Colors"
		 },
		 colour = color.Hearts,
		 suit_icon = {
			 atlas = 'csau_suits'
		 }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_TBoI'], { key = 'csau_collab_TBoI_shroom', ranks = full_ranks,
		 display_ranks = face_ace, atlas = 'csau_default',
		 pos_style = {
			 fallback_style = 'deck',
			 Jack = { atlas = 'csau_h_collab_TBoI', pos = {x = 0, y = 0} },
			 Queen = { atlas = 'csau_h_collab_TBoI', pos = {x = 1, y = 0} },
			 King = { atlas = 'csau_h_collab_TBoI', pos = {x = 2, y = 0} },
		 },
		 loc_txt = {
			 ['en-us'] = "Cardsauce Colors & Shroom"
		 },
		 colour = color.Hearts,
		 suit_icon = {
			 atlas = 'csau_suits'
		 }
	})



	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_CL'], { key = 'csau_collab_CL', ranks = full_ranks,
	   display_ranks = face, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_h_collab_CL', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_h_collab_CL', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_h_collab_CL', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 0} }
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors"
	   },
	   colour = color.Hearts,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_CL'], { key = 'csau_collab_CL_shroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_h_collab_CL', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_h_collab_CL', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_h_collab_CL', pos = {x = 2, y = 0} },
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors & Shroom"
	   },
	   colour = color.Hearts,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})



	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_D2'], { key = 'csau_collab_D2', ranks = full_ranks,
	   display_ranks = face, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_h_collab_D2', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_h_collab_D2', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_h_collab_D2', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 0} }
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors"
	   },
	   colour = color.Hearts,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_D2'], { key = 'csau_collab_D2_shroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_h_collab_D2', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_h_collab_D2', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_h_collab_D2', pos = {x = 2, y = 0} },
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors & Shroom"
	   },
	   colour = color.Hearts,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})





	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_TW'], { key = 'csau_collab_TW', ranks = full_ranks,
	   display_ranks = face, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_s_collab_TW', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_s_collab_TW', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_s_collab_TW', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 3} }
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors"
	   },
	   colour = color.Spades,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_TW'], { key = 'csau_collab_TW_shroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_s_collab_TW', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_s_collab_TW', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_s_collab_TW', pos = {x = 2, y = 0} },
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors & Shroom"
	   },
	   colour = color.Spades,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})



	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_CYP'], { key = 'csau_collab_CYP', ranks = full_ranks,
		display_ranks = face, atlas = 'csau_default',
		pos_style = {
			fallback_style = 'deck',
			Jack = { atlas = 'csau_s_collab_CYP', pos = {x = 0, y = 0} },
			Queen = { atlas = 'csau_s_collab_CYP', pos = {x = 1, y = 0} },
			King = { atlas = 'csau_s_collab_CYP', pos = {x = 2, y = 0} },
			Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 3} }
		},
		loc_txt = {
			['en-us'] = "Cardsauce Colors"
		},
		colour = color.Spades,
		suit_icon = {
			atlas = 'csau_suits'
		}
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_CYP'], { key = 'csau_collab_CYP_shroom', ranks = full_ranks,
		display_ranks = face_ace, atlas = 'csau_default',
		pos_style = {
			fallback_style = 'deck',
			Jack = { atlas = 'csau_s_collab_CYP', pos = {x = 0, y = 0} },
			Queen = { atlas = 'csau_s_collab_CYP', pos = {x = 1, y = 0} },
			King = { atlas = 'csau_s_collab_CYP', pos = {x = 2, y = 0} },
		},
		loc_txt = {
			['en-us'] = "Cardsauce Colors & Shroom"
		},
		colour = color.Spades,
		suit_icon = {
			atlas = 'csau_suits'
		}
	})



	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_SK'], { key = 'csau_collab_SK', ranks = full_ranks,
	   display_ranks = face, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_s_collab_SK', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_s_collab_SK', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_s_collab_SK', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 3} }
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors"
	   },
	   colour = color.Spades,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_SK'], { key = 'csau_collab_SK_shroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_s_collab_SK', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_s_collab_SK', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_s_collab_SK', pos = {x = 2, y = 0} },
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors & Shroom"
	   },
	   colour = color.Spades,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})



	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_DS'], { key = 'csau_collab_DS', ranks = full_ranks,
	   display_ranks = face, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_s_collab_DS', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_s_collab_DS', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_s_collab_DS', pos = {x = 2, y = 0} },
		   Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 3} }
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors"
	   },
	   colour = color.Spades,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['collab_DS'], { key = 'csau_collab_DS_shroom', ranks = full_ranks,
	   display_ranks = face_ace, atlas = 'csau_default',
	   pos_style = {
		   fallback_style = 'deck',
		   Jack = { atlas = 'csau_s_collab_DS', pos = {x = 0, y = 0} },
		   Queen = { atlas = 'csau_s_collab_DS', pos = {x = 1, y = 0} },
		   King = { atlas = 'csau_s_collab_DS', pos = {x = 2, y = 0} },
	   },
	   loc_txt = {
		   ['en-us'] = "Cardsauce Colors & Shroom"
	   },
	   colour = color.Spades,
	   suit_icon = {
		   atlas = 'csau_suits'
	   }
	})

	for _, suit in ipairs(suits) do
		local palettes = {}
		palettes[#palettes+1] = {
			key = 'csau_def_'..suit,
			ranks = full_ranks,
			display_ranks = face_ace,
			atlas = 'csau_default',
			pos_style = 'deck',
			loc_txt = {
				['en-us'] = "Cardsauce Colors"
			},
			colour = color[suit:gsub("^%l", string.upper)],
			suit_icon = {
				atlas = 'csau_suits'
			}
		}
		if suit == 'clubs' then
			palettes[#palettes+1] = {
				key = 'csau_vineshroom',
				ranks = full_ranks,
				display_ranks = face_ace,
				atlas = 'csau_default',
				pos_style = {
					fallback_style = 'deck',
					Ace = {
						atlas = 'csau_c_vineshroom',
						pos = {x = 0, y = 0}
					}
				},
				loc_txt = {
					['en-us'] = "Vineshroom Ace"
				},
				colour = color[suit:gsub("^%l", string.upper)],
				suit_icon = {
					atlas = 'csau_suits'
				}
			}
		end
		palettes[#palettes+1] = {
			key = 'csau_baldef_'..suit.."_lc",
			ranks = full_ranks,
			display_ranks = face_ace,
			atlas = 'cards_1',
			pos_style = {
				fallback_style = 'deck',
				Ace = {
					atlas = 'csau_balcolor_shrooms_lc',
					pos = {x = 0, y = (suit == 'hearts' and 0) or (suit == 'clubs' and 1) or (suit == 'diamonds' and 2) or (suit == 'spades' and 3)}
				}
			},
			loc_txt = {
				['en-us'] = "Low Contrast Shrooms"
			},
			colour = G.C.SO_1[suit:gsub("^%l", string.upper)],
			suit_icon = {
				atlas = 'ui_1',
				pos = 1
			}
		}
		palettes[#palettes+1] = {
			key = 'csau_baldef_'..suit.."_hc",
			ranks = full_ranks,
			display_ranks = face_ace,
			atlas = 'cards_2',
			pos_style = {
				fallback_style = 'deck',
				Ace = {
					atlas = 'csau_balcolor_shrooms_hc',
					pos = {x = 0, y = (suit == 'hearts' and 0) or (suit == 'clubs' and 1) or (suit == 'diamonds' and 2) or (suit == 'spades' and 3)}
				}
			},
			loc_txt = {
				['en-us'] = "High Contrast Shrooms"
			},
			colour = G.C.SO_2[suit:gsub("^%l", string.upper)],
			suit_icon = {
				atlas = 'ui_2',
				pos = 1
			}
		}
		SMODS.DeckSkin{
			key = "csau_default_"..suit,
			suit = suit:gsub("^%l", string.upper),
			palettes = palettes,
			loc_txt = {
				['en-us'] = (suit == 'clubs' and "Main Channel") or (suit == 'hearts' and "Extrasauce") or (suit == 'diamonds' and "Fullsauce") or (suit == 'spades' and "Twitch Clips")
			},
			prefix_config = { key = false },
		}



		SMODS.DeckSkin.add_palette(SMODS.DeckSkins['default_'..suit:gsub("^%l", string.upper)], {
			key = 'csau_color_'..suit,
			ranks = full_ranks,
			display_ranks = face_ace,
			atlas = 'csau_default',
			pos_style = {
				fallback_style = 'deck',
				Ace = {
					atlas = 'csau_color_aces',
					pos = {x = 0, y = (suit == 'hearts' and 0) or (suit == 'clubs' and 1) or (suit == 'diamonds' and 2) or (suit == 'spades' and 3)}
				}
			},
			loc_txt = {
				['en-us'] = "Cardsauce Colors"
			},
			colour = color[suit:gsub("^%l", string.upper)],
			suit_icon = {
				atlas = 'csau_suits'
			}
		})
	end
	if twoPointO then
		for _, suit in ipairs(suits) do
			local palettes = {}
			palettes[#palettes+1] = {
				key = 'csau_def_varg_'..suit,
				ranks = full_ranks,
				display_ranks = face_ace,
				atlas = 'csau_default',
				pos_style = {
					fallback_style = 'deck',
					Ace = {
						atlas = 'csau_varg_aces',
						pos = {x = 0, y = (suit == 'hearts' and 0) or (suit == 'clubs' and 1) or (suit == 'diamonds' and 2) or (suit == 'spades' and 3)}
					}
				},
				loc_txt = {
					['en-us'] = "Cardsauce Colors"
				},
				colour = color[suit:gsub("^%l", string.upper)],
				suit_icon = {
					atlas = 'csau_suits'
				}
			}
			if suit == 'hearts' then
				palettes[#palettes+1] = {
					key = 'csau_varg_willo',
					ranks = full_ranks,
					display_ranks = face_ace,
					atlas = 'csau_varg_willo',
					pos_style = 'suit',
					loc_txt = {
						['en-us'] = "Mini Highlights"
					},
					colour = HEX('b4665c'),
					suit_icon = {
						atlas = 'csau_hearts_willo'
					}
				}
			end
			palettes[#palettes+1] = {
				key = 'csau_baldef_varg_'..suit.."_lc",
				ranks = full_ranks,
				display_ranks = face_ace,
				atlas = 'cards_1',
				pos_style = {
					fallback_style = 'deck',
					Ace = {
						atlas = 'csau_balcolor_varg_lc',
						pos = {x = 0, y = (suit == 'hearts' and 0) or (suit == 'clubs' and 1) or (suit == 'diamonds' and 2) or (suit == 'spades' and 3)}
					}
				},
				loc_txt = {
					['en-us'] = "Low Contrast Shrooms"
				},
				colour = G.C.SO_1[suit:gsub("^%l", string.upper)],
				suit_icon = {
					atlas = 'ui_1',
					pos = 1
				}
			}
			palettes[#palettes+1] = {
				key = 'csau_baldef_varg_'..suit.."_hc",
				ranks = full_ranks,
				display_ranks = face_ace,
				atlas = 'cards_2',
				pos_style = {
					fallback_style = 'deck',
					Ace = {
						atlas = 'csau_balcolor_varg_hc',
						pos = {x = 0, y = (suit == 'hearts' and 0) or (suit == 'clubs' and 1) or (suit == 'diamonds' and 2) or (suit == 'spades' and 3)}
					}
				},
				loc_txt = {
					['en-us'] = "High Contrast Shrooms"
				},
				colour = G.C.SO_2[suit:gsub("^%l", string.upper)],
				suit_icon = {
					atlas = 'ui_2',
					pos = 1
				}
			}
			SMODS.DeckSkin{
				key = "default_varg_"..suit,
				suit = suit:gsub("^%l", string.upper),
				palettes = palettes,
				loc_txt = {
					['en-us'] = (suit == 'clubs' and "Main Channel") or (suit == 'hearts' and "Extravarg?") or (suit == 'diamonds' and "Uncut") or (suit == 'spades' and "Twitch Clips")
				},
				prefix_config = { key = false },
			}
		end
	end

	-- Vine Characters
	SMODS.DeckSkin{
		key = "csau_mascots",
		suit = "Clubs",
		palettes = {
			{
				key = 'csau_mascots', ranks = full_ranks,
				display_ranks = face_ace, atlas = 'csau_default',
				pos_style = {
					fallback_style = 'deck',
					Jack = { atlas = 'csau_c_mascots', pos = {x = 0, y = 0} },
					Queen = { atlas = 'csau_c_mascots', pos = {x = 1, y = 0} },
					King = { atlas = 'csau_c_mascots', pos = {x = 2, y = 0} },
				},
				loc_txt = {
					['en-us'] = "Cardsauce Colors"
				},
				colour = color.Clubs,
				suit_icon = {
					atlas = 'csau_suits'
				}
			},
			{
				key = 'csau_mascots_vineshroom', ranks = full_ranks,
				display_ranks = face_ace, atlas = 'csau_default',
				pos_style = {
					fallback_style = 'deck',
					Jack = { atlas = 'csau_c_mascots', pos = {x = 0, y = 0} },
					Queen = { atlas = 'csau_c_mascots', pos = {x = 1, y = 0} },
					King = { atlas = 'csau_c_mascots', pos = {x = 2, y = 0} },
					Ace = { atlas = 'csau_c_vineshroom', pos = {x = 0, y = 0} }
				},
				loc_txt = {
					['en-us'] = "Vineshroom"
				},
				colour = color.Clubs,
				suit_icon = {
					atlas = 'csau_suits'
				}
			},
			{
				key = 'csau_mascots_ace', ranks = full_ranks,
				display_ranks = face_ace, atlas = 'csau_default',
				pos_style = {
					fallback_style = 'deck',
					Jack = { atlas = 'csau_c_mascots', pos = {x = 0, y = 0} },
					Queen = { atlas = 'csau_c_mascots', pos = {x = 1, y = 0} },
					King = { atlas = 'csau_c_mascots', pos = {x = 2, y = 0} },
					Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 1} }
				},
				loc_txt = {
					['en-us'] = "Vanilla Ace"
				},
				colour = color.Clubs,
				suit_icon = {
					atlas = 'csau_suits'
				}
			},
		},
		loc_txt = {
			['en-us'] = "The Mascots"
		}
	}
	SMODS.DeckSkin{
		key = "csau_classics",
		suit = "Diamonds",
		palettes = {
			{
				key = 'csau_classics', ranks = full_ranks,
				display_ranks = face_ace, atlas = 'csau_default',
				pos_style = {
					fallback_style = 'deck',
					Jack = { atlas = 'csau_d_classics', pos = {x = 0, y = 0} },
					Queen = { atlas = 'csau_d_classics', pos = {x = 1, y = 0} },
					King = { atlas = 'csau_d_classics', pos = {x = 2, y = 0} },
				},
				loc_txt = {
					['en-us'] = "Cardsauce Colors"
				},
				colour = color.Diamonds,
				suit_icon = {
					atlas = 'csau_suits'
				}
			},
			{
				key = 'csau_classics_ace', ranks = full_ranks,
				display_ranks = face_ace, atlas = 'csau_default',
				pos_style = {
					fallback_style = 'deck',
					Jack = { atlas = 'csau_d_classics', pos = {x = 0, y = 0} },
					Queen = { atlas = 'csau_d_classics', pos = {x = 1, y = 0} },
					King = { atlas = 'csau_d_classics', pos = {x = 2, y = 0} },
					Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 2} }
				},
				loc_txt = {
					['en-us'] = "Vanilla Ace"
				},
				colour = color.Diamonds,
				suit_icon = {
					atlas = 'csau_suits'
				}
			},
		},
		loc_txt = {
			['en-us'] = "The Classics"
		}
	}
	SMODS.DeckSkin{
		key = "csau_wildcards",
		suit = "Hearts",
		palettes = {
			{
				key = 'csau_wildcards', ranks = full_ranks,
				display_ranks = face_ace, atlas = 'csau_default',
				pos_style = {
					fallback_style = 'deck',
					Jack = { atlas = 'csau_h_wildcards', pos = {x = 0, y = 0} },
					Queen = { atlas = 'csau_h_wildcards', pos = {x = 1, y = 0} },
					King = { atlas = 'csau_h_wildcards', pos = {x = 2, y = 0} },
				},
				loc_txt = {
					['en-us'] = "Cardsauce Colors"
				},
				colour = color.Hearts,
				suit_icon = {
					atlas = 'csau_suits'
				}
			},
			{
				key = 'csau_wildcards_ace', ranks = full_ranks,
				display_ranks = face_ace, atlas = 'csau_default',
				pos_style = {
					fallback_style = 'deck',
					Jack = { atlas = 'csau_h_wildcards', pos = {x = 0, y = 0} },
					Queen = { atlas = 'csau_h_wildcards', pos = {x = 1, y = 0} },
					King = { atlas = 'csau_h_wildcards', pos = {x = 2, y = 0} },
					Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 0} }
				},
				loc_txt = {
					['en-us'] = "Vanilla Ace"
				},
				colour = color.Hearts,
				suit_icon = {
					atlas = 'csau_suits'
				}
			},
		},
		loc_txt = {
			['en-us'] = "The Wildcards"
		}
	}
	SMODS.DeckSkin{
		key = "csau_confidants",
		suit = "Spades",
		palettes = {
			{
				key = 'csau_confidants', ranks = full_ranks,
				display_ranks = face_ace, atlas = 'csau_default',
				pos_style = {
					fallback_style = 'deck',
					Jack = { atlas = 'csau_s_confidants', pos = {x = 0, y = 0} },
					Queen = { atlas = 'csau_s_confidants', pos = {x = 1, y = 0} },
					King = { atlas = 'csau_s_confidants', pos = {x = 2, y = 0} },
				},
				loc_txt = {
					['en-us'] = "Cardsauce Colors"
				},
				colour = color.Spades,
				suit_icon = {
					atlas = 'csau_suits'
				}
			},
			{
				key = 'csau_confidants_ace', ranks = full_ranks,
				display_ranks = face_ace, atlas = 'csau_default',
				pos_style = {
					fallback_style = 'deck',
					Jack = { atlas = 'csau_s_confidants', pos = {x = 0, y = 0} },
					Queen = { atlas = 'csau_s_confidants', pos = {x = 1, y = 0} },
					King = { atlas = 'csau_s_confidants', pos = {x = 2, y = 0} },
					Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 3} }
				},
				loc_txt = {
					['en-us'] = "Vanilla Ace"
				},
				colour = color.Spades,
				suit_icon = {
					atlas = 'csau_suits'
				}
			},
		},
		loc_txt = {
			['en-us'] = "The Confidants"
		}
	}

	if twoPointO then
		-- Varg Characters
		SMODS.DeckSkin{
			key = "csau_voices",
			suit = "Clubs",
			palettes = {
				{
					key = 'csau_voices', ranks = full_ranks,
					display_ranks = face_ace, atlas = 'csau_default',
					pos_style = {
						fallback_style = 'deck',
						Jack = { atlas = 'csau_c_voices', pos = {x = 0, y = 0} },
						Queen = { atlas = 'csau_c_voices', pos = {x = 1, y = 0} },
						King = { atlas = 'csau_c_voices', pos = {x = 2, y = 0} },
						Ace = { atlas = 'csau_varg_aces', pos = {x = 0, y = 1} }
					},
					loc_txt = {
						['en-us'] = "Cardsauce Colors"
					},
					colour = color.Clubs,
					suit_icon = {
						atlas = 'csau_suits'
					}
				},
				{
					key = 'csau_voices_ace', ranks = full_ranks,
					display_ranks = face_ace, atlas = 'csau_default',
					pos_style = {
						fallback_style = 'deck',
						Jack = { atlas = 'csau_c_voices', pos = {x = 0, y = 0} },
						Queen = { atlas = 'csau_c_voices', pos = {x = 1, y = 0} },
						King = { atlas = 'csau_c_voices', pos = {x = 2, y = 0} },
						Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 1} }
					},
					loc_txt = {
						['en-us'] = "Vanilla Ace"
					},
					colour = color.Clubs,
					suit_icon = {
						atlas = 'csau_suits'
					}
				},
			},
			loc_txt = {
				['en-us'] = "The Voices"
			}
		}
		SMODS.DeckSkin{
			key = "csau_duendes",
			suit = "Diamonds",
			palettes = {
				{
					key = 'csau_duendes', ranks = full_ranks,
					display_ranks = face_ace, atlas = 'csau_default',
					pos_style = {
						fallback_style = 'deck',
						Jack = { atlas = 'csau_d_duendes', pos = {x = 0, y = 0} },
						Queen = { atlas = 'csau_d_duendes', pos = {x = 1, y = 0} },
						King = { atlas = 'csau_d_duendes', pos = {x = 2, y = 0} },
						Ace = { atlas = 'csau_varg_aces', pos = {x = 0, y = 2} }
					},
					loc_txt = {
						['en-us'] = "Cardsauce Colors"
					},
					colour = color.Diamonds,
					suit_icon = {
						atlas = 'csau_suits'
					}
				},
				{
					key = 'csau_duendes_ace', ranks = full_ranks,
					display_ranks = face_ace, atlas = 'csau_default',
					pos_style = {
						fallback_style = 'deck',
						Jack = { atlas = 'csau_d_duendes', pos = {x = 0, y = 0} },
						Queen = { atlas = 'csau_d_duendes', pos = {x = 1, y = 0} },
						King = { atlas = 'csau_d_duendes', pos = {x = 2, y = 0} },
						Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 2} }
					},
					loc_txt = {
						['en-us'] = "Vanilla Ace"
					},
					colour = color.Diamonds,
					suit_icon = {
						atlas = 'csau_suits'
					}
				},
			},
			loc_txt = {
				['en-us'] = "The Duendes"
			}
		}
		SMODS.DeckSkin{
			key = "csau_americans",
			suit = "Hearts",
			palettes = {
				{
					key = 'csau_americans', ranks = full_ranks,
					display_ranks = face_ace, atlas = 'csau_default',
					pos_style = {
						fallback_style = 'deck',
						Jack = { atlas = 'csau_h_americans', pos = {x = 0, y = 0} },
						Queen = { atlas = 'csau_h_americans', pos = {x = 1, y = 0} },
						King = { atlas = 'csau_h_americans', pos = {x = 2, y = 0} },
						Ace = { atlas = 'csau_varg_aces', pos = {x = 0, y = 0} }
					},
					loc_txt = {
						['en-us'] = "Cardsauce Colors"
					},
					colour = color.Hearts,
					suit_icon = {
						atlas = 'csau_suits'
					}
				},
				{
					key = 'csau_americans_ace', ranks = full_ranks,
					display_ranks = face_ace, atlas = 'csau_default',
					pos_style = {
						fallback_style = 'deck',
						Jack = { atlas = 'csau_h_americans', pos = {x = 0, y = 0} },
						Queen = { atlas = 'csau_h_americans', pos = {x = 1, y = 0} },
						King = { atlas = 'csau_h_americans', pos = {x = 2, y = 0} },
						Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 0} }
					},
					loc_txt = {
						['en-us'] = "Vanilla Ace"
					},
					colour = color.Hearts,
					suit_icon = {
						atlas = 'csau_suits'
					}
				},
			},
			loc_txt = {
				['en-us'] = "The Americans"
			}
		}
		SMODS.DeckSkin{
			key = "csau_powerful",
			suit = "Spades",
			palettes = {
				{
					key = 'csau_powerful', ranks = full_ranks,
					display_ranks = face_ace, atlas = 'csau_default',
					pos_style = {
						fallback_style = 'deck',
						Jack = { atlas = 'csau_s_powerful', pos = {x = 0, y = 0} },
						Queen = { atlas = 'csau_s_powerful', pos = {x = 1, y = 0} },
						King = { atlas = 'csau_s_powerful', pos = {x = 2, y = 0} },
						Ace = { atlas = 'csau_varg_aces', pos = {x = 0, y = 3} }
					},
					loc_txt = {
						['en-us'] = "Cardsauce Colors"
					},
					colour = color.Spades,
					suit_icon = {
						atlas = 'csau_suits'
					}
				},
				{
					key = 'csau_confidants_ace', ranks = full_ranks,
					display_ranks = face_ace, atlas = 'csau_default',
					pos_style = {
						fallback_style = 'deck',
						Jack = { atlas = 'csau_s_powerful', pos = {x = 0, y = 0} },
						Queen = { atlas = 'csau_s_powerful', pos = {x = 1, y = 0} },
						King = { atlas = 'csau_s_powerful', pos = {x = 2, y = 0} },
						Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 3} }
					},
					loc_txt = {
						['en-us'] = "Vanilla Ace"
					},
					colour = color.Spades,
					suit_icon = {
						atlas = 'csau_suits'
					}
				},
			},
			loc_txt = {
				['en-us'] = "The Powerful"
			}
		}
	end

	-- Mike Characters
	SMODS.DeckSkin{
		key = "csau_poops",
		suit = "Hearts",
		palettes = {
			{
				key = 'csau_poops', ranks = full_ranks,
				display_ranks = face_ace, atlas = 'csau_default',
				pos_style = {
					fallback_style = 'deck',
					Jack = { atlas = 'csau_h_poops', pos = {x = 0, y = 0} },
					Queen = { atlas = 'csau_h_poops', pos = {x = 1, y = 0} },
					King = { atlas = 'csau_h_poops', pos = {x = 2, y = 0} },
				},
				loc_txt = {
					['en-us'] = "Cardsauce Colors"
				},
				colour = color.Hearts,
				suit_icon = {
					atlas = 'csau_suits'
				}
			},
			{
				key = 'csau_poops_ace', ranks = full_ranks,
				display_ranks = face_ace, atlas = 'csau_default',
				pos_style = {
					fallback_style = 'deck',
					Jack = { atlas = 'csau_h_poops', pos = {x = 0, y = 0} },
					Queen = { atlas = 'csau_h_poops', pos = {x = 1, y = 0} },
					King = { atlas = 'csau_h_poops', pos = {x = 2, y = 0} },
					Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 0} }
				},
				loc_txt = {
					['en-us'] = "Vanilla Ace"
				},
				colour = color.Hearts,
				suit_icon = {
					atlas = 'csau_suits'
				}
			},
		},
		loc_txt = {
			['en-us'] = "The Poops"
		}
	}
	if twoPointO then
		SMODS.DeckSkin{
			key = "csau_ocs",
			suit = "Spades",
			palettes = {
				{
					key = 'csau_ocs', ranks = full_ranks,
					display_ranks = face_ace, atlas = 'csau_default',
					pos_style = {
						fallback_style = 'deck',
						Jack = { atlas = 'csau_s_ocs', pos = {x = 0, y = 0} },
						Queen = { atlas = 'csau_s_ocs', pos = {x = 1, y = 0} },
						King = { atlas = 'csau_s_ocs', pos = {x = 2, y = 0} },
					},
					loc_txt = {
						['en-us'] = "Cardsauce Colors"
					},
					colour = color.Spades,
					suit_icon = {
						atlas = 'csau_suits'
					}
				},
				{
					key = 'csau_ocs_ace', ranks = full_ranks,
					display_ranks = face_ace, atlas = 'csau_default',
					pos_style = {
						fallback_style = 'deck',
						Jack = { atlas = 'csau_s_ocs', pos = {x = 0, y = 0} },
						Queen = { atlas = 'csau_s_ocs', pos = {x = 1, y = 0} },
						King = { atlas = 'csau_s_ocs', pos = {x = 2, y = 0} },
						Ace = { atlas = 'csau_color_aces', pos = {x = 0, y = 0} }
					},
					loc_txt = {
						['en-us'] = "Vanilla Ace"
					},
					colour = color.Hearts,
					suit_icon = {
						atlas = 'csau_suits'
					}
				},
			},
			loc_txt = {
				['en-us'] = "The OCs"
			}
		}
	end

	if not G.SETTINGS.initCSAUColors then
		G.SETTINGS.CUSTOM_DECK.Collabs.Spades = "csau_default_spades"
		G.SETTINGS.CUSTOM_DECK.Collabs.Hearts = "csau_default_hearts"
		G.SETTINGS.CUSTOM_DECK.Collabs.Diamonds = "csau_default_diamonds"
		G.SETTINGS.CUSTOM_DECK.Collabs.Clubs = "csau_default_clubs"
		if not G.SETTINGS.colourpalettes then
			G.SETTINGS.colourpalettes = {}
		end
		G.SETTINGS.colourpalettes.Spades = "csau_def_spades"
		G.SETTINGS.colourpalettes.Hearts = "csau_def_hearts"
		G.SETTINGS.colourpalettes.Diamonds = "csau_def_diamonds"
		G.SETTINGS.colourpalettes.Clubs = "csau_def_clubs"
		G.SETTINGS.initCSAUColors = true
		G.save_settings()
	end
end

if csau_enabled['enableMusic'] then
	SMODS.Sound({
		vol = 0.6,
		pitch = 1,
		key = "csau_music1",
		path = "csau_music1.ogg",
		select_music_track = function()
			return (G.SETTINGS.music_selection == "cardsauce") and 10 or false
		end,
	})
	SMODS.Sound({
		vol = 0.6,
		pitch = 1,
		key = "csau_music2",
		path = "csau_music2.ogg",
		select_music_track = function()
			return (G.SETTINGS.music_selection == "cardsauce" and G.booster_pack_sparkles and not G.booster_pack_sparkles.REMOVED) and 11 or false
		end,
	})
	SMODS.Sound({
		vol = 0.6,
		pitch = 1,
		key = "csau_music3",
		path = "csau_music3.ogg",
		select_music_track = function()
			return (G.SETTINGS.music_selection == "cardsauce" and G.booster_pack_meteors and not G.booster_pack_meteors.REMOVED) and 11 or false
		end,
	})
	SMODS.Sound({
		vol = 0.6,
		pitch = 1,
		key = "csau_music4",
		path = "csau_music4.ogg",
		select_music_track = function()
			return (G.SETTINGS.music_selection == "cardsauce" and G.shop and not G.shop.REMOVED) and 11 or false
		end,
	})
	SMODS.Sound({
		vol = 0.6,
		pitch = 1,
		key = "csau_music5",
		path = "csau_music5.ogg",
		select_music_track = function()
			return (G.SETTINGS.music_selection == "cardsauce" and G.GAME.blind and G.GAME.blind.boss) and 11 or false
		end,
	})
end

SMODS.Sound({
	key = "vhsopen",
	path = "vhsopen.ogg",
})

SMODS.Sound({
	key = "vhsclose",
	path = "vhsclose.ogg",
})

if csau_enabled['enableEasterEggs'] then
	SMODS.Atlas({
		key = "jimbo_shot",
		atlas_table = "ASSET_ATLAS",
		path = "jimbo_shot.png",
		px = 71,
		py = 95
	})

	SMODS.Sound({
		key = "gunshot",
		path = "gunshot.ogg",
		pitch = 1,
		volume = 0.7
	})
	local initref = Card_Character.init
	function Card_Character:init(args)
		initref(self, args)
		self.children.card.click = Card.gunshot_func
	end

	function Card:gunshot_func()
		if G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot') then
			play_sound("csau_gunshot", 1, 1)
			self.children.center.atlas = G.ASSET_ATLAS["csau_jimbo_shot"]
			self.children.center:set_sprite_pos({x = 0, y = 0})
			self:juice_up()

			if not G.GAME.shot_jimbo then
				for k, v in pairs(G.I.CARD) do
					if getmetatable(v) == Card_Character then
						v.children.particles = Particles(0, 0, 0,0, {
							timer = 0.01,
							scale = 0.3,
							speed = 2,
							lifespan = 4,
							attach = v,
							colours = {G.C.RED, G.C.RED, G.C.RED},
							fill = true
						})
						v:remove_speech_bubble()
						v.talking = false
					end
				end
			end

			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 2,
				func = (function()
					check_for_unlock({ type = "fuckingkill_jimbo" })
					return true
				end)}))

			G.GAME.shot_jimbo = true
		end
	end
end

G.FUNCS.reset_trophies = function(e)
	local warning_text = e.UIBox:get_UIE_by_ID('warn')
	if warning_text.config.colour ~= G.C.WHITE then
		warning_text:juice_up()
		warning_text.config.colour = G.C.WHITE
		warning_text.config.shadow = true
		e.config.disable_button = true
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06, blockable = false, blocking = false, func = function()
			play_sound('tarot2', 0.76, 0.4);return true end}))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.35, blockable = false, blocking = false, func = function()
			e.config.disable_button = nil;return true end}))
		play_sound('tarot2', 1, 0.4)
	else
		G.FUNCS.wipe_on()
		for k, v in pairs(SMODS.Achievements) do
			if starts_with(k, 'ach_csau_') then
				G.SETTINGS.ACHIEVEMENTS_EARNED[k] = nil
				G.ACHIEVEMENTS[k].earned = nil
			end
		end
		G:save_settings()
		G.E_MANAGER:add_event(Event({
			delay = 1,
			func = function()
				G.FUNCS.wipe_off()
				return true
			end
		}))
	end
end

local function config_matching()
	for k, v in pairs(csau_enabled) do
		if v ~= csau_config[k] then
			return false
		end
	end
	return true
end

function G.FUNCS.csau_restart()
	if config_matching() then
		send("SETTINGS MATCH :)")
		SMODS.full_restart = 0
	else
		send("SETTINGS DONT MATCH!")
		SMODS.full_restart = 1
	end
end

local text_scale = 0.9
local csauConfigTabs = function() return {
	{
		label = localize("b_options"),
		chosen = true,
		tab_definition_function = function()
			local csau_opts = { n = G.UIT.C, config = { align = "tm", padding = 0.05 }, nodes = {
				{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
					{n=G.UIT.T, config={text = localize("b_options"), scale = text_scale*0.9, colour = G.C.GREEN, shadow = true}},
				}},
				--[[{n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
					{n=G.UIT.T, config={text = localize("vs_options_sub"), scale = text_scale*0.5, colour = G.C.GREEN, shadow = true}},
				}},]]--
			}}
			if localize("vs_options_muteWega") then
				csau_opts.nodes[#csau_opts.nodes+1] = {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
					{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
						create_toggle({n=G.UIT.T, label = localize("vs_options_muteWega"), ref_table = csau_config, ref_value = 'muteWega' })
					}},
					{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
						{n=G.UIT.T, config={text = localize("vs_options_muteWega_desc"), scale = text_scale*0.35, colour = G.C.JOKER_GREY, shadow = true}}
					}},
				}}
			end
			if localize("vs_options_detailedDescs") then
				csau_opts.nodes[#csau_opts.nodes+1] = {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
					{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
						create_toggle({n=G.UIT.T, label = localize("vs_options_detailedDescs"), ref_table = csau_config, ref_value = 'detailedDescs' })
					}},
					{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
						{n=G.UIT.T, config={text = localize("vs_options_detailedDescs_desc"), scale = text_scale*0.35, colour = G.C.JOKER_GREY, shadow = true}}
					}},
				}}
			end
			if localize("vs_options_resetTrophies_r") then
				csau_opts.nodes[#csau_opts.nodes+1] = {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
					{n=G.UIT.R, config={align = "cm", minw = 0.5, maxw = 2, minh = 0.6, padding = 0, r = 0.1, hover = true, colour = G.C.RED, button = "reset_trophies", shadow = true, focus_args = {nav = 'wide'}}, nodes={
						{n=G.UIT.T, config={text = localize("vs_options_resetTrophies_r"), scale = text_scale*0.55, colour = G.C.UI.TEXT_LIGHT}}
					}},
					{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
						{n=G.UIT.T, config={text = localize("vs_options_resetTrophies_desc"), scale = text_scale*0.35, colour = G.C.JOKER_GREY, shadow = true}}
					}},
				}}
			end
			csau_opts.nodes[#csau_opts.nodes+1] = {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
				{n=G.UIT.T, config={id = 'warn', text = localize('ph_click_confirm'), scale = 0.4, colour = G.C.CLEAR}}
			}}
			return {
				n = G.UIT.ROOT,
				config = {
					emboss = 0.05,
					minh = 6,
					r = 0.1,
					minw = 10,
					align = "cm",
					padding = 0.05,
					colour = G.C.BLACK,
				},
				nodes = {
					csau_opts
				}
			}
		end
	}
} end

SMODS.current_mod.extra_tabs = csauConfigTabs


SMODS.current_mod.config_tab = function()
	local ordered_config = {
		'enableVinkers',
		'enableJoelkers',
		'enableOtherJokers',
		'enableSpectrals',
		'enableBosses',
		'enableDecks',
		'enableSkins',
		'enableChallenges',
		'enableMusic',
		'enableTrophies',
		'enableLogo',
		'enableColors',
		'enableTarotSkins',
		'enableEasterEggs',
	}
	local left_settings = { n = G.UIT.C, config = { align = "tm", padding = 0.05 }, nodes = {} }
	local right_settings = { n = G.UIT.C, config = { align = "tm", padding = 0.05 }, nodes = {} }
	for i, k in ipairs(ordered_config) do
		if #right_settings.nodes < #left_settings.nodes then
			right_settings.nodes[#right_settings.nodes + 1] = create_toggle({ label = localize("vs_options_"..ordered_config[i]), ref_table = csau_config, ref_value = ordered_config[i], callback = G.FUNCS.csau_restart})
		else
			left_settings.nodes[#left_settings.nodes + 1] = create_toggle({ label = localize("vs_options_"..ordered_config[i]), ref_table = csau_config, ref_value = ordered_config[i], callback = G.FUNCS.csau_restart})
		end
	end
	local csau_config_ui = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { left_settings, right_settings } }
	return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "cm",
			padding = 0.05,
			colour = G.C.BLACK,
		},
		nodes = {
			csau_config_ui
		}
	}
end

vs_credit_1 = "BarrierTrio/Gote"
vs_credit_2 = "DPS2004"
vs_credit_3 = "SagaciousCejai"
vs_credit_4 = "Nether"
vs_credit_5 = "Mysthaps"
vs_credit_6 = "Numbuh214"
vs_credit_7 = "Aurelius7309"
vs_credit_8 = "Austin L. Matthews"
vs_credit_8_tag = "(AmtraxVA)"
vs_credit_9 = "Lyman"
vs_credit_9_from = "(JankJonklers)"
vs_credit_10 = "Akai"
vs_credit_10_from = "(Balatrostuck)"
vs_credit_5_from = "(LobotomyCorp)"
vs_credit_12 = "Victin"
vs_credit_12_from = "(Victin's Collection)"
vs_credit_13 = "Keku"
vs_credit_14 = "Gappie"
vs_credit_15 = "Winter Grimwell"
vs_credit_16 = "FenixSeraph"
vs_credit_17 = "WhimsyCherry"
vs_credit_18 = "Global-Trance"
vs_credit_19 = "Lyzerus"
vs_credit_20 = "Bassclefff"
vs_credit_20_tag = "(bassclefff.bandcamp.com)"
vs_credit_21 = "fradavovan"
vs_credit_22 = "Greeeg"
vs_credit_23 = "CheesyDraws"
vs_credit_24 = "Jazz_Jen"
vs_credit_25 = "BardVergil"
vs_credit_26 = "GuffNFluff"
vs_credit_27 = "sinewuui"
vs_credit_28 = "Swizik"
vs_credit_29 = "Burdrehnar"
vs_credit_30 = "Crisppyboat"
vs_credit_31 = "Alli"
vs_credit_32 = "Lyman"
vs_credit_33 = "AlizarinRed"
vs_credit_st1 = "tortoise"
vs_credit_st2 = "Protokyuuu"
vs_credit_st3 = "ShrineFox"
vs_credit_st4 = "cyrobolic"
vs_credit_st5 = "ReconBox"
vs_credit_st6 = "SinCityAssassin"

local header_scale = 1.1
local bonus_padding = 1.15
local support_padding = 0.015
local artist_size = 0.43

SMODS.current_mod.credits_tab = function()
	chosen = true
	return {n=G.UIT.ROOT, config={align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.1, emboss = 0.05, minh = 6, minw = 10}, nodes={
		{n = G.UIT.C, config = { align = "tm", padding = 0.2 }, nodes = {
			{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
				{n=G.UIT.T, config={text = localize("b_credits"), scale = text_scale*1.2, colour = G.C.GREEN, shadow = true}},
			}},
			{n=G.UIT.R, config={align = "cm", padding = 0.05,outline_colour = G.C.GREEN, r = 0.1, outline = 1}, nodes= {
				{n=G.UIT.C, config={align = "tm", padding = 0.1, r = 0.1}, nodes={
					{n=G.UIT.C, config={align = "tm", padding = 0}, nodes={
						{n=G.UIT.R, config={align = "tm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
							{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = localize('vs_credits1'), scale = header_scale * 0.5, colour = G.C.GOLD, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "cm", padding = 0}, nodes= {
								{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = vs_credit_1, scale = text_scale*0.55, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
								}},
								{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = vs_credit_13, scale = text_scale*0.55, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
								}},
							}},
						}},
						{n=G.UIT.R, config={align = "tm", padding = 0,outline_colour = G.C.CLEAR, r = 0.1, outline = 1}, nodes={
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = "SEPARATOR LMAO", scale = text_scale*0.4, colour = G.C.CLEAR, shadow = true}},
							}},
						}},
						{n=G.UIT.R, config={align = "tm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
							{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = localize('vs_credits7'), scale = header_scale * 0.6, colour = G.C.RED, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "cm", padding = 0}, nodes= {
								{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = vs_credit_20, scale = text_scale*0.55, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
								}},
								{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = vs_credit_20_tag, scale = text_scale*0.45, colour = G.C.JOKER_GREY, shadow = true}},
								}},
								{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = "SEPARATOR LMAO", scale = text_scale*0.05, colour = G.C.CLEAR, shadow = true}},
								}},
							}},
						}},
						{n=G.UIT.R, config={align = "tm", padding = 0,outline_colour = G.C.CLEAR, r = 0.1, outline = 1}, nodes={
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = "SEPARATOR LMAO", scale = text_scale*0.4, colour = G.C.CLEAR, shadow = true}},
							}},
						}},
						{n=G.UIT.R, config={align = "tm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
							{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = G.SETTINGS.roche and localize('vs_credits4') or "?????", scale = header_scale*0.6, colour = G.C.BLUE, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "cm", padding = 0}, nodes= {
								{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = G.SETTINGS.roche and vs_credit_8 or "?????", scale = text_scale*0.55, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
								}},
								{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = G.SETTINGS.roche and vs_credit_8_tag or "?????", scale = text_scale*0.45, colour = G.C.JOKER_GREY, shadow = true}},
								}},
							}},
						}},
					}},
				}},
				{n=G.UIT.C, config={align = "tm", padding = 0.1, r = 0.1}, nodes= {
					{ n = G.UIT.C, config = { align = "tm", padding = 0.1 * bonus_padding, outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1 }, nodes = {
						{ n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
							{ n = G.UIT.T, config = { text = localize('vs_credits2'), scale = header_scale * 0.6, colour = HEX('f75294'), shadow = true } },
						} },
						{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
							{n=G.UIT.C, config={align = "tl", padding = 0}, nodes={
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_1, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_3, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_13, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_14, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_15, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_16, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_17, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_18, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_19, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_25, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_26, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_24, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_27, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_21, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
							}},
							{n=G.UIT.C, config={align = "tl", padding = 0}, nodes={
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_22, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_23, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_10, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_28, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_29, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_30, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_31, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_32, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_33, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
							}}
						}},
					} },
				}},
				{n=G.UIT.C, config={align = "tm", padding = 0.1, r = 0.1}, nodes= {
					{ n = G.UIT.C, config = { align = "tm", padding = 0, r = 0.1, }, nodes = {
						{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
							{n=G.UIT.C, config={align = "tl", padding = 0.1*bonus_padding,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
								{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = localize('vs_credits3'), scale = header_scale*0.6, colour = G.C.ORANGE, shadow = true}},
								}},
								{n=G.UIT.R, config={align = "cm", padding = 0}, nodes= {
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_1, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_2, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_4, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_5, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_6, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_7, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_13, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
								}},
							}},
							{n=G.UIT.C, config={align = "tm", padding = 0,outline_colour = G.C.CLEAR, r = 0.1, outline = 1}, nodes={
								{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = "SEPARATOR LMAO", scale = text_scale*0.3, colour = G.C.CLEAR, vert = true, shadow = true}},
								}},
							}},
							{n=G.UIT.C, config={align = "tl", padding = 0.1*bonus_padding,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
								{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = localize('vs_credits5'), scale = header_scale*0.55, colour = G.C.PURPLE, shadow = true}},
								}},
								{n=G.UIT.R, config={align = "cm", padding = 0}, nodes= {
									{n=G.UIT.R, config={align = "tm", padding = support_padding}, nodes={
										{n=G.UIT.T, config={text = vs_credit_9, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = support_padding}, nodes={
										{n=G.UIT.T, config={text = vs_credit_9_from, scale = text_scale*0.375, colour = G.C.JOKER_GREY, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = support_padding}, nodes={
										{n=G.UIT.T, config={text = vs_credit_10, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = support_padding}, nodes={
										{n=G.UIT.T, config={text = vs_credit_10_from, scale = text_scale*0.375, colour = G.C.JOKER_GREY, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = support_padding}, nodes={
										{n=G.UIT.T, config={text = vs_credit_5, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = support_padding}, nodes={
										{n=G.UIT.T, config={text = vs_credit_5_from, scale = text_scale*0.375, colour = G.C.JOKER_GREY, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = support_padding}, nodes={
										{n=G.UIT.T, config={text = vs_credit_12, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = support_padding}, nodes={
										{n=G.UIT.T, config={text = vs_credit_12_from, scale = text_scale*0.375, colour = G.C.JOKER_GREY, shadow = true}},
									}},
								}},
							}},
						}},
						{n=G.UIT.R, config={align = "tm", padding = 0,outline_colour = G.C.CLEAR, r = 0.1, outline = 1}, nodes={
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = "SEPARATOR LMAO", scale = text_scale*0.3, colour = G.C.CLEAR, shadow = true}},
							}},
						}},
						{n=G.UIT.R, config={align = "tm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
							{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = localize('vs_credits6'), scale = header_scale*0.55, colour = G.C.GREEN, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.C, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_st1, scale = text_scale*0.36, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_st3, scale = text_scale*0.36, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_st5, scale = text_scale*0.36, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
								}},
								{n=G.UIT.C, config={align = "tm", padding = 0,outline_colour = G.C.CLEAR, r = 0.1, outline = 1}, nodes={
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = "SEPARATOR LMAO", scale = text_scale*0.15, colour = G.C.CLEAR, shadow = true}},
									}},
								}},
								{n=G.UIT.C, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_st2, scale = text_scale*0.36, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_st4, scale = text_scale*0.36, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_st6, scale = text_scale*0.36, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
								}}
							}},
						}},
					}},
				}},
			}}
		}}
	}}
end
