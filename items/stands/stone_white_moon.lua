local consumInfo = {
    name = 'C-MOON',
    set = 'csau_Stand',
    config = {
        aura_colors = { '73b481DC', 'a3d88fDC' },
        stand_mask = true,
        evolved = true,
        evolve_key = 'c_csau_stone_white_heaven',
        extra = {
            repetitions = 1,
            evolve_ranks = 0,
            evolve_num = 13,
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
    return { vars = {card.ability.extra.evolve_num}}
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

local function unique_ranks_check(card, new_rank, num)
    card.ability.extra.ranks[new_rank] = true
    local count = 0
    for k, v in pairs(card.ability.extra.ranks) do
        if v == true then count = count + 1 end
    end
    return count >= num
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.before and not card.debuff and not bad_context then
        if next(context.poker_hands["Straight"]) then
            local evolved = false
            for k, v in ipairs(context.full_hand) do
                if not v.debuff then
                    evolved = unique_ranks_check(card, v.base.value, card.ability.extra.evolve_num)
                end
            end
            if evolved then
                check_for_unlock({ type = "evolve_heaven" })
                G.FUNCS.csau_evolve_stand(card)
            end
        end
    end
    if context.cardarea == G.play and context.repetition and not context.repetition_only and not card.debuff then
        if next(context.poker_hands["Straight"]) then
            for k, v in ipairs(context.full_hand) do
                if not v.debuff then
                    return {
                        func = function()
                            G.FUNCS.csau_flare_stand_aura(card, 0.38)
                        end,
                        message = 'Again!',
                        repetitions = card.ability.extra.repetitions,
                        card = context.other_card
                    }
                end
            end
        end
    end
end


return consumInfo