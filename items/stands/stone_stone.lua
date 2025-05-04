local consumInfo = {
    name = 'Stone Free',
    set = 'csau_Stand',
    config = {
        aura_colors = { '4db8cfDC', '4d89cfDC' },
        stand_mask = true,
        extra = {
            chips = 60,
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'stone',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.chvsau } }
    return { vars = {card.ability.extra.chips}}
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.retrigger_joker
    if context.individual and context.cardarea == G.play and not card.debuff then
        if context.other_card.ability.effect == "Stone Card" then
            local oc = context.other_card
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            G.FUNCS.csau_flare_stand_aura(card, 0.38)
                            card:juice_up()
                            oc:set_ability(G.P_CENTERS.c_base)
                            oc.ability.perma_bonus = oc.ability.perma_bonus or 0
                            oc.ability.perma_bonus = oc.ability.perma_bonus + card.ability.extra.chips
                            return true
                        end)
                    }))
                end,
                message = localize('k_stone_free'),
                colour = G.C.CHIPS,
                card = context.other_card
            }
        end
    end
end


return consumInfo