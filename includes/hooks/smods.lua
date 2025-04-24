function SMODS.current_mod.reset_game_globals(run_start)
    if run_start then
        G.GAME.csau_max_stands = 1
		G.GAME.morshu_cards = 0
    end

	G.GAME.csau_shop_dollars_spent = 0

    csau_reset_paper_rank()

	G.GAME.current_round.choicevoice = { suit = 'Clubs' }
	local _poker_hands = {}
	for k, v in pairs(G.GAME.hands) do
		if v.visible then _poker_hands[#_poker_hands+1] = k end
	end
	G.GAME.current_round.choicevoice.hand = pseudorandom_element(_poker_hands, pseudoseed('voice'))
	local valid_choicevoice_cards = {}
	for _, v in ipairs(G.playing_cards) do
		if not SMODS.has_no_suit(v) then
			if (G.GAME and G.GAME.wigsaw_suit and v:is_suit(G.GAME.wigsaw_suit)) or (G.GAME and not G.GAME.wigsaw_suit) then
				if G.GAME.current_round.choicevoice.hand == 'csau_Fibonacci' or G.GAME.current_round.choicevoice.hand == 'FlushFibonacci' then
					if is_perfect_square(v.base.nominal) then
						valid_choicevoice_cards[#valid_choicevoice_cards+1] = v
					end
				else
					valid_choicevoice_cards[#valid_choicevoice_cards+1] = v
				end
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
	G.GAME.csau_delay_duane = true
	SMODS.calculate_context({csau_duane_change = true, suit = randCard_3.base.suit})
	G.GAME.current_round.duane_suit = randCard_3.base.suit


	local valid_paper_ranks = {}
	for _, rank in pairs(SMODS.Ranks) do
		if rank.face then
			valid_paper_ranks[#valid_paper_ranks+1] = v
		end
	end
	local randCard_4 = pseudorandom_element(valid_paper_ranks, pseudoseed('papermoon'..G.GAME.round_resets.ante))
	G.GAME.current_round.paper_rank = randCard_4 and randCard_4.base.value
end

SMODS.PokerHandPart:take_ownership('_straight', {
	func = function(hand) return get_straight(hand, next(SMODS.find_card('j_four_fingers')) and 4 or 5, not not next(SMODS.find_card('j_shortcut')), next(SMODS.find_card('j_csau_gnorts'))) end
})

local ref_ccuib = SMODS.card_collection_UIBox
SMODS.card_collection_UIBox = function(_pool, rows, args)
	if _pool == G.P_CENTER_POOLS.csau_Stand then
		args.modify_card = function(card, center, i, j)
			card.sticker = get_stand_win_sticker(center)
		end
	end
	return ref_ccuib(_pool, rows, args)
end
