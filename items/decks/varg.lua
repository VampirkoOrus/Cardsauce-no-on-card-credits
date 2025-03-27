local deckInfo = {
    name = 'Varg Deck',
    config = {},
    unlocked = false,
    discovered = false,
    config = { hand_size = -1 },
    unlock_condition = {type = 'win_deck', deck = 'b_checkered'}
}

deckInfo.loc_vars = function(self, info_queue, card)
    if info_queue then
        info_queue[#info_queue+1] = {key = "guestartist8", set = "Other"}
    end
    return {vars = { self.config.hand_size } }
end

deckInfo.apply = function(self, back)
    G.E_MANAGER:add_event(Event({
        func = function()
            for k, v in pairs(G.GAME.probabilities) do
                G.GAME.probabilities[k] = v * 2
            end
            return true
        end
    }))
end

return deckInfo