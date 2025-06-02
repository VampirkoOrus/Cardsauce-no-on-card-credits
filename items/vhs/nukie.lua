local consumInfo = {
    name = 'Nukie',
    key = 'nukie',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        activated = false,
        destroyed = false,
        extra = {
            runtime = 2,
            uses = 0,
        }
    },
    origin = 'rlm'
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "wheel2", set = "Other", vars = {G.GAME.probabilities.normal}}
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}

    return { vars = { card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.calculate(self, card, context)
    if context.using_consumeable then
        if context.consumeable.config.center.key == 'c_wheel' then
            card.ability.extra.uses = card.ability.extra.uses+1
            if to_big(card.ability.extra.uses) >= to_big(card.ability.extra.runtime) then
                G.FUNCS.destroy_tape(card)
                card.ability.destroyed = true
            end
        end
    end
end

function consumInfo.can_use(self, card)
    if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or card.area == G.consumeables then return true end
end

return consumInfo