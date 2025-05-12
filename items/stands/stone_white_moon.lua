local consumInfo = {
    key = 'c_csau_stone_white_moon',
    name = 'C-MOON',
    set = 'csau_Stand',
    config = {
        aura_colors = { '73b481DC', 'a3d88fDC' },
        stand_mask = true,
        evolved = true,
        evolve_key = 'c_csau_stone_white_heaven',
        extra = {
            repetitions = 1,
            evolve_moons = 0,
            evolve_num = 4,
            ranks = {}
        }
    },
    cost = 10,
    rarity = 'csau_EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'stone',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit_2", set = "Other", vars = { G.csau_team.wario, G.csau_team.gote } }
    return { vars = {card.ability.extra.evolve_num - card.ability.extra.evolve_moons}}
end

function consumInfo.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    G.FUNCS.csau_generate_detail_desc(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_stone_white']
    or G.GAME.used_jokers['c_csau_stone_white_heaven'] then
        return false
    end
    
    return true
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.using_consumeable and not card.debuff and not bad_context and context.consumeable.config.center.key == 'c_moon' then
        
        card.ability.extra.evolve_moons = card.ability.extra.evolve_moons + 1
        if card.ability.extra.evolve_moons >= card.ability.extra.evolve_num then
            G.FUNCS.csau_evolve_stand(card)
            return
        end

        return {
            func = function()
                G.FUNCS.csau_flare_stand_aura(card, 0.5)
            end,
            extra = {
                message = localize{type='variable',key='a_remaining',vars={card.ability.extra.evolve_num - card.ability.extra.evolve_moons}},
                colour = G.C.STAND,
                delay = 1
            }
        }
    end

    if context.cardarea == G.play and context.repetition and not card.debuff then
        local reps = next(context.poker_hands["Straight"]) and 1 or 0
        if context.other_card:get_id() == 6 then reps = reps + 1 end
        
        if reps > 0 then
            G.FUNCS.csau_flare_stand_aura(card, 0.38)
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                blocking = false,
                func = function()
                    card:juice_up()
                    return true
                end 
            }))
            
            return {
                func = function()
                    -- 
                end,
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.repetitions * reps,
                card = context.other_card
            }
        end
    end
end


return consumInfo