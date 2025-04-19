local consumInfo = {
    name = 'Chopping Mall',
    key = 'choppingmall',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        activated = false,
        destroyed = false,
        extra = {
            runtime = 1,
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
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.wario } }
    return { vars = { card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.set_ability(self, card, initial, delay_sprites)
    if next(SMODS.find_card("c_csau_moodyblues")) then
        card.ability.extra.runtime = card.ability.extra.runtime*2
    end
end

function consumInfo.calculate(self, card, context)
    if card.ability.activated and context.before and not card.debuff and not context.blueprint then
        if context.scoring_hand[1] and SMODS.has_enhancement(context.scoring_hand[1], 'm_steel')
        and context.scoring_hand[#context.scoring_hand] and SMODS.has_enhancement(context.scoring_hand[#context.scoring_hand], 'm_steel') then
            for i = 1, 2 do
                local _card = i==1 and context.scoring_hand[1] or context.scoring_hand[#context.scoring_hand]
                G.E_MANAGER:add_event(Event({
                    func = function()
                        _card:juice_up()
                        _card:set_seal("Red", nil, true)
                        return true
                    end
                }))
            end
            card.ability.extra.uses = card.ability.extra.uses+1
            if card.ability.extra.uses >= card.ability.extra.runtime then
                G.FUNCS.destroy_tape(card)
                card.ability.destroyed = true
            end
        end
    end
end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo