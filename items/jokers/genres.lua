local jokerInfo = {
    name = "Battle of the Genres",
    config = {
        extra = {
            hand_mod = 1
        }
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "othervinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
    return { vars = { } }
end

function jokerInfo.calculate(self, card, context)

end

return jokerInfo
	