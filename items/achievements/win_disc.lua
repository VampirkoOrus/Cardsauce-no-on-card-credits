local trophyInfo = {
    rarity = 3,
    unlock_condition = function(self, args)
        if args.type == 'win_deck' then
            if get_deck_win_stake('b_csau_disc') then
                return true
            end
        end
    end,
}

return trophyInfo