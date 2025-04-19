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
    return { vars = { card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.set_ability(self, card, initial, delay_sprites)
    if next(SMODS.find_card("c_csau_moodyblues")) then
        card.ability.extra.runtime = card.ability.extra.runtime*2
    end
end

local ref_fe = SMODS.food_expires
SMODS.food_expires = function(context)
    local bagels = G.FUNCS.find_activated_tape('c_csau_donbeveridge')
    if bagels then
        bagels.ability.extra.uses = bagels.ability.extra.uses+1
        if bagels.ability.extra.uses >= bagels.ability.extra.runtime then
            G.FUNCS.destroy_tape(bagels)
            bagels.ability.destroyed = true
        end
        return false
    end
    return ref_fe(context)
end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo