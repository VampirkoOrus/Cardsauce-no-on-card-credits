function G.UIDEF.vic_speech_bubble(text_key, loc_vars, extra)
    local text = {}
    local extra = extra or {}

    localize{type = 'quips', key = text_key, vars = loc_vars or {}, nodes = text}
    local row = {}
    for k, v in ipairs(text) do
        --v[1].config.colour = extra.text_colour or v[1].config.colour or G.C.JOKER_GREY
        row[#row+1] =  {n=G.UIT.R, config={align = extra.text_alignment or "cl"}, nodes=v}
    end
    local t = {n=G.UIT.ROOT, config = {align = "cm", minh = 1, r = 0.3, padding = 0.07, minw = 1, colour = extra.root_colour or G.C.JOKER_GREY, shadow = true}, nodes={
        {n=G.UIT.C, config={align = "cm", minh = 1, r = 0.2, padding = 0.1, minw = 1, colour = extra.bg_colour or G.C.WHITE}, nodes={
            {n=G.UIT.C, config={align = "cm", minh = 1, r = 0.2, padding = 0.03, minw = 1, colour = extra.bg_colour or G.C.WHITE}, nodes=row}}
        }
    }}
    return t
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

	if card.ability.set == "csau_Stand" then
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

-- this local table was only used here, so I moved it here ~Winter
local music_nums = { cardsauce = 1, balatro = 2}
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
		for _, v in ipairs(G.color_presets) do
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
			create_option_cycle({w = 5,scale = 0.8, label = localize('b_color_selector'), options = localize('ml_color_selector_opt'), opt_callback = 'change_color_preset', current_option = ((G.color_presets_nums)[G.SETTINGS.csau_color_selection] or 1)}),
			{n=G.UIT.R, config={align = "cm", id = 'color_buttons'}, nodes={nodes, sub_caption, sub_buttons, sub_caption_2, sub_buttons_2, apply_button}},
		}}
		setting_tab.nodes[#setting_tab.nodes + 5] = colorSelector
	end
	return setting_tab
end

function G.UIDEF.morshu_save(existing_morshu_area)
	-- keep the old one if it exists to maintain
	G.morshu_area = existing_morshu_area or CardArea(
		G.hand.T.x+0,
		G.hand.T.y+G.ROOM.T.y + 9,
		1.25*G.CARD_W,
		0.85*G.CARD_H, 
		{card_limit = G.GAME.morshu_cards or 0, type = 'shop', highlight_limit = 1})
	
	local t = {n=G.UIT.ROOT, config = {align = 'cl', colour = G.C.CLEAR}, nodes={
		UIBox_dyn_container({{
			n=G.UIT.C, config={align = "cm", padding = 0.05, emboss = 0.05, r = 0.1, colour = G.C.BLACK}, nodes={
				{n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
					{n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
						{n=G.UIT.C, config={align = "cm", padding = 0.2, r=0.2, colour = G.C.BLACK, maxh = G.morshu_area.T.h+0.4}, nodes={
						{n=G.UIT.T, config={text = localize('k_morshu_ui'), scale = 0.45, colour = G.C.L_BLACK, vert = true}},
						{n=G.UIT.O, config={object = G.morshu_area}},
						}},
					}},
				}}
			}
		}}, false, G.C.CLEAR, G.C.CLEAR)
	}}
	t.nodes[1].config.colour = G.C.CLEAR
    return t
end