function SMODS.current_mod.reset_game_globals(run_start)
    if run_start then
        G.GAME.csau_max_stands = 1
		G.GAME.morshu_cards = 0
    end

	G.GAME.csau_shop_dollars_spent = 0

    csau_reset_paper_rank()

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
		local randCard_2 = pseudorandom_element(valid_joeycastle_cards, pseudoseed('fent'..G.GAME.round_resets.ante))
		G.GAME.current_round.joeycastle.suit = randCard_2.base.suit
	end
	local randCard_3 = pseudorandom_element(G.playing_cards, pseudoseed('DUANE'..G.GAME.round_resets.ante))
	G.GAME.current_round.duane_suit = randCard_3.base.suit

	local valid_paper_ranks = {}
	for _, v in ipairs(G.playing_cards) do
		if not SMODS.has_no_rank(v) then
			for _, rank in pairs(SMODS.Ranks) do
				if rank.key == v.base.value and rank.face then
					valid_paper_ranks[#valid_paper_ranks+1] = v
				end
			end
		end
	end
	local randCard_4 = pseudorandom_element(valid_paper_ranks, pseudoseed('papermoon'..G.GAME.round_resets.ante))
	G.GAME.current_round.paper_rank = randCard_4.base.value
end

SMODS.PokerHandPart:take_ownership('_straight', {
	func = function(hand) return get_straight(hand, next(SMODS.find_card('j_four_fingers')) and 4 or 5, not not next(SMODS.find_card('j_shortcut')), next(SMODS.find_card('j_csau_gnorts'))) end
})