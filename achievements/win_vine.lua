local trophyInfo = {
    rarity = 3,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)

        if args.type == 'win_deck' then
            if G.GAME.selected_back_key.key == 'b_csau_vine' then
                return true
            end
        end
    end,
}

return trophyInfo