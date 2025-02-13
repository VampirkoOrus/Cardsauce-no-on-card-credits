local jokerInfo = {
    name = "VOMIT BLAST",
    config = {
        extra = {
            mult = 0,
            mult_mod = 6,
        },
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
end

function jokerInfo.calculate(self, card, context)
    if context.pre_discard and #context.full_hand >= 5 then
        local mod = math.floor(#context.full_hand / 5)
        card.ability.extra.mult = card.ability.extra.mult + ( card.ability.extra.mult_mod * mod )
        G.E_MANAGER:add_event(Event({ func = function()
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}})
            return true
        end}))
    end
    if card.ability.extra.mult > 0 and context.joker_main and context.cardarea == G.jokers then
        return {
            mult = card.ability.extra.mult,
        }
    end
    if context.end_of_round and not context.blueprint and to_big(card.ability.extra.mult) > to_big(0) then
        card.ability.extra.mult = 0
        return {
            message = localize('k_reset'),
            colour = G.C.RED
        }
    end
end

return jokerInfo