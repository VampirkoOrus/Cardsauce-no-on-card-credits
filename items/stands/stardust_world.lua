local consumInfo = {
    name = "DIO's World",
    set = 'Stand',
    config = {
        extra = {
            hand_mod = 1,
        }
    },
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'stardust',
    in_progress = true,
}

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "guestartist0", set = "Other"}
    return { vars = { card.ability.extra.hand_mod } }
end

function consumInfo.calculate(self, card, context)
    if context.before and not card.debuff and G.GAME.current_round.hands_played == 0 then
        local all = true
        for _, v in ipairs(context.full_hand) do
            if not v:is_suit('Spades', nil, true) then
                all = false
                break
            end
        end
        if all then
            ease_hands_played(card.ability.extra.hand_mod)
            return {
                card = card,
                message = localize{type = 'variable', key = 'a_hands', vars = {self.ability.extra}},
                colour = G.C.BLUE
            }
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo