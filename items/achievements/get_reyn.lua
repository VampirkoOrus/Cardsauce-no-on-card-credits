local trophyInfo = {
    rarity = 1,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'modify_jokers' and G.jokers and G.GAME.round_resets.ante == 1 then
            for _, v in pairs(G.jokers.cards) do
                if v.config.center.key == 'j_csau_reyn' then
                    return true
                end
            end
        end
    end,
}

return trophyInfo