local trophyInfo = {
    rarity = 3,
    hidden_text = true,
    unlock_key = 'j_csau_quarterdumb',
    unlock_condition = function(self, args)
        return G.FUNCS.csau_center_discovered(self.unlock_key)
    end,
}

return trophyInfo