local main_menuRef = Game.main_menu
function Game:main_menu(change_context)
	main_menuRef(self, change_context)

    -- this was originally inside a local function called 'initPostMainMenu()'
    -- but since it was the only thing inside it and it was only used here, I removed it
    -- ~Winter
	if csau_enabled['enableChallenges'] then
		-- csau_tucker_addBanned()
	end

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