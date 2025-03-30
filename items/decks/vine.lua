local deckInfo = {
    name = 'Vine Deck',
    config = {},
    unlocked = false,
    discovered = false,
    config = {
        vouchers = {
            'v_overstock_norm',
        },
    },
    unlock_condition = {type = 'win_deck', deck = 'b_green'}
}

deckInfo.loc_vars = function(self, info_queue, card)
    if info_queue then
        info_queue[#info_queue+1] = {key = "guestartist8", set = "Other"}
    end
    return {vars = {localize{type = 'name_text', key = 'v_overstock_norm', set = 'Voucher'}}}
end

return deckInfo