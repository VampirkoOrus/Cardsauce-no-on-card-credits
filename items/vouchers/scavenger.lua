local voucherInfo = {
    name = 'Scavenger Hunt',
    cost = 10,
    origin = 'rlm',
    requires = {'v_csau_scavenger'},
    unlocked = false,
    unlock_condition = {type = 'c_vhss_bought', extra = 25}
}

function voucherInfo.loc_vars(self, info_queue, card)
    return {}
end

function voucherInfo.locked_loc_vars(self, info_queue, card)
    return { vars = { self.unlock_condition.extra, G.PROFILES[G.SETTINGS.profile].career_stats.c_vhss_bought or 0} }
end

function voucherInfo.redeem(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
        func = (function()
            G.GAME.vhs_rate = G.GAME.vhs_rate * 2
            return true
        end)
    }))
end

local ref_bfs = G.FUNCS.buy_from_shop
G.FUNCS.buy_from_shop = function(e)
    local ret = ref_bfs(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0,
        func = function()
            if c1.ability.consumeable then
                if c1.config.center.set == 'VHS' then
                    inc_career_stat('c_vhss_bought', 1)
                elseif c1.config.center.set == 'Stand' then
                    inc_career_stat('c_stands_bought', 1)
                end
            end
            return true
        end
    }))
end

return voucherInfo