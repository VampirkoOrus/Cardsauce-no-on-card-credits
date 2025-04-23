local consumInfo = {
    name = 'Devil Story',
    key = 'devilstory',
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
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gong } }
    return { vars = { card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.set_ability(self, card, initial, delay_sprites)
    if next(SMODS.find_card("c_csau_moodyblues")) then
        card.ability.extra.runtime = card.ability.extra.runtime*2
    end
end

function consumInfo.calculate(self, card, context)
    if card.ability.activated and context.before and not card.debuff and not context.blueprint then
        local count = 0
        for i, v in ipairs(context.scoring_hand) do
            if not v.seal and v.ability.effect ~= "Base" then
                count = count + 1
                v.seal_delay = true
                v:set_seal("Gold", nil, nil, {set_func = function()
                    card:juice_up()
                end} )
            end
        end
        if count > 0 then
            if count >= 5 then
                check_for_unlock({ type = "high_horse" })
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    card.ability.extra.uses = card.ability.extra.uses+1
                    if card.ability.extra.uses >= card.ability.extra.runtime then
                        G.FUNCS.destroy_tape(card)
                        card.ability.destroyed = true
                    end
                    return true
                end
            }))
        end
    end
end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo