local consumInfo = {
    name = 'Star Platinum',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'c640ffDC' , 'f96bffDC' },
        extra = {
            hand_mod = 1,
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'stardust',
    in_progress = true
}

function consumInfo.loc_vars(self, info_queue, card)
    return { vars = { card.ability.extra.hand_mod } }
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
            ease_hands_played(card.ability.extra.hand_mod)
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