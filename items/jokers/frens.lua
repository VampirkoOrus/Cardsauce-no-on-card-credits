local jokerInfo = {
    name = "Frens",
    config = {
        extra = {
            chips_mod = 5,
        },
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.cejai } }
    local faces = 0
    if G.playing_cards then
        for k, v in pairs(G.playing_cards) do
            if v:is_face() then faces = faces+1 end
        end
    end
    return { vars = {card.ability.extra.chips_mod, card.ability.extra.chips_mod * faces} }
end

function jokerInfo.calculate(self, card, context)
    if card.ability.extra.chips > 0 and context.joker_main and context.cardarea == G.jokers then
        if not G.playing_cards then return end
        local faces = 0
        for k, v in pairs(G.playing_cards) do
            if v:is_face() then faces = faces+1 end
        end
        return {
            message = localize{type='variable',key='a_chips',vars={to_big(card.ability.extra.chips_mod * faces)}},
            chip_mod = card.ability.extra.chips
        }
    end
end

function jokerInfo.update(self, card, dt)


end

return jokerInfo