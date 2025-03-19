function scale_joker_sticker(sticker, card)
    if not sticker or not card then
        return nil, nil
    end

    if sticker.atlas.px ~= card.children.center.atlas.px and sticker.atlas.py ~= card.children.center.atlas.px then
        local x_scale = sticker.atlas.px / card.children.center.atlas.px
        local y_scale = sticker.atlas.py / card.children.center.atlas.py
        local t = {w = card.T.w, h = card.T.h}
        local vt = {w = card.VT.w, h = card.VT.h}
        card.T.w  = sticker.T.w * x_scale
        card.VT.w = sticker.T.w * x_scale
        card.T.h = sticker.T.h * y_scale
        card.VT.h = sticker.T.h * y_scale
        return t, vt
    end

    return nil, nil
end

function reset_sticker_scale(card, t, vt)
    if not t and not vt then return end

    card.T.w = t and t.w or G.CARD_W
    card.VT.w = vt and vt.w or G.CARD_W
    card.T.h = t and t.h or G.CARD_H
    card.VT.h = vt and vt.h or G.CARD_H
end