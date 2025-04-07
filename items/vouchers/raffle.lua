local voucherInfo = {
    name = 'Raffle',
    cost = 10,
    requires = {'v_csau_scavenger'},
    origin = 'rlm',
}

function voucherInfo.loc_vars(self, info_queue, card)
    return {}
end

function voucherInfo.redeem(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
        func = (function()
            G.GAME.vhs_rate = G.GAME.vhs_rate * 2
            return true
        end)
    }))
end

return voucherInfo