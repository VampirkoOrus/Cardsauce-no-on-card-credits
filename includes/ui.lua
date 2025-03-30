-- Mod Icon in Mods tab
SMODS.Atlas({
	key = "modicon",
	path = "csau_icon.png",
	px = 32,
	py = 32
})

-- this inner check for config was originally a local function
-- but it was only used here, so I combined them ~Winter
function G.FUNCS.csau_restart()
	local settingsMatch = true
	for k, v in pairs(csau_enabled) do
		if v ~= csau_config[k] then
			settingsMatch = false
		end
	end

	if settingsMatch then
		send("SETTINGS MATCH :)")
		SMODS.full_restart = 0
	else
		send("SETTINGS DONT MATCH!")
		SMODS.full_restart = 1
	end
end





---------------------------
--------------------------- Title Screen Easter eggs
---------------------------

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


if csau_enabled['enableEasterEggs'] then
	G.chadnova = externalPsuedorandom(1, 1000)

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
end

if G.chadnova then
	G.TITLE_SCREEN_CARD = 'j_csau_chad'
else
	G.TITLE_SCREEN_CARD = G.P_CARDS.C_A
end

G.FUNCS.center_splash_screen_card = function(SC_scale)
	if G.chadnova then
		return Card(G.ROOM.T.w/2 - SC_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC_scale*G.CARD_H/2, SC_scale*G.CARD_W, SC_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[G.TITLE_SCREEN_CARD])
	else
		return Card(G.ROOM.T.w/2 - SC_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC_scale*G.CARD_H/2, SC_scale*G.CARD_W, SC_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['j_joker'])
	end
end

G.FUNCS.splash_screen_card = function(card_pos, card_size)
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

G.FUNCS.title_screen_card = function(self, SC_scale)
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





---------------------------
--------------------------- SMODS Tabs
---------------------------

-- this function was originally stored in a local function first
-- couldn't figure why, so I directly assigned it instead ~Winter
local text_scale = 0.9
SMODS.current_mod.extra_tabs = function() 
    return {
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
			if localize("vs_options_resetAchievements_r") then
				csau_opts.nodes[#csau_opts.nodes+1] = {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
					{n=G.UIT.R, config={align = "cm", minw = 0.5, maxw = 2, minh = 0.6, padding = 0, r = 0.1, hover = true, colour = G.C.RED, button = "reset_trophies", shadow = true, focus_args = {nav = 'wide'}}, nodes={
						{n=G.UIT.T, config={text = localize("vs_options_resetAchievements_r"), scale = text_scale*0.55, colour = G.C.UI.TEXT_LIGHT}}
					}},
					{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
						{n=G.UIT.T, config={text = localize("vs_options_resetAchievements_desc"), scale = text_scale*0.35, colour = G.C.JOKER_GREY, shadow = true}}
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

SMODS.current_mod.config_tab = function()
	local ordered_config = {
		'enableVinkers',
		'enableJoelkers',
		'enableOtherJokers',
		'enableConsumables',
		'enableBlinds',
		'enableDecks',
		'enableSkins',
		'enableChallenges',
		'enableMusic',
		'enableAchievements',
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
local vs_credit_9_from = "(JankJonklers)"
local vs_credit_10 = "Akai"
local vs_credit_10_from = "(Balatrostuck)"
local vs_credit_5_from = "(LobotomyCorp)"
local vs_credit_12 = "Victin"
local vs_credit_12_from = "(Victin's Collection)"
local vs_credit_13 = "Keku"
local vs_credit_14 = "Gappie"
local vs_credit_15 = "Winter Grimwell"
local vs_credit_16 = "FenixSeraph"
local vs_credit_17 = "WhimsyCherry"
local vs_credit_18 = "Global-Trance"
local vs_credit_19 = "Lyzerus"
local vs_credit_20 = "Bassclefff"
local vs_credit_20_tag = "(bassclefff.bandcamp.com)"
local vs_credit_21 = "fradavovan"
local vs_credit_22 = "Greeeg"
local vs_credit_23 = "CheesyDraws"
local vs_credit_24 = "Jazz_Jen"
local vs_credit_25 = "BardVergil"
local vs_credit_26 = "GuffNFluff"
local vs_credit_27 = "sinewuui"
local vs_credit_28 = "Swizik"
local vs_credit_29 = "Burdrehnar"
local vs_credit_30 = "Crisppyboat"
local vs_credit_31 = "Alli"
local vs_credit_32 = "Lyman"
local vs_credit_33 = "AlizarinRed"
local vs_credit_34 = "PaperMoon"
local vs_credit_35 = "yunkie101"
local vs_credit_36 = "plunch"
local vs_credit_37 = "MightyKingWario"
local vs_credit_38 = "KawaiiRerun"
local vs_credit_39 = "TheWinterComet"
local vs_credit_40 = "Sir. Gameboy"
local vs_credit_41 = "Cauthen Currie"
local vs_credit_st1 = "tortoise"
local vs_credit_st2 = "Protokyuuu"
local vs_credit_st3 = "ShrineFox"
local vs_credit_st4 = "cyrobolic"
local vs_credit_st5 = "ReconBox"
local vs_credit_st6 = "SinCityAssassin"

local header_scale = 1.1
local bonus_padding = 1.15
local support_padding = 0.015
local artist_size = 0.43
local seperator_mod = 1.5

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
								{n=G.UIT.T, config={text = "SEPARATOR LMAO", scale = (text_scale*0.4)*seperator_mod, colour = G.C.CLEAR, shadow = true}},
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
								{n=G.UIT.T, config={text = "SEPARATOR LMAO", scale = (text_scale*0.4)*seperator_mod, colour = G.C.CLEAR, shadow = true}},
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
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_22, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
							}},
							{n=G.UIT.C, config={align = "tl", padding = 0}, nodes={
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
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_34, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_35, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_37, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_36, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_38, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = vs_credit_41, scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
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
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_40, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									}},
									{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
										{n=G.UIT.T, config={text = vs_credit_39, scale = text_scale*0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
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
