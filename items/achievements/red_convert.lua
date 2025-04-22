local trophyInfo = {
    rarity = 3,
    unlock_condition = function(self, args)
        if args.type == "red_convert" then
            return true
        end
    end,
}

return trophyInfo