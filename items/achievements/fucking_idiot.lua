local trophyInfo = {
    rarity = 3,
    unlock_condition = function(self, args)
        if G.jokers and #G.jokers.cards > 0 then
            local jokers = {
                'j_csau_powers',
                'j_csau_nutbuster',
            }
            return G.FUNCS.have_multiple_jokers(jokers)
        end
    end,
}

return trophyInfo