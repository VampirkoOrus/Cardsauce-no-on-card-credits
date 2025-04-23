local jokerInfo = {
    name = 'Mug',
    config = {
        form = 'mug',
        extra = {
            mult = 1,
            mult_xmod = 2,
            x_mult = 6,
            rounds = 5,
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    streamer = "joel",
}

local forms = {
    ["Mug"] = {'mug', {x=0,y=0} },
    ["Moment"] = {'moment', {x=1,y=0} },
}

local change_form = function(card, form)
    if forms[form] then
        card.ability.form = forms[form][1]
        card.config.center.pos = forms[form][2]
    else
        for k, v in pairs(forms) do
            if v[1] == form then
                card.ability.form = v[1]
                card.config.center.pos = v[2]
            end
        end
    end
    return card.ability.form
end

function jokerInfo.loc_vars(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.rounds, card.ability.extra.x_mult } }
end

function jokerInfo.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    if card.area and card.area == G.jokers or card.config.center.discovered then
        -- If statement makes it so that this function doesnt activate in the "Joker Unlocked" UI and cause 'Not Discovered' to be stuck in the corner
        full_UI_table.name = localize{type = 'name', key = "j_csau_mug_"..card.ability.form, set = self.set, name_nodes = {}, vars = specific_vars or {}}
    end
    localize{type = 'descriptions', key = "j_csau_mug_"..card.ability.form, set = self.set, nodes = desc_nodes, vars = self.loc_vars(self, info_queue, card).vars}
end

function jokerInfo.set_sprites(self, card, _front)
    if card.config.center.discovered or card.bypass_discovery_center then
        card.children.center:reset()
    end
end

function jokerInfo.calculate(self, card, context)
    if context.joker_main and context.cardarea == G.jokers then
        if card.ability.form == "mug" then
            return {
                mult = card.ability.extra.mult,
            }
        elseif card.ability.form == "moment" then
            return {
                xmult = card.ability.extra.x_mult,
            }
        end
    end
    if context.end_of_round and not context.other_card then
        if card.ability.form == "moment" and SMODS.food_expires(context) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                         func = function()
                             G.jokers:remove_card(card)
                             card:remove()
                             card = nil
                             return true
                         end
                    }))
                    return true
                end
            }))
            return {
                message = localize('k_mug_gone'),
                colour = G.C.FILTER
            }
        elseif card.ability.form == "mug" then
            card.ability.extra.mult = card.ability.extra.mult * 2
            card.ability.extra.rounds = card.ability.extra.rounds - 1
            if card.ability.extra.rounds <= 0 then
                check_for_unlock({ type = "activate_mug" })
                change_form(card, "Moment")
                card:juice_up(1, 1)
                card:set_sprites(card.config.center)
                return {
                    message = localize('k_mug_moment'),
                    colour = G.C.MUG
                }
            else
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                    colour = G.C.MULT
                }
            end
        end
    end
end

function jokerInfo.update(self, card)
    if G.screenwipe then
        change_form(card, card.ability.form)
        card:set_sprites(card.config.center)
    end
end

return jokerInfo