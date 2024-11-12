local jokerInfo = {
    name = 'Chromed Up',
    config = {
        extra = {
            x_mult = 1.5
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
    return { vars = {card.ability.extra.x_mult} }
end

function jokerInfo.calculate(self, card, context)
    if context.individual and context.cardarea == G.play and not card.debuff then
        if context.other_card.ability.effect == "Steel Card" then
            return {
                x_mult = card.ability.extra.x_mult,
                card = card
            }
        end
    end
end

return jokerInfo