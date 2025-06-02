local jokerInfo = {
    name = "AGGA",
    config = {
        extra = {
            x_mult = 1,
            x_mult_mod = 0.2,
            prob = 10,
        }
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)

    return { vars = {G.GAME.probabilities.normal, card.ability.extra.prob, card.ability.extra.x_mult_mod, card.ability.extra.x_mult } }
end

function jokerInfo.calculate(self, card, context)
    if context.individual and context.cardarea == G.play and not context.blueprint then
        context.other_card['agga_retrigger_count'..card.ID] = (context.other_card['agga_retrigger_count'..card.ID] and context.other_card['agga_retrigger_count'..card.ID] + 1) or 0

        if context.other_card['agga_retrigger_count'..card.ID] > 0 then
            if card.ability.extra.x_mult > 1 and pseudorandom('agga') < G.GAME.probabilities.normal / card.ability.extra.prob then
                if card.ability.extra.x_mult >= 3 then
                    check_for_unlock({ type = "high_agga" })
                end
                card.ability.extra.x_mult = to_big(1)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset'), colour = G.C.IMPORTANT})
            else
                card.ability.extra.x_mult = to_big(card.ability.extra.x_mult) + to_big(card.ability.extra.x_mult_mod)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {to_big(card.ability.extra.x_mult)}}, colour = G.C.IMPORTANT})
            end
        end
    end

    if context.after then
        for _, v in ipairs(G.playing_cards) do
            v['agga_retrigger_count'..card.ID] = nil
        end
    end

    if context.joker_main and context.cardarea == G.jokers and to_big(card.ability.extra.x_mult) > to_big(1) then
        return {
            message = localize{type='variable',key='a_xmult',vars={to_big(card.ability.extra.x_mult)}},
            Xmult_mod = card.ability.extra.x_mult,
        }
    end
end

return jokerInfo