local jokerInfo = {
    name = "Stolen Christmas",
    config = {
        extra = {
            fingers = 10,
        },
        activated = false,
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "rogernote", set = "Other"}
    return { vars = { card.ability.extra.fingers } }
end

function jokerInfo.calculate(self, card, context)
    if context.destroying_card and not context.blueprint then
        if card.ability.extra.fingers > 0 then
            card.ability.activated = true
            G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
                play_sound('whoosh2', math.random()*0.2 + 0.9,0.5)
                play_sound('crumple'..math.random(1, 5), math.random()*0.2 + 0.9,0.5)
                return true end }))
            return true
        end
    end
    if context.remove_playing_cards and card.ability.activated then
        card.ability.extra.fingers = card.ability.extra.fingers - 5
        if card.ability.extra.fingers > 0 then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_remaining',vars={card.ability.extra.fingers}},colour = G.C.IMPORTANT})
        else
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
                message = localize('k_allgone'),
                colour = G.C.FILTER
            }
        end
        card.ability.activated = false
    end
end

return jokerInfo