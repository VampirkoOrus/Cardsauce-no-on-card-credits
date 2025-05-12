local consumInfo = {
    name = 'Killer Queen',
    set = 'csau_Stand',
    config = {
        stand_mask = true,
        evolve_key = 'c_csau_diamond_killer_btd',
        aura_colors = { 'de7cf9DC', 'e059e9DC' },
        extra = {
            evolve_cards = 0,
            evolve_num = 8,
            hand_mod = 1,
            hands = 0,
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'diamond',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.guff } }
    return { vars = { card.ability.extra.hand_mod, card.ability.extra.hands, card.ability.extra.evolve_num, card.ability.extra.evolve_cards } }
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end
    if G.GAME.used_jokers['c_csau_diamond_killer_btd'] then
        return false
    end
    return true
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    
    if context.remove_playing_cards and not bad_context then
        local hands = 0
        for i, _ in ipairs(context.removed) do
            check_for_unlock({ type = "destroy_killer" })
            hands = hands + card.ability.extra.hand_mod
        end
        card.ability.extra.hands = card.ability.extra.hands + hands
        card.ability.extra.evolve_cards = card.ability.extra.evolve_cards + hands
        if to_big(card.ability.extra.evolve_cards) >= to_big(card.ability.extra.evolve_num) then
            check_for_unlock({ type = "evolve_btd" })
            G.FUNCS.csau_evolve_stand(card)
            return
        end
        
        G.FUNCS.csau_flare_stand_aura(card, 0.38)
        G.E_MANAGER:add_event(Event({func = function()
            play_sound('generic1')
            card:juice_up()
            return true
        end }))
    end

    if context.setting_blind and not bad_context and card.ability.extra.hands > 0 then
        return {
            func = function()
                G.FUNCS.csau_flare_stand_aura(card, 0.38)
                ease_hands_played(card.ability.extra.hands)
            end,
            extra = {
                message = localize{type = 'variable', key = 'a_hands', vars = {card.ability.extra.hands}}
            }
        }
    end

    if context.end_of_round and not bad_context and G.GAME.blind:get_type() == 'Boss' and card.ability.extra.hands > 0 then
        card.ability.extra.hands = 0
        return {
            message = localize('k_reset'),
        }
    end
end


return consumInfo