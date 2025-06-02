local jokerInfo = {
    name = 'Jokers of Circumstance',
    config = {
        extra = {
            chips = 50,
            mult = 5
        }
    },
    rarity = 1,
    cost = 4,
    unlocked = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "vinny",
}

function jokerInfo.check_for_unlock(self, args)
    if args.type == "unlock_villains" then
        return true
    end
end

function jokerInfo.loc_vars(self, info_queue, card)

    return { vars = {card.ability.extra.chips, card.ability.extra.mult}}
end

function jokerInfo.calculate(self, card, context)
    if context.joker_main then
        local play_more_than = 0
        local most_played = context.scoring_name
        for k, v in pairs(G.GAME.hands) do
            if v.played >= play_more_than and v.visible then
                play_more_than = v.played
                most_played = k
            end
        end
        if most_played == context.scoring_name then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
end

return jokerInfo