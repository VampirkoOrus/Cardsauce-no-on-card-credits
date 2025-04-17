local trophyInfo = {
    rarity = 1,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == "preserve_gros" then
            return true
        end
    end,
}

return trophyInfo