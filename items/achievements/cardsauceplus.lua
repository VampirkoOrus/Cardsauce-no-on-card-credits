local trophyInfo = {
    rarity = 4,
    unlock_condition = function(self, args)
        if args.type == "discover_amount" then
            local decks = 0
            local count = 0
            for k, v in pairs(G.P_CENTERS) do
                if starts_with(k, 'j_csau_') and v.set == 'Back' and not v.omit then
                    decks = decks + 1
                    count = count + get_deck_win_stake(v.key)
                end
            end
            return count >= (decks*8)
        end
    end,
}

return trophyInfo


