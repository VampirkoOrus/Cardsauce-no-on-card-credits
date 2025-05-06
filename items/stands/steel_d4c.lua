local consumInfo = {
    name = 'Dirty Deeds Done Dirt Cheap',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'f3b7f5DC', 'c77ecfDC' },
        stand_mask = true,
        evolve_key = 'c_csau_steel_d4c_love',
        extra = {
            hands_played = {},
            evolve_num = 9,
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
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
    info_queue[#info_queue+1] = G.P_CENTERS.m_lucky
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
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
    check_for_unlock({ type = "discover_d4c" })
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.before and not bad_context then
        card.ability.extra.hands_played[context.scoring_name] = card.ability.extra.hands_played[context.scoring_name] or 0
        card.ability.extra.hands_played[context.scoring_name] = card.ability.extra.hands_played[context.scoring_name] + 1
    end
    if context.destroying_card and not bad_context then
        if context.scoring_name == "Pair" and card.ability.extra.hands_played[context.scoring_name] == 1 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.FUNCS.csau_flare_stand_aura(card, 0.38)
                    card:juice_up()
                    return true
                end
            }))
            return true
        end
    end
    if context.end_of_round and not bad_context then
        card.ability.extra.hands_played = {}
    end
end


function consumInfo.update(self, card)
    if not card.area.config.collection and card.area == G.consumeables and to_big(get_lucky()) >= to_big(card.ability.extra.evolve_num) and not card.ability.evolved then
        check_for_unlock({ type = "evolve_d4c" })
        card.ability.evolved = true
        G.FUNCS.csau_evolve_stand(card)
    end
end

return consumInfo