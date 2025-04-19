local consumInfo = {
    name = 'Twisted Pair',
    key = 'twistedpair',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        extra = {
            runtime = 1,
            uses = 0,
        },
        activated = false,
        destroy = false,
    },
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.fenix } }
    return { vars = { card.ability.extra.runtime, card.ability.extra.uses } }
end

function consumInfo.set_ability(self, card, initial, delay_sprites)
    if next(SMODS.find_card("c_csau_moodyblues")) then
        card.ability.extra.runtime = card.ability.extra.runtime*2
    end
end

function consumInfo.calculate(self, card, context)

end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo