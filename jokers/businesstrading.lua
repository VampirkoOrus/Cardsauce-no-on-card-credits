local jokerInfo = {
    name = 'Business Trading Card',
    config = {
        extra = {
            dollars = 6,
            destroy = 1,
        },
        destroyed_card = nil
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
    return { vars = {card.ability.extra.dollars, G.GAME.probabilities.normal, card.ability.extra.destroy} }
end

function jokerInfo.calculate(self, card, context)
    if context.before and context.cardarea == G.jokers and not context.blueprint and G.GAME.current_round.hands_played == 0 then
        local allfaces = false
        for k, v in ipairs(context.full_hand) do
            if v:is_face() then
                allfaces = true
            end
        end
        if allfaces then
            ease_dollars(card.ability.extra.dollars)
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('$') .. card.ability.extra.dollars, colour = G.C.MONEY})
            if pseudorandom('businesstrading') < G.GAME.probabilities.normal / 3 then
                card.ability.destroyed_card = pseudorandom('businesstrading_1', 1, #context.full_hand)
                send("Destroying card: "..context.full_hand[card.ability.destroyed_card]:get_id())
            end
        end
    end
    if context.destroying_card and not context.blueprint and card.ability.destroyed_card then
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            func = function()
                context.full_hand[card.ability.destroyed_card]:start_dissolve()
                return true
            end
        }))
    end
end

return jokerInfo