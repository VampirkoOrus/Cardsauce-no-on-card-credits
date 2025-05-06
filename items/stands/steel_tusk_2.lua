local consumInfo = {
    name = 'Tusk ACT2',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'ff7dbcDC', '81476fDC' },
        evolved = true,
        evolve_key = 'c_csau_steel_tusk_3',
        extra = {
            chips = 21,
            evolve_destroys = 0,
            evolve_num = 3,
            evolved = false,
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
    return {vars = {card.ability.extra.chips, card.ability.extra.evolve_num - card.ability.extra.evolve_destroys}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_steel_tusk_1']
    or G.GAME.used_jokers['c_csau_steel_tusk_3']
    or G.GAME.used_jokers['c_csau_steel_tusk_4'] then
        return false
    end
    
    return true
end

function consumInfo.calculate(self, card, context)
    if context.individual and context.cardarea == G.play and not card.debuff then
        if context.other_card:get_id() == 14 or context.other_card:get_id() == 2 or context.other_card:get_id() == 3 then
            return {
                func = function()
                    G.FUNCS.csau_flare_stand_aura(card, 0.38)
                end,
                chips = card.ability.extra.chips
            }
        end
    end
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.remove_playing_cards and not bad_context then
        local cards = 0
        for i, card in ipairs(context.removed) do
            cards = cards + 1
        end
        card.ability.extra.evolve_destroys = card.ability.extra.evolve_destroys + cards
        if to_big(card.ability.extra.evolve_destroys) >= to_big(card.ability.extra.evolve_num) and not card.ability.extra.evolved then
            card.ability.extra.evolved = true
            G.FUNCS.csau_evolve_stand(card)
            return
        else
            return {
                message = card.ability.extra.evolve_destroys..'/'..card.ability.extra.evolve_num,
                colour = G.C.STAND
            }
        end
    end
end


return consumInfo