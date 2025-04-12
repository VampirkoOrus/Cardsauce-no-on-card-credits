local consumInfo = {
    name = 'Dirty Deeds Done Dirt Cheap',
    set = 'Stand',
    config = {
        stand_overlay = true,
        evolve_key = 'c_csau_steel_d4c_love',
        extra = {
            evolve_num = 9,
        }
    },
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'steel',
    in_progress = true,
}

local function get_lucky()
    if not G.playing_cards then return 0 end
    local lucky = 0
    for k, v in pairs(G.playing_cards) do
        if v.ability.effect == "Lucky Card" then lucky = lucky+1 end
    end
    return lucky
end

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = {card.ability.extra.evolve_num, get_lucky()}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_steel_d4c_love'] then
        return false
    end
    
    return true
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
    check_for_unlock({ type = "discover_d4c" })
end

function consumInfo.calculate(self, card, context)
    if context.destroy_card and context.cardarea == G.play then
        if context.scoring_name == "Pair" and not card.ability.activated then
            context.destroying_card = context.scoring_hand
            card.ability.activated = true
            return true
        end
    end
    if context.end_of_round then
        card.ability.activated = false
    end
end

function consumInfo.can_use(self, card)
    return false
end

function consumInfo.update(self, card)
    if not card.area.config.collection and get_lucky() >= card.ability.extra.evolve_num then
        G.FUNCS.evolve_stand(card)
    end
end

return consumInfo