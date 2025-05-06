local consumInfo = {
    name = 'Whitesnake',
    set = 'csau_Stand',
    config = {
        aura_colors = { '8b6cc9DC', '6c4ca0DC' },
        stand_mask = true,
        evolve_key = 'c_csau_stone_white_moon',
        extra = {
            evolve_cards = 0,
            evolve_num = 36,
            evolve_val = '6'
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
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.wario } }
    return { vars = {card.ability.extra.evolve_num - card.ability.extra.evolve_cards, SMODS.Ranks[card.ability.extra.evolve_val].key}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_stone_white_moon']
    or G.GAME.used_jokers['c_csau_stone_white_heaven'] then
        return false
    end
    
    return true
end

function consumInfo.calculate(self, card, context)
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
        if context.other_card:get_id() == 6 then
            return {
                func = function()
                    G.FUNCS.csau_flare_stand_aura(card, 0.38)
                end,
                message = 'Again!',
                repetitions = 1,
                card = card
            }
        end
    end
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.before and not card.debuff and not bad_context then
        local six = {}
        for k, v in ipairs(context.scoring_hand) do
            if v:get_id() == 6 then
                six[#six+1] = v
            end
        end
        card.ability.extra.evolve_cards = card.ability.extra.evolve_cards + #six
        if to_big(card.ability.extra.evolve_cards) >= to_big(card.ability.extra.evolve_num) then
            G.FUNCS.csau_evolve_stand(card)
        elseif #six > 0 then
            return {
                message = card.ability.extra.evolve_cards..'/'..card.ability.extra.evolve_num,
                colour = G.C.STAND
            }
        end
    end
end


return consumInfo