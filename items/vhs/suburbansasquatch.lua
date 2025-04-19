local consumInfo = {
    name = 'Suburban Sasquatch',
    key = 'suburbansasquatch',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        extra = {
        },
        activated = false,
        destroy = false,
    },
    origin = {
        'rlm',
        'rlm_botw',
        color = 'rlm'
    }
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}
    return { vars = { } }
end

function consumInfo.calculate(self, card, context)

end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo