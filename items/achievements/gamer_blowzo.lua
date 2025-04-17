local trophyInfo = {
    rarity = 1,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == "gamer_blowzo" then
            return true
        end
    end,
}

return trophyInfo