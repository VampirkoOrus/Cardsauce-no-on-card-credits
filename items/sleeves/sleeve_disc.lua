local sleeveInfo = {
    name = 'DISC Sleeve',
    config = {},
    unlocked = false,
    unlock_condition = { deck = "b_csau_disc", stake = "stake_green" },
}

sleeveInfo.loc_vars = function(self, info_queue)
    if info_queue then

    end
    local key
    if self.get_current_deck_key() == "b_csau_disc" then
        key = self.key .. "_alt"
        self.config = { voucher = "v_csau_foo" }
    else
        key = self.key
        self.config = { voucher = 'v_crystal_ball' }
    end
    local vars = { localize{type = 'name_text', key = self.config.voucher, set = 'Voucher'} }
    return { key = key, vars = vars }
end

function sleeveInfo.apply(self, back)
    G.GAME.csau_unlimited_stands = true
end

return sleeveInfo