local consumInfo = {
    name = 'Creating Rem Lezar',
    key = 'remlezar',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        unpauseable = true,
        activated = false,
        destroy = false,
    },
    origin = 'vinny'
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.greeky } }
    return { vars = { } }
end

function consumInfo.calculate(self, card, context)

end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo