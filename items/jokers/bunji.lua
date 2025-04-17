local jokerInfo = {
    name = "Scourge Of Pantsylvania",
    config = {},
    rarity = 2,
    cost = 5,
    unlocked = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "vinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.fenix } }
    return { vars = { } }
end

function jokerInfo.check_for_unlock(self, args)
    if args.type == "discover_frich" then
        return true
    end
end

return jokerInfo