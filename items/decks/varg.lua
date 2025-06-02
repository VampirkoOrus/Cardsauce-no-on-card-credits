local deckInfo = {
    name = 'Varg Deck',
    config = {},
    unlocked = false,
    discovered = false,
    config = { hand_size = -1 },
    unlock_condition = {type = 'win_deck', deck = 'b_checkered'},
    csau_dependencies = {
        'enableJoelContent',
    }
}

deckInfo.loc_vars = function(self, info_queue, card)
    if info_queue then

    end
    return {vars = { self.config.hand_size } }
end

deckInfo.apply = function(self, back)
    G.E_MANAGER:add_event(Event({
        func = function()
            G.GAME.starting_params.csau_jokers_rate = G.GAME.starting_params.csau_jokers_rate or 1
            G.GAME.starting_params.csau_jokers_rate = G.GAME.starting_params.csau_jokers_rate * 2
            for k, v in pairs(G.GAME.probabilities) do
                G.GAME.probabilities[k] = v * 2
            end
            return true
        end
    }))
end

return deckInfo