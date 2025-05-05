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
    width = 178,
    height = 238,
    streamer = "vinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.bard } }
    return { vars = {card.ability.extra.dollars, G.GAME.probabilities.normal, card.ability.extra.destroy} }
end

function jokerInfo.set_sprites(self, card, _front)
    G.FUNCS.csau_set_big_sprites(self, card)
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
    if context.before and context.cardarea == G.jokers and not context.blueprint and G.GAME.current_round.hands_played == 0 then
        if all_faces(context.full_hand) then
            ease_dollars(to_big(card.ability.extra.dollars))
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('$') .. to_big(card.ability.extra.dollars), colour = G.C.MONEY})
        end
    end
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.final_scoring_step and not bad_context then
        if all_faces(context.full_hand) and pseudorandom('businesstrading') < G.GAME.probabilities.normal / 3 then
            card.ability.extra.destroyed[#card.ability.extra.destroyed+1] = context.full_hand[pseudorandom('businesstrading_1', 1, #context.full_hand)]
        end
    end
    if context.destroying_card and table.contains(context.full_hand, context.destroy_card) and not bad_context then
        local allfaces = true
        for k, v in ipairs(context.full_hand) do
            if not v:is_face() then
                allfaces = false
            end
        end
        if allfaces and card.ability.extra.destroyed < card.ability.extra.destroy then
            if pseudorandom('businesstrading') < G.GAME.probabilities.normal / 3 then
                card.ability.extra.destroyed = card.ability.extra.destroyed + 1
                return true
            end
        end
    end
    if context.end_of_round then
        card.ability.extra.destroyed = 0
    end
end

return jokerInfo