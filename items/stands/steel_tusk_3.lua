local consumInfo = {
    name = 'Tusk ACT3',
    set = 'csau_Stand',
    config = {
        evolved = true,
        evolve_key = 'c_csau_steel_tusk_4',
        extra = {
            chips = 40,
            evolve_percent = 0.1
        }
    },
    cost = 10,
    rarity = 'csau_EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'steel',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit_2", set = "Other", vars = { G.csau_team.wario, G.csau_team.cauthen } }
    return {vars = {card.ability.extra.chips, card.ability.extra.evolve_percent * 100}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_steel_tusk_1']
    or G.GAME.used_jokers['c_csau_steel_tusk_2']
    or G.GAME.used_jokers['c_csau_steel_tusk_4'] then
        return false
    end
    
    return true
end

function consumInfo.calculate(self, card, context)
    if context.individual and context.cardarea == G.play and not card.debuff and not context.repetition then
        if context.other_card:get_id() == 14 or context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 5 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
    if context.end_of_round and not card.debuff and not context.individual and not context.repetition and not context.blueprint then
        if G.GAME.chips <= (G.GAME.blind.chips * (1+card.ability.extra.evolve_percent)) then
            G.FUNCS.evolve_stand(card)
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo