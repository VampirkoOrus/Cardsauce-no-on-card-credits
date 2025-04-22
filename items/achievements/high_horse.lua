local trophyInfo = {
    rarity = 2,
    unlock_condition = function(self, args)
        if args.type == "high_horse" then
            return true
        end
    end,
}

return trophyInfo