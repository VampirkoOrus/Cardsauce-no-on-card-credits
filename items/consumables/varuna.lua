local consumInfo = {
    name = 'Varuna',
    set = "Planet",
    config = { hand_type = 'csau_FlushBlackjack' },
}

consumInfo.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "guestartist8", set = "Other"}
    local hand = self.config.hand_type
    return { vars = {G.GAME.hands[hand].level,localize(hand, 'poker_hands'), G.GAME.hands[hand].l_mult, G.GAME.hands[hand].l_chips, colours = {(G.GAME.hands[hand].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[hand].level)])}} }
end

consumInfo.in_pool = function(self, args)
    if next(SMODS.find_card("j_csau_blackjack")) then
        return true
    end
end

return consumInfo