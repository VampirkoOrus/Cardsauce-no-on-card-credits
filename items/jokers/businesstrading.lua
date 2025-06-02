local jokerInfo = {
    name = 'Business Trading Card',
    config = {
        extra = {
            dollars = 6,
            destroy = 1,
            destroyed = {},
        },
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "vinny",
}

function jokerInfo.loc_vars(self, info_queue, card)

    return { vars = {card.ability.extra.dollars, G.GAME.probabilities.normal, card.ability.extra.destroy} }
end

local function all_faces(hand)
    local allfaces = true
    for k, v in ipairs(hand) do
        if not v:is_face() then
            return false
        end
    end
    return true
end

function jokerInfo.calculate(self, card, context)
    if context.before and context.cardarea == G.jokers and not context.blueprint and to_big(G.GAME.current_round.hands_played) == to_big(0) then
        if all_faces(context.full_hand) then
            ease_dollars(to_big(card.ability.extra.dollars))
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('$') .. to_big(card.ability.extra.dollars), colour = G.C.MONEY})
        end
    end
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.final_scoring_step and not bad_context then
        if all_faces(context.full_hand) and pseudorandom('businesstrading') < G.GAME.probabilities.normal / 3 then
            card.ability.extra.destroyed = context.full_hand[pseudorandom('businesstrading_1', 1, #context.full_hand)]
        end
    end
    if context.destroying_card and table.contains(context.full_hand, context.destroy_card) and not bad_context then
        if context.destroy_card == card.ability.extra.destroyed then
            return true
        end
    end
    if context.end_of_round then
        card.ability.extra.destroyed = nil
    end
end

return jokerInfo