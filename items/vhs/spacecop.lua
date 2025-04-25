local consumInfo = {
    name = 'Space Cop',
    key = 'spacecop',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        activated = false,
        destroyed = false,
        extra = {
            runtime = 3,
            uses = 0,
            prob = 2,
        },
    },
    origin = 'rlm'
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
    return { vars = { G.GAME.probabilities.normal, card.ability.extra.prob, card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.set_ability(self, card, initial, delay_sprites)
    if next(SMODS.find_card("c_csau_moodyblues")) then
        card.ability.extra.runtime = card.ability.extra.runtime*2
    end
end

function consumInfo.calculate(self, card, context)
    if context.modify_level_increment and context.card then
        if context.card.ability.set == 'Planet' then
            card.ability.extra.uses = card.ability.extra.uses+1
            if card.ability.extra.uses >= card.ability.extra.runtime then
                G.FUNCS.destroy_tape(card)
                card.ability.destroyed = true
            end
            if pseudorandom('theclownhasarrived') < G.GAME.probabilities.normal / card.ability.extra.prob then
                return {
                    mult_inc = 2,
                    message = localize('k_spacecop'),
                    colour = G.C.SECONDARY_SET.Planet
                }
            end
        end
    end
end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo