local consumInfo = {
    name = 'Killer Queen: Bites the Dust',
    set = 'csau_Stand',
    config = {
        evolved = true
    },
    cost = 8,
    rarity = 'csau_EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'diamond',
    in_progress = true,
}

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_diamond_killer'] then
        return false
    end
    
    return true
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)

end

local ref_gca = SMODS.get_card_areas
function SMODS.get_card_areas(_type, _context)
    local t = ref_gca(_type, _context)
    if (_context ~= 'end_of_round' and _type == 'playing_cards') and next(SMODS.find_card("c_csau_diamond_killer_btd")) then
        local retriggers = {
            cards = {}
        }
        for i = #G.play.cards, 1, -1 do
            if i ~= #G.play.cards then
                retriggers.cards[#retriggers.cards+1] = G.play.cards[i]
            end
        end
        t[#t+1] = retriggers
    end
    return t
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo