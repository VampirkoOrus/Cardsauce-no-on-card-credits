local consumInfo = {
    name = 'I Am a Rock',
    set = 'csau_Stand',
    config = {
        aura_colors = { '7ec7ffDC', 'ffbb49DC' },
        stand_mask = true,
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'lion',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
end

local function has_stone(hand)
    for i, v in ipairs(hand) do
        if SMODS.has_enhancement(v, 'm_stone') then return true end
    end
    return false
end

function consumInfo.calculate(self, card, context)
    if context.playing_card_added and not card.debuff then
        G.E_MANAGER:add_event(Event({
            func = function()
                local cards = {}
                for i, v in ipairs(context.cards) do
                    if not (v.iamarock or (v[1] and v[1].iamarock)) then
                        local front = pseudorandom_element(G.P_CARDS, pseudoseed('rock_fr'))
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = Card(G.discard.T.x + G.discard.T.w/2, G.discard.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.m_stone, {playing_card = G.playing_card})
                        _card.iamarock = true
                        G.hand:emplace(_card)
                        cards[#cards+1] = _card
                    end
                end
                if #cards > 0 then
                    playing_card_joker_effects({cards})
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_iamarock'), colour = G.C.STAND})
                    G.FUNCS.csau_flare_stand_aura(card, 0.38)
                end
                return true
            end}
        ))

    end
end

return consumInfo