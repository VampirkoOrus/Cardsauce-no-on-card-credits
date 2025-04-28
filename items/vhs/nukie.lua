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
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.wario } }
    return { vars = { card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.set_ability(self, card, initial, delay_sprites)
    if next(SMODS.find_card("c_csau_moodyblues")) then
        card.ability.extra.runtime = card.ability.extra.runtime*2
    end
end

function consumInfo.calculate(self, card, context)
    if context.using_consumeable then
        if context.consumeable.config.center.key == 'c_wheel' then
            card.ability.extra.uses = card.ability.extra.uses+1
            if card.ability.extra.uses >= card.ability.extra.runtime then
                G.FUNCS.destroy_tape(card)
                card.ability.destroyed = true
            end
        end
    end
end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo