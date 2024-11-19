--- STEAMODDED HEADER
--- MOD_NAME: Cardsauce
--- MOD_ID: Cardsauce
--- MOD_AUTHOR: [BarrierTrio/Gote]
--- MOD_DESCRIPTION: A set of Jokers based on Vinesauce!
--- BADGE_COLOUR: 32A852
--- DISPLAY_NAME: Cardsauce
--- PREFIX: csau

local mod_path = SMODS.current_mod.path
local usable_path = mod_path:match("Mods/[^/]+")
csau_config = SMODS.current_mod.config
csau_enabled = copy_table(csau_config)

local hook_list = {
	"card",
	"UI_definitions",
}

for _, hook in ipairs(hook_list) do
	local init, error = NFS.load(SMODS.current_mod.path .. "hooks/" .. hook ..".lua")
	if error then sendErrorMessage("[Cardsauce] Failed to load "..hook.." with error "..error) else
		local data = init()
		sendDebugMessage("[Cardsauce] Loaded hook: " .. hook)
	end
end

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
		'speedjoker',
		'disturbedjoker',
		'besomeone',
		'disguy',
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
		'odio',
		'greenneedle',
		'fisheye',
		'code',
		'anotherlight',
		'deathcard',
		'hell',
		'wingsoftime',
		'dontmind',
		'miracle',
		'garbagehand',
		'supper',
		'chromedup',
		'red',
		'kings',
		'kerosene',
		'purple',
		'fate',
		'businesstrading',
		'muppet',
		'vincenzo',
		'quarterdumb',
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

for i, v in ipairs(conf_cardsauce.jokersToLoad) do
	local jokerInfo = assert(SMODS.load_file("jokers/" .. v .. ".lua"))()

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

	SMODS.Atlas({ key = v, path ="jokers/" .. v .. ".png", px = joker.width or 71, py = joker.height or  95 })
end

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

local card_drawRef = Card.draw
function Card.draw(self, layer)
	local obj = self.config.center
	if obj.draw and type(obj.draw) == 'function' then
		obj:draw(self, layer)
	end
	card_drawRef(self, layer)
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

if G.SETTINGS.chadNova then
	G.TITLE_SCREEN_CARD = 'j_csau_chad'
else
	G.TITLE_SCREEN_CARD = G.P_CARDS.C_A
end

G.C.PINK = HEX('fe55a5')
G.C.CYAN = HEX('00eaff')


G.C.COLOUR1 = G.SETTINGS.CS_COLOR1 or G.C.RED
G.C.COLOUR2 = G.SETTINGS.CS_COLOR2 or G.C.BLUE

local color_presets = {
	{
		"GREEN",
		"PURPLE",
		'default_csau'
	},
	{
		"RED",
		"BLUE",
		'default_bal'
	},
	{
		{'2c997f', "DS_GREENCYAN", },
		{'09271d', "DS_DARKGREEN"},
		'darkshroom',
	},
	{
		{'38a789', "VS_GREEN"},
		{'95c374', "VS_LIGHTGREEN"},
		'vineshroom',
	},
	{
		{"4862b0", "FS_BLUE"},
		{"67b874", "FS_PALEGREEN"},
		'fullsauce',
	},
	{
		{'e26565', "ES_PALERED"},
		{'a53b38', "ES_DARKRED"},
		'extrasauce',
	},
	{
		{'9967a7', "TWITCH_PALEPURPLE"},
		{'483062', "TWITCH_DARKPURPLE"},
		'twitch',
	},
	{
		{"b5e61d", "FREN_NEONGREEN"},
		{"04a1e5", "FREN_LIGHTBLUE"},
		'fren',
	},
	{
		"PURPLE",
		"YELLOW",
		'jabroni',
	},
	{
		"BLACK",
		"JOKER_GREY",
		'uzumaki',
	},
}

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
	for i = 1, 2 do
		if type(preset[i]) == "string" then
			colors[preset[i]] = true
		elseif type(preset[i]) == "table" then
			colors[preset[i][2]] = true
		end
	end
end

for color, _ in pairs(colors) do
	G.FUNCS["change_color_1_" .. color] = function()
		G.C.COLOUR1 = G.C[color]
		csau_save_color(1, color)
	end

	G.FUNCS["change_color_2_" .. color] = function()
		G.C.COLOUR2 = G.C[color]
		csau_save_color(2, color)
	end
end

local color_presets_nums = {}
local color_presets_strings = {}
for i, v in ipairs(color_presets) do
	local k = v[3]
	table.insert(color_presets_strings, k)
	color_presets_nums[k] = i
	for i = 1, 2 do
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

if not G.SETTINGS.csau_color_selection then
	G.SETTINGS.csau_color_selection = "default_csau"
end

local main_menuRef = Game.main_menu
function Game:main_menu(change_context)
	main_menuRef(self, change_context)

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

G.FUNCS.change_color_buttons = function()
	if G.OVERLAY_MENU then
		local swap_node = G.OVERLAY_MENU:get_UIE_by_ID('color_buttons')
		local focused_color_preset = G.SETTINGS.QUEUED_CHANGE.color_change
		local color1, color2
		for _, v in ipairs(color_presets) do
			if v[3] == focused_color_preset then
				color1 = v[1][2] or v[1]
				color2 = v[2][2] or v[2]
			end
		end
		if swap_node then
			for i=1, #swap_node.children do
				swap_node.children[i]:remove()
				swap_node.children[i] = nil
			end
			local new_color_buttons = {}
			new_color_buttons[#new_color_buttons + 1] = {n=G.UIT.T, config={text = localize('b_color_selector_outer'), scale = 0.35, colour = G.C.WHITE, shadow = true}}
			new_color_buttons[#new_color_buttons + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
															UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_1_"..color1, colour = G.C[color1], label = {" "}, scale = 0.35})
														}}
			new_color_buttons[#new_color_buttons + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm"}, nodes = {
															UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_1_"..color2, colour = G.C[color2], label = {" "}, scale = 0.35})
														}}
			new_color_buttons[#new_color_buttons + 1] = {n=G.UIT.T, config={text = "|", scale = 0.35, colour = G.C.WHITE, shadow = true}}
			new_color_buttons[#new_color_buttons + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm"}, nodes = {
															UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_2_"..color1, colour = G.C[color1], label = {" "}, scale = 0.35})
														}}
			new_color_buttons[#new_color_buttons + 1] = {n = G.UIT.C, config = {padding = 0.2,align = "cm"}, nodes = {
															UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_2_"..color2, colour = G.C[color2], label = {" "}, scale = 0.35})
														}}
			new_color_buttons[#new_color_buttons + 1] = {n=G.UIT.T, config={text = localize('b_color_selector_inner'), scale = 0.35, colour = G.C.WHITE, shadow = true}}
			for i, v in ipairs(new_color_buttons) do
				swap_node.UIBox:add_child(v, swap_node)
			end

		end
	end
end

G.FUNCS.change_color_preset = function(args)
	G.ARGS.color_vals = G.ARGS.color_vals or color_presets_strings
	G.SETTINGS.QUEUED_CHANGE.color_change = G.ARGS.color_vals[args.to_key]
	G.SETTINGS.csau_color_selection = G.ARGS.color_vals[args.to_key]
	G.FUNCS.change_color_buttons()
end

setting_tabRef = G.UIDEF.settings_tab
function G.UIDEF.settings_tab(tab)
	local setting_tab = setting_tabRef(tab)
	if tab == 'Game' then
		local color1, color2
		for _, v in ipairs(color_presets) do
			if v[3] == G.SETTINGS.csau_color_selection then
				color1 = v[1][2] or v[1]
				color2 = v[2][2] or v[2]
			end
		end
		local colorSelector = {n=G.UIT.R, config = {align = 'cm', r = 0}, nodes={
			create_option_cycle({w = 4,scale = 0.8, label = localize('b_color_selector'), options = localize('ml_color_selector_opt'), opt_callback = 'change_color_preset', current_option = ((color_presets_nums)[G.SETTINGS.csau_color_selection] or 1)}),
			{n=G.UIT.R, config={align = "cm", id = 'color_buttons'}, nodes={
					{n=G.UIT.T, config={text = localize('b_color_selector_outer'), scale = 0.35, colour = G.C.WHITE, shadow = true}},
					{n = G.UIT.C, config = {padding = 0.2,align = "cm", }, nodes = {
						UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_1_"..color1, colour = G.C[color1], label = {" "}, scale = 0.35})
					}},
					{n = G.UIT.C, config = {padding = 0.2,align = "cm"}, nodes = {
						UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_1_"..color2, colour = G.C[color2], label = {" "}, scale = 0.35})
					}},
					{n=G.UIT.T, config={text = "|", scale = 0.35, colour = G.C.WHITE, shadow = true}},
					{n = G.UIT.C, config = {padding = 0.2,align = "cm"}, nodes = {
						UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_2_"..color1, colour = G.C[color1], label = {" "}, scale = 0.35})
					}},
					{n = G.UIT.C, config = {padding = 0.2,align = "cm"}, nodes = {
						UIBox_button({minw = 0.5, minh = 0.5, button = "change_color_2_"..color2, colour = G.C[color2], label = {" "}, scale = 0.35})
					}},
					{n=G.UIT.T, config={text = localize('b_color_selector_inner'), scale = 0.35, colour = G.C.WHITE, shadow = true}},
				}}
			}}
		setting_tab.nodes[#setting_tab.nodes + 5] = colorSelector
	end
	return setting_tab
end

function G.FUNCS.title_screen_card(self, SC_scale)
	if G.SETTINGS.chadNova then
		if type(G.TITLE_SCREEN_CARD) == "table" then
			return Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.TITLE_SCREEN_CARD, G.P_CENTERS.c_base)
		elseif type(G.TITLE_SCREEN_CARD) == "string" then
			return  Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS.empty, G.P_CENTERS[G.TITLE_SCREEN_CARD])
		else
			return Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS.C_A, G.P_CENTERS.c_base)
		end
	else
		return Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS.C_A, G.P_CENTERS.c_base)
	end
end

function G.FUNCS.center_splash_screen_card(SC_scale)
	if G.SETTINGS.chadNova then
		return Card(G.ROOM.T.w/2 - SC_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC_scale*G.CARD_H/2, SC_scale*G.CARD_W, SC_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[G.TITLE_SCREEN_CARD])
	else
		return Card(G.ROOM.T.w/2 - SC_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC_scale*G.CARD_H/2, SC_scale*G.CARD_W, SC_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['j_joker'])
	end
end

function G.FUNCS.splash_screen_card(card_pos, card_size)
	if G.SETTINGS.chadNova then
		return Card(  card_pos.x + G.ROOM.T.w/2 - G.CARD_W*card_size/2,
				card_pos.y + G.ROOM.T.h/2 - G.CARD_H*card_size/2,
				card_size*G.CARD_W, card_size*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[G.TITLE_SCREEN_CARD])
	else
		return Card(  card_pos.x + G.ROOM.T.w/2 - G.CARD_W*card_size/2,
				card_pos.y + G.ROOM.T.h/2 - G.CARD_H*card_size/2,
				card_size*G.CARD_W, card_size*G.CARD_H, pseudorandom_element(G.P_CARDS), G.P_CENTERS.c_base)
	end
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
local logo = "Logo.png"
if G.SETTINGS.chadNova then
	logo = "Logo-C.png"
end
SMODS.Atlas {
	key = "balatro",
	path = logo,
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

G.FUNCS.reset_chadnova = function(e)
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
		G.SETTINGS.chadNova = false
		G:save_settings()
		G.E_MANAGER:add_event(Event({
			delay = 6,
			func = function()
				G.FUNCS.quit()
				G.FUNCS.wipe_off()
				return true
			end
		}))
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
				{n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
					{n=G.UIT.T, config={text = localize("vs_options_sub"), scale = text_scale*0.5, colour = G.C.GREEN, shadow = true}},
				}},
			} }
			for k, _ in pairs(csau_config) do
				if localize("vs_options_"..k) ~= "ERROR" then
					csau_opts.nodes[#csau_opts.nodes+1] = {n=G.UIT.R, config={align = "cm", padding = 0.2}, nodes={
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							create_toggle({n=G.UIT.T, label = localize("vs_options_"..k), ref_table = csau_config, ref_value = k })
						}},
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = localize("vs_options_"..k.."_desc"), scale = text_scale*0.35, colour = G.C.JOKER_GREY, shadow = true}}
						}},
					}}
				end
			end
			if localize("vs_options_chadNova_r") and G.SETTINGS.chadNova then
				csau_opts.nodes[#csau_opts.nodes+1] = {n=G.UIT.R, config={align = "cm", padding = 0.2}, nodes={
					{n=G.UIT.R, config={align = "cm", minw = 0.5, maxw = 2, minh = 0.6, padding = 0, r = 0.1, hover = true, colour = G.C.RED, button = "reset_chadnova", shadow = true, focus_args = {nav = 'wide'}}, nodes={
						{n=G.UIT.T, config={text = localize("vs_options_chadNova_r"), scale = text_scale*0.55, colour = G.C.UI.TEXT_LIGHT}}
					}},
					{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
						{n=G.UIT.T, config={text = localize("vs_options_chadNova_desc"), scale = text_scale*0.35, colour = G.C.JOKER_GREY, shadow = true}}
					}},
				}}
				csau_opts.nodes[#csau_opts.nodes+1] = {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
					{n=G.UIT.T, config={id = 'warn', text = localize('ph_click_confirm').." "..localize('vs_options_reset_confirm'), scale = 0.4, colour = G.C.CLEAR}}
				}}
			end
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

local vs_credit_1 = "BarrierTrio/Gote"
local vs_credit_2 = "DPS2004"
local vs_credit_3 = "SagaciousCejai"
local vs_credit_4 = "Nether"
local vs_credit_5 = "Mysthaps"
local vs_credit_6 = "Numbuh214"
local vs_credit_7 = "Aurelius7309"
local vs_credit_8 = "Austin L. Matthews"
local vs_credit_8_tag = "(AmtraxVA)"
local vs_credit_9 = "Lyman"
local vs_credit_9_from = "(from JankJonklers)"
local vs_credit_10 = "Akai"
local vs_credit_10_from = "(from Balatrostuck)"
local vs_credit_5_from = "(from LobotomyCorp)"
local vs_credit_12 = "Victin"
local vs_credit_12_from = "(from Victin's Collection)"
local vs_credit_13 = "Keku"
local vs_credit_14 = "Gappie"
local vs_credit_15 = "Arthur Effgus"
local vs_credit_16 = "FenixSeraph"
local vs_credit_17 = "WhimsyCherry"
local vs_credit_st1 = "tortoise"
local vs_credit_st2 = "Protokyuuu"
local vs_credit_st3 = "ShrineFox"
local vs_credit_st4 = "CheesyDraws"

local header_scale = 1.1
local bonus_padding = 1.15

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
								{n=G.UIT.T, config={text = localize('vs_credits1'), scale = text_scale*0.6, colour = G.C.GOLD, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "cm", padding = 0}, nodes= {
								{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = vs_credit_1, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
								}},
								{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = vs_credit_13, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
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
								{n=G.UIT.T, config={text = localize('vs_credits4'), scale = text_scale*0.6, colour = G.C.BLUE, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "cm", padding = 0}, nodes= {
								{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = vs_credit_8, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
								}},
								{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = vs_credit_8_tag, scale = text_scale*0.45, colour = G.C.JOKER_GREY, shadow = true}},
								}},
								{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
									{n=G.UIT.T, config={text = "SEPARATOR LMAO", scale = text_scale*0.05, colour = G.C.CLEAR, shadow = true}},
								}},
							}},
						}},
					}},
				}},
				{n=G.UIT.C, config={align = "tm", padding = 0.1, r = 0.1}, nodes= {
					{ n = G.UIT.C, config = { align = "tm", padding = 0.1 * bonus_padding, outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1 }, nodes = {
						{ n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
							{ n = G.UIT.T, config = { text = localize('vs_credits2'), scale = header_scale * 0.6, colour = G.C.RED, shadow = true } },
						} },
						{ n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
							{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = vs_credit_1, scale = text_scale * 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
							} },
							{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = vs_credit_3, scale = text_scale * 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
							} },
							{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = vs_credit_13, scale = text_scale * 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
							} },
							{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = vs_credit_14, scale = text_scale * 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
							} },
							{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = vs_credit_15, scale = text_scale * 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
							} },
							{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = vs_credit_16, scale = text_scale * 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
							} },
							{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
								{ n = G.UIT.T, config = { text = vs_credit_17, scale = text_scale * 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
							} },
						} },
					} },
				}},
				{n=G.UIT.C, config={align = "tm", padding = 0.1, r = 0.1}, nodes= {
					{n=G.UIT.C, config={align = "tm", padding = 0.1*bonus_padding,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
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
				}},
				{n=G.UIT.C, config={align = "tm", padding = 0.1, r = 0.1}, nodes= {
					{n=G.UIT.C, config={align = "tm", padding = 0.1*bonus_padding,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = localize('vs_credits5'), scale = header_scale*0.6, colour = G.C.PURPLE, shadow = true}},
						}},
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes= {
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = vs_credit_9, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = vs_credit_9_from, scale = text_scale*0.45, colour = G.C.JOKER_GREY, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = vs_credit_10, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = vs_credit_10_from, scale = text_scale*0.45, colour = G.C.JOKER_GREY, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = vs_credit_5, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = vs_credit_5_from, scale = text_scale*0.45, colour = G.C.JOKER_GREY, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = vs_credit_12, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = vs_credit_12_from, scale = text_scale*0.45, colour = G.C.JOKER_GREY, shadow = true}},
							}},
						}},
					}},
				}},
				{n=G.UIT.C, config={align = "tm", padding = 0.1, r = 0.1}, nodes= {
					{n=G.UIT.C, config={align = "tm", padding = 0.1*bonus_padding,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
							{n=G.UIT.T, config={text = localize('vs_credits6'), scale = header_scale*0.6, colour = G.C.GREEN, shadow = true}},
						}},
						{n=G.UIT.R, config={align = "cm", padding = 0}, nodes= {
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = vs_credit_st1, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = vs_credit_st2, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = vs_credit_st3, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
							}},
							{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
								{n=G.UIT.T, config={text = vs_credit_st4, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
							}},
						}},
					}}
				}}
			}}
		}}
	}}
end
