local consumInfo = {
    name = 'Soft & Wet',
    set = 'Stand',
    config = {
        evolve_key = 'c_csau_lion_soft_beyond',
        extra = {
            mult = 0,
            mult_mod = 1,
        }
    },
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'lion',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = {card.ability.extra.mult_mod, card.ability.extra.mult}}
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

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)
    if context.before and not card.debuff and not context.blueprint  then
        local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(context.scoring_hand)
        if G.FUNCS.hand_is_secret(text) then
            G.FUNCS.evolve_stand(card)
        else
            local enhanced = {}
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center ~= G.P_CENTERS.c_base and not v.debuff and not v.vampired then
                    enhanced[#enhanced+1] = v
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
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod*#enhanced
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.x_mult}},
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo