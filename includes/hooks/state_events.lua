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