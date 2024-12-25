local jokerInfo = {
    name = "Beginner's Luck",
    config = {
        prob_mult = 3
    },
    rarity = 2,
    cost = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "guestartist0", set = "Other"}
end

function jokerInfo.in_pool(self, args)
    if G.GAME.round_resets.ante <= 4 then
        return true
    end
end

function jokerInfo.add_to_deck(self, card)
    check_for_unlock({ type = "discover_beginners" })
    for k, v in pairs(G.GAME.probabilities) do
        G.GAME.probabilities[k] = v * card.ability.prob_mult
    end
end

function jokerInfo.remove_from_deck(self, card)
    for k, v in pairs(G.GAME.probabilities) do
        G.GAME.probabilities[k] = v / card.ability.prob_mult
    end
end

function jokerInfo.calculate(self, card, context)
    if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
        if G.GAME.round_resets.ante >= 3 and G.GAME.blind.boss then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                         func = function()
                             G.jokers:remove_card(card)
                             card:remove()
                             card = nil
                             return true
                         end
                    }))
                    return true
                end
            }))
            return {
                message = localize('k_eaten_ex'),
                colour = G.C.MONEY
            }
        end
    end
end

return jokerInfo