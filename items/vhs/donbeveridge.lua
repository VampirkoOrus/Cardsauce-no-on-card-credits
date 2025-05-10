local consumInfo = {
    name = 'Don Beveridge Customerization Seminar',
    key = 'donbeveridge',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        extra = {
            runtime = 5,
            uses = 0
        },
        activated = false,
        destroyed = false,
    },
    origin = {
        'rlm',
        'rlm_bs',
        color = 'rlm'
    }
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.chvsau } }
    return { vars = { card.ability.extra.runtime-card.ability.extra.uses } }
end

local ref_fe = SMODS.food_expires
SMODS.food_expires = function(context)
    local bagels = G.FUNCS.find_activated_tape('c_csau_donbeveridge')
    if bagels and not bagels.ability.destroyed then
        bagels:juice_up()
        bagels.ability.extra.uses = bagels.ability.extra.uses+1
        if to_big(bagels.ability.extra.uses) >= to_big(bagels.ability.extra.runtime) then
            G.FUNCS.destroy_tape(bagels)
            bagels.ability.destroyed = true
        end
        return false
    end
    return ref_fe(context)
end

function consumInfo.can_use(self, card)
    if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or card.area == G.consumeables then return true end
end

return consumInfo