local trophyInfo = {
    rarity = 2,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if G.jokers and #G.jokers.cards > 0 then
            local jokers = {
                'j_csau_besomeone',
                'j_csau_pivyot',
                'j_csau_meat',
                'j_csau_dontmind',
            }
            return G.FUNCS.have_multiple_jokers(jokers, 4)
        end
    end,
}

return trophyInfo