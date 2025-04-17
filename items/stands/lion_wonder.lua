local consumInfo = {
    name = 'Wonder of U',
    set = 'csau_Stand',
    config = {
        extra = {
            mult = 0,
            mult_mod = 1,
        }
    },
    cost = 10,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'lion',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = {card.ability.extra.mult_mod, card.ability.extra.mult}}
end

function consumInfo.calculate(self, card, context)
    if context.individual and context.cardarea == G.play and not card.debuff and not context.blueprint then
        if context.other_card.ability.effect == 'Lucky Card' and not context.other_card.debuff then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED,
                card = card
            }
        end
    end
    if context.joker_main then
        return {
            mult = card.ability.extra.mult,
        }
    end
    if context.destroy_card and not context.blueprint then
        if context.destroy_card.ability.effect == 'Lucky Card' then
            return {
                remove = true,
            }
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo