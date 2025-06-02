local voucherInfo = {
    name = 'Foo Fighter',
    cost = 10,
    config = {
        extra = {
            rate = 1,
        }
    },
    part = 'stone',
    csau_dependencies = {
        'enableStands',
    }
}

function voucherInfo.loc_vars(self, info_queue, card)

end

function voucherInfo.redeem(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
        func = (function()
            G.GAME.csau_stand_rate = G.GAME.csau_stand_rate + card.ability.extra.rate
            return true
        end)
    }))
end

return voucherInfo