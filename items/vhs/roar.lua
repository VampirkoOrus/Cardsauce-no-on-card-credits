local consumInfo = {
    name = 'Roar',
    key = 'roar',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        activated = false,
        destroyed = false,
        extra = {
            runtime = 3,
            uses = 0
        }
    },
    origin = {
        'rlm',
        'rlm_botw',
        color = 'rlm'
    }
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}

    return { vars = { card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.can_use(self, card)
    if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or card.area == G.consumeables then return true end
end

return consumInfo