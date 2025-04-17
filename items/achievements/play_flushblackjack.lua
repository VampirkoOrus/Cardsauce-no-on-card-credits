local trophyInfo = {
    rarity = 1,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.handname == 'csau_FlushBlackjack' then
            return true
        end
    end,
}

return trophyInfo