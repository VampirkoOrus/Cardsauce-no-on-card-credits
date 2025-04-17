local consumInfo = {
    name = 'Soft & Wet',
    set = 'csau_Stand',
    config = {
        evolve_key = 'c_csau_lion_soft_beyond',
        extra = {
            perma_reduction = 0.5,
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'lion',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = { }}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_lion_soft_beyond'] then
        return false
    end
    
    return true
end

local enhance_match = function(center, ref_center)
    return (ref_center.set == "Enhanced" and ref_center.effect == center.effect)
end

local get_enhancement_center = function(center)
    for k, v in pairs(G.P_CENTERS) do
        if enhance_match(center, v) then return v end
    end
    for k, v in pairs(SMODS.Centers) do
        if enhance_match(center, v) then return v end
    end
end

function consumInfo.calculate(self, card, context)
    if context.before and not card.debuff and not context.blueprint then
        if not SMODS.PokerHands[context.scoring_name].visible then
            G.FUNCS.csau_evolve_stand(card)
        else
            local enhanced = {}
            for k, v in ipairs(context.scoring_hand) do
                if (v.config.center == G.P_CENTERS.m_bonus or v.config.center == G.P_CENTERS.m_mult) and not v.debuff then
                    enhanced[#enhanced+1] = v
                    local colour = v.config.center == G.P_CENTERS.m_bonus and G.C.CHIPS or v.config.center == G.P_CENTERS.m_mult and G.C.MULT
                    if v.config.center == G.P_CENTERS.m_bonus then
                        v.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                        v.ability.perma_bonus = context.other_card.ability.perma_bonus + (v.config.center.config.bonus*card.ability.extra.perma_reduction)
                    elseif v.config.center == G.P_CENTERS.m_mult then
                        v.ability.perma_mult = context.other_card.ability.perma_mult or 0
                        v.ability.perma_mult = context.other_card.ability.perma_mult + (v.config.center.config.mult*card.ability.extra.perma_reduction)
                    end
                    v.vampired = true
                    v:set_ability(G.P_CENTERS.c_base, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            v.vampired = nil
                            return true
                        end
                    }))
                end
            end
            if #enhanced > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up()
                        return true
                    end
                }))
            end
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo