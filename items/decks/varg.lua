local deckInfo = {
    name = 'Varg Deck',
    config = {},
    unlocked = false,
    discovered = false,
    config = { hand_size = -1 },
    unlock_condition = {type = 'win_deck', deck = 'b_green'}
}

deckInfo.loc_vars = function(self, info_queue, card)
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