local jokerInfo = {
    name = "That Fucking Koffing Again",
    config = {},
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "vinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "guestartist0", set = "Other"}
end

function jokerInfo.add_to_deck(self, card)
    check_for_unlock({ type = "discover_koffing" })
end

return jokerInfo