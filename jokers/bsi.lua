local jokerInfo = {
    name = "Blue Shell Incident",
    config = {
        extra = {
            x_mult = 3,
        },
        ace_tally = 0,
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    return { vars = {card.ability.extra.x_mult, card.ability.ace_tally} }
end

function jokerInfo.calculate(self, card, context)
    if card.ability.ace_tally == 0 and context.joker_main and context.cardarea == G.jokers then
        return {
            message = localize{type='variable',key='a_xmult',vars={to_big(card.ability.extra.x_mult)}},
            Xmult_mod = card.ability.extra.x_mult,
        }
    end
end

function jokerInfo.update(self, card, dt)
    if not G.playing_cards then return end
    card.ability.ace_tally = 0
    for k, v in pairs(G.playing_cards) do
        if v:get_id() == 14 then card.ability.ace_tally = card.ability.ace_tally+1 end
    end
end

return jokerInfo