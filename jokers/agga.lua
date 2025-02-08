local jokerInfo = {
    name = "AGGA",
    config = {
        extra = {
            x_mult = 1,
            x_mult_mod = 0.2,
        }
    },
    rarity = 2,
    cost = 6,
    unlocked = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    streamer = "vinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "guestartist1", set = "Other"}
end

return jokerInfo