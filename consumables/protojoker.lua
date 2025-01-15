local consumInfo = {
    name = 'Protojoker',
    set = "Spectral",
    cost = 4,
    alerted = true,
    hidden = true,
    soul_rate = 0.003,
    soul_set = "Tarot",
}

function consumInfo.loc_vars(self, info_queue, card)
    return {}
end

function consumInfo.use(self, card, area, copier)
    check_for_unlock({ type = "activate_protojoker" })
    for i = 1, #G.jokers.cards do
        if containsString(G.jokers.cards[i].ability.name, "Joker") and not G.jokers.cards[i].getting_sliced then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                -- Based on code from Ortalab
                local _center = G.P_CENTERS['j_csau_chad']
                G.jokers.cards[i].children.center = Sprite(G.jokers.cards[i].T.x, G.jokers.cards[i].T.y, G.jokers.cards[i].T.w, G.jokers.cards[i].T.h, G.ASSET_ATLAS[_center.atlas or 'j_csau_chad'], _center.pos)
                G.jokers.cards[i].children.center.states.hover = G.jokers.cards[i].states.hover
                G.jokers.cards[i].children.center.states.click = G.jokers.cards[i].states.click
                G.jokers.cards[i].children.center.states.drag = G.jokers.cards[i].states.drag
                G.jokers.cards[i].children.center.states.collide.can = false
                G.jokers.cards[i].children.center:set_role({major = G.jokers.cards[i], role_type = 'Glued', draw_major = G.jokers.cards[i]})
                G.jokers.cards[i]:set_ability(_center)
                G.jokers.cards[i]:set_cost()
                if not G.jokers.cards[i].edition then
                    G.jokers.cards[i]:juice_up()
                    play_sound('generic1')
                else
                    G.jokers.cards[i]:juice_up(1, 0.5)
                    if G.jokers.cards[i].edition.foil then play_sound('foil1', 1.2, 0.4) end
                    if G.jokers.cards[i].edition.holo then play_sound('holo1', 1.2*1.58, 0.4) end
                    if G.jokers.cards[i].edition.polychrome then play_sound('polychrome1', 1.2, 0.7) end
                    if G.jokers.cards[i].edition.negative then play_sound('negative', 1.5, 0.4) end
                end
                return true end
            }))
        end
    end
end

function consumInfo.can_use(self, card)
    for i = 1, #G.jokers.cards do
        if containsString(G.jokers.cards[i].ability.name, "Joker") then
            return true
        end
    end
end


return consumInfo