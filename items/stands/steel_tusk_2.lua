local consumInfo = {
    name = 'Tusk ACT2',
    set = 'Stand',
    config = {
        evolved = true,
        evolve_key = 'c_csau_steel_tusk_3',
        extra = {
            chips = 30,
            evolve_destroys = 0,
            evolve_num = 3,
        }
    },
    cost = 6,
    rarity = 'EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'steel',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
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

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)
    if context.individual and context.cardarea == G.play and not card.debuff and not context.repetition then
        if context.other_card:get_id() == 14 or context.other_card:get_id() == 2 or context.other_card:get_id() == 3 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
    if context.remove_playing_cards then
        local cards = 0
        for i, card in ipairs(context.removed) do
            cards = cards + 1
        end
        card.ability.extra.evolve_destroys = card.ability.extra.evolve_destroys + cards
        if card.ability.extra.evolve_destroys >= card.ability.extra.evolve_num then
            G.FUNCS.evolve_stand(card)
            return
        else
            return {
                message = card.ability.extra.evolve_destroys..'/'..card.ability.extra.evolve_num,
                colour = G.C.STAND
            }
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo