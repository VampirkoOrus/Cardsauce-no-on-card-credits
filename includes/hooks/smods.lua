function SMODS.current_mod.reset_game_globals(run_start)
    if run_start then
        G.GAME.max_stands = 1
    end

    reset_paper_rank()

	G.GAME.current_round.choicevoice = { suit = 'Clubs' }
	local valid_choicevoice_cards = {}
	for _, v in ipairs(G.playing_cards) do
		if not SMODS.has_no_suit(v) then
			if (G.GAME and G.GAME.wigsaw_suit and v:is_suit(G.GAME.wigsaw_suit)) or (G.GAME and not G.GAME.wigsaw_suit) then
				valid_choicevoice_cards[#valid_choicevoice_cards+1] = v
			end
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