SMODS.PokerHand {
    key = "FlushFibonacci",
    chips = 144,
    mult = 13,
    l_chips = 55,
    l_mult = 5,
    visible = false,
    example = {
        { 'D_A', true },
        { 'D_2', true },
        { 'D_3', true },
        { 'D_5', true },
        { 'D_8', true },
    },
    evaluate = function(parts, hand)
        if next(SMODS.find_card("c_csau_steel_tusk_4")) then
            if next(parts._flush) then
                return { hand }
            end
        end
    end,
}

local consumInfo = {
    name = 'Tusk ACT4',
    set = 'Stand',
    config = {
        evolved = true,
        extra = {
            chips = 50,
            hand_mod = 1
        }
    },
    cost = 8,
    rarity = 'EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'steel',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = {card.ability.extra.chips, card.ability.extra.hand_mod}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_steel_tusk_1']
    or G.GAME.used_jokers['c_csau_steel_tusk_2']
    or G.GAME.used_jokers['c_csau_steel_tusk_3'] then
        return false
    end
    
    return true
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)

end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo