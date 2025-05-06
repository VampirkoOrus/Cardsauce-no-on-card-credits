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
        for i, _card in ipairs(context.removed) do
            check_for_unlock({ type = "destroy_killer" })
            hands = hands + card.ability.extra.hand_mod
        end
        card.ability.extra.hands = hands
        card.ability.extra.evolve_cards = card.ability.extra.evolve_cards + hands
        if to_big(card.ability.extra.evolve_cards) >= to_big(card.ability.extra.evolve_num) then
            check_for_unlock({ type = "evolve_btd" })
            G.FUNCS.csau_evolve_stand(card)
            return
        end
        card:juice_up()
    end
    if context.setting_blind and not card.debuff and card.ability.extra.hands > 0 then
        if not (context.blueprint_card or card).getting_sliced then
            G.E_MANAGER:add_event(Event({func = function()
                ease_hands_played(card.ability.extra.hands)
                G.FUNCS.csau_flare_stand_aura(card, 0.38)
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..card.ability.extra.hands.." "..localize('k_hud_hands')})
                card.ability.extra.hands = 0
                return true
            end }))
        end
    end
end


return consumInfo