local voucherInfo = {
    name = 'Scavenger Hunt',
    cost = 10,
    config = {
        rate = 4,
    }
}

function voucherInfo.loc_vars(self, info_queue, card)
    return {}
end

function voucherInfo.redeem(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
        func = (function()
            G.GAME.vhs_rate = card.ability.rate
            return true
        end)
    }))
end

return voucherInfo