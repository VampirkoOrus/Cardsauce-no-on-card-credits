local consumInfo = {
    name = 'Star Platinum',
    set = 'Stand',
    config = {},
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'stardust',
    in_progress = true
}

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)
    if context.before and not card.debuff and G.GAME.current_round.hands_played == 0 then
        local all = true
        for _, v in ipairs(context.full_hand) do
            if not v:is_suit('Diamonds', nil, true) then
                all = false
                break
            end
        end
        if all then
            ease_hands_played(1)
            return {
                card = card,
                message = localize('k_plus_hand'),
                colour = G.C.BLUE
            }
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo