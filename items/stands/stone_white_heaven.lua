local consumInfo = {
    name = 'Made in Heaven',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'bd53f3DC', '491d96DC' },
        stand_mask = true,
        evolved = true,
    },
    cost = 10,
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

function consumInfo.calculate(self, card, context)
    if context.before and not card.debuff then
        ease_hands_played(1)
        return {
            func = function()
                G.FUNCS.csau_flare_stand_aura(card, 0.38)
            end,
            card = card,
            message = localize{type = 'variable', key = 'a_plus_hand', vars = {1}},
            colour = G.C.BLUE
        }
    end
    if context.pre_discard then
        ease_discard(1)
        return {
            func = function()
                G.FUNCS.csau_flare_stand_aura(card, 0.38)
            end,
            card = card,
            message = localize{type = 'variable', key = 'a_plus_discard', vars = {1}},
            colour = G.C.RED
        }
    end
end


return consumInfo