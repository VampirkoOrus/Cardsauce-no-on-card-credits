local consumInfo = {
    name = 'Double Down',
    key = 'tbone',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        extra = {
            mult = 5,
            runtime = 3,
            uses = 0,
        },
        activated = false,
        destroyed = false,
    },
    origin = {
        'vinny',
        'vinny_wotw',
        color = 'vinny'
    }
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gong } }
    return { vars = { card.ability.extra.mult, card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.set_ability(self, card, initial, delay_sprites)
    if next(SMODS.find_card("c_csau_moodyblues")) then
        card.ability.extra.runtime = card.ability.extra.runtime*2
    end
end

function consumInfo.calculate(self, card, context)
    if context.cardarea == G.jokers and context.before and card.ability.activated then
        card.ability.extra.uses = card.ability.extra.uses+1
    end
    if card.ability.activated and context.other_joker then
        G.E_MANAGER:add_event(Event({
            func = function()
                context.other_joker:juice_up(0.5, 0.5)
                return true
            end
        }))
        return {
            message = localize{type='variable',key='a_mult',vars={to_big(card.ability.extra.mult)}},
            mult_mod = card.ability.extra.mult
        }
    end
    if context.destroy_card and not card.ability.destroyed then
        if card.ability.extra.uses >= card.ability.extra.runtime then
            G.FUNCS.destroy_tape(card)
            card.ability.destroyed = true
        end
    end
end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo