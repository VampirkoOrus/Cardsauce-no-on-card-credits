local deckInfo = {
    name = 'DISC Deck',
    config = {
        vouchers = {
            'v_crystal_ball',
        },
    },
    unlocked = false,
    csau_dependencies = {
        'enableStands',
    },
}

function deckInfo.check_for_unlock(self, args)
    if args.type == 'evolve_stand' then
        return true
    end
end

function deckInfo.loc_vars(self, info_queue, card)
    if info_queue then

    end
    return {vars = { localize{type = 'name_text', key = 'v_crystal_ball', set = 'Voucher'} } }
end

function deckInfo.apply(self, back)
    G.GAME.csau_unlimited_stands = true
end

return deckInfo