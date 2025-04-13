local consumInfo = {
    name = 'Whitesnake',
    set = 'csau_Stand',
    config = {
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

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.individual or context.blueprint
    if context.before and not card.debuff and not bad_context then
        local six = {}
        for k, v in ipairs(context.scoring_hand) do
            if v:get_id() == 6 then
                six[#six+1] = v
            end
        end
        card.ability.extra.evolve_cards = card.ability.extra.evolve_cards + #six
        if card.ability.extra.evolve_cards >= card.ability.extra.evolve_num then
            G.FUNCS.csau_evolve_stand(card)
        else
            return {
                message = card.ability.extra.evolve_cards..'/'..card.ability.extra.evolve_num,
                colour = G.C.STAND
            }
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo