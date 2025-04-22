local trophyInfo = {
    rarity = 1,
    unlock_condition = function(self, args)
        if args.type == "activate_claus" then
            return true
        end
    end,
}

return trophyInfo