local consumInfo = {
    name = 'Made in Heaven',
    set = 'csau_Stand',
    config = {
        stand_mask = true,
        evolved = true,
    },
    cost = 8,
    rarity = 'csau_EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'stone',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.wario } }
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_stone_white_moon']
    or G.GAME.used_jokers['c_csau_stone_white'] then
        return false
    end
    
    return true
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)
    if context.before and not card.debuff then
        ease_hands_played(1)
        return {
            card = card,
            message = localize{type = 'variable', key = 'a_plus_hand', vars = {1}},
            colour = G.C.BLUE
        }
    end
    if context.pre_discard and context.cardarea == G.play then
        ease_discard(1)
        return {
            card = card,
            message = localize{type = 'variable', key = 'a_plus_discard', vars = {1}},
            colour = G.C.RED
        }
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo