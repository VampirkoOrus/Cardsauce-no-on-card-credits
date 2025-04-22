local trophyInfo = {
    rarity = 1,
    unlock_condition = function(self, args)
        if args.type == "destroy_meteor" then
            return true
        end
    end,
}

return trophyInfo