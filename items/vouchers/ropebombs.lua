local voucherInfo = {
    name = 'Rope & Bombs',
    cost = 10,
    requires = {'v_csau_lampoil'},
    config = {
        extra = {
            num_cards = 0,
            rounds = nil,
        }
    },
}

function voucherInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "artistcredit", set = "Other", vars = { csau_team.wario } }
end

function voucherInfo.redeem(self, card, area, copier)
    G.GAME.morshu_cards = G.GAME.morshu_cards + card.ability.extra.num_cards
    G.GAME.morshu_rounds = card.ability.extra.rounds

    if not G.morshu_save or not G.morshu_area then
        -- if the area already exists, set the card limit
        if G.morshu_area then G.morshu_area.config.card_limit = G.GAME.morshu_cards end

        -- set the morshu area to appear
        G.morshu_save = G.morshu_save or UIBox{
            definition = G.UIDEF.morshu_save(G.morshu_area),
            config = {align='tmi', instance_type = 'NODE', offset = {x=7.6,y=G.ROOM.T.y+29}, major = G.hand, bond = 'Weak'}
        }

        -- recreate shop card UIs for existing cards
        for k, v in pairs(G.I.CARD) do
            if v.area and v.area.config.type == 'shop' then
                if v.children.price then v.children.price:remove() end
                v.children.price = nil
                if v.children.buy_button then v.children.buy_button:remove() end
                v.children.buy_button = nil
                if v.children.buy_and_use_button then v.children.buy_and_use_button:remove() end
                v.children.buy_and_use_button = nil
                remove_nils(v.children)

                create_shop_card_ui(v)
            end
        end
    end

    G.morshu_save.alignment.offset.py = -5.3
    G.morshu_save.alignment.offset.y = G.ROOM.T.y + 29
end

return voucherInfo