local consumInfo = {
    name = 'Suburban Sasquatch',
    key = 'suburbansasquatch',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        activated = false,
        destroy = false,
        extra = {
            inc = 1,
            runtime = 2,
            uses = 0,
        },
    },
    origin = {
        'rlm',
        'rlm_botw',
        color = 'rlm'
    }
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}
    return { vars = { card.ability.extra.inc, card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.set_ability(self, card, initial, delay_sprites)
    if next(SMODS.find_card("c_csau_moodyblues")) then
        card.ability.extra.runtime = card.ability.extra.runtime*2
    end
end

function consumInfo.calculate(self, card, context)
    if context.final_scoring_step then
        G.E_MANAGER:add_event(Event({
            func = function()
                for i, v in ipairs(context.scoring_hand) do
                    assert(SMODS.modify_rank(v, card.ability.extra.inc))
                    v:juice_up()
                end
                card:juice_up()
                card.ability.extra.uses = card.ability.extra.uses+1
                if card.ability.extra.uses >= card.ability.extra.runtime then
                    G.FUNCS.destroy_tape(card)
                    card.ability.destroyed = true
                end
                return true
            end
        }))
        return {
            message = localize('k_upgrade_ex'),
            card = card
        }
    end
end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo