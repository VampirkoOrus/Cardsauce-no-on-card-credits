local sleeveInfo = {
    name = 'Vine Sleeve',
    config = { csau_jokers_rate = 3, csau_all_rate = 3, },
    unlocked = false,
    unlock_condition = { deck = "b_csau_vine", stake = "stake_green" },
}

sleeveInfo.loc_vars = function(self, info_queue)
    if info_queue then

    end
    local key, vars
    if self.get_current_deck_key() == "b_csau_vine" then
        key = self.key .. "_alt"
        vars = {self.config.csau_all_rate, localize{type = 'name_text', key = 'v_overstock_plus', set = 'Voucher'}}
        self.config.voucher = "v_overstock_plus"
    else
        key = self.key
        vars = {self.config.csau_jokers_rate, localize{type = 'name_text', key = 'v_overstock_norm', set = 'Voucher'}}
        self.config.voucher = "v_overstock_norm"
    end
    return { key = key, vars = vars }
end

sleeveInfo.apply = function(self, sleeve)
    if (sleeve.config.csau_jokers_rate) then
        G.GAME.starting_params.csau_jokers_rate = G.GAME.starting_params.csau_jokers_rate or 1
        G.GAME.starting_params.csau_jokers_rate = G.GAME.starting_params.csau_jokers_rate * sleeve.config.csau_jokers_rate
    end
    if self.get_current_deck_key() == "b_csau_varg" then
        G.GAME.starting_params.csau_all_rate = G.GAME.starting_params.csau_all_rate or 1
        G.GAME.starting_params.csau_all_rate = G.GAME.starting_params.csau_all_rate * sleeve.config.csau_all_rate
    end
    CardSleeves.Sleeve.apply(sleeve)
end

return sleeveInfo