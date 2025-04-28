local consumInfo = {
    name = 'I Am a Rock',
    set = 'csau_Stand',
    config = {
        aura_colors = { '4c6eb9DC', 'd01d3dDC' },
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
end

local function has_stone(hand)
    for i, v in ipairs(hand) do
        if SMODS.has_enhancement(v, 'm_stone') then return true end
    end
    return false
end

function consumInfo.calculate(self, card, context)
    if context.before and not card.debuff then
        if has_stone(context.full_hand) then
            local front = pseudorandom_element(G.P_CARDS, pseudoseed('marb_fr'))
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local _card = Card(G.discard.T.x + G.discard.T.w/2, G.discard.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.m_stone, {playing_card = G.playing_card})
            G.E_MANAGER:add_event(Event({
                func = function()
                    _card:start_materialize({G.C.SECONDARY_SET.Enhanced})
                    G.hand:emplace(_card)
                    return true
                end}))
            playing_card_joker_effects({_card})
            return {
                message = localize('k_plus_stone'),
                G.C.SECONDARY_SET.Enhanced
            }
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo