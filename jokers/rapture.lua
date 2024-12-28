local jokerInfo = {
    name = 'Rapture',
    config = {
        extra = {
            mult = 0,
            mult_mod = 1
        }
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "guestartist21", set = "Other"}
    return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult }}
end

function jokerInfo.add_to_deck(self, card)
    check_for_unlock({ type = "discover_rapture" })
end

function jokerInfo.calculate(self, card, context)
    if context.cardarea == G.jokers and context.before and not card.debuff then
        if context.scoring_hand == "High Card" and card.ability.extra.mult > 0 then
            card.ability.extra.mult = 0
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end
    else
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
        return {
            card = card,
            message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}
        }
    end
    if context.joker_main and context.cardarea == G.jokers and not card.debuff then
        if card.ability.extra.mult > 0 then
            return {
                message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult,
            }
        end
    end
end

return jokerInfo