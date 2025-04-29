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
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.before and not card.debuff and not bad_context then
        local stone = {}
        for k, v in ipairs(context.scoring_hand) do
            if v.ability.effect == "Stone Card" then
                stone[#stone+1] = v
                v.ability.perma_bonus = v.ability.perma_bonus or 0
                v.ability.perma_bonus = v.ability.perma_bonus + card.ability.extra.chips
                v:set_ability(G.P_CENTERS.c_base, nil, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize('k_stone_free'), colour = G.C.CHIPS})
                        return true
                    end
                }))
            end
        end
        if #stone > 0 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.FUNCS.csau_flare_stand_aura(card, 0.38)
                    card:juice_up()
                    return true
                end
            }))
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo