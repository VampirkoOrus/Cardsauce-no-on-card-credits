local jokerInfo = {
    name = 'Skeleton Metal',
    config = {
        extra = 2,
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_steel
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
    return { vars = { card.ability.extra } }
end

function jokerInfo.calculate(self, card, context)
    if context.before and G.GAME.current_round.hands_left == 0 and not context.blueprint and not card.debuff then
        local cards = {}
        for i=1, card.ability.extra do
            local _card = create_playing_card({
                front = pseudorandom_element(G.P_CARDS, pseudoseed('hereinmycoffin')),
                center = G.P_CENTERS.m_steel}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
            G.GAME.blind:debuff_card(_card)
            cards[#cards+1] = _card
        end
        playing_card_joker_effects({cards})
        G.hand:sort()
        if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
    end
end

return jokerInfo
	