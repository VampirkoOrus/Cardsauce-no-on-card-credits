local consumInfo = {
    name = 'Exploding Varmints',
    key = 'exploding',
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
        }
    },
    origin = {
        'rlm',
        'rlm_wotw',
        color = 'rlm'
    }
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.rerun } }
    return { vars = { card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.set_ability(self, card, initial, delay_sprites)
    if next(SMODS.find_card("c_csau_moodyblues")) then
        card.ability.extra.runtime = card.ability.extra.runtime*2
    end
end

function consumInfo.calculate(self, card, context)
    if card.ability.activated and context.setting_blind and not card.getting_sliced and not card.debuff then
        local hand_amount = G.GAME.current_round.hands_left
        local mod = G.GAME.current_round.hands_left - 1
        ease_hands_played(-mod)
        ease_discard(mod)
        card.ability.extra.uses = card.ability.extra.uses+1
        if card.ability.extra.uses >= card.ability.extra.runtime then
            G.FUNCS.destroy_tape(card)
            card.ability.destroyed = true
        end
        return {
            card = card,
            message = localize{type = 'variable', key = 'a_plus_discard', vars = {card.ability.extra.discard_mod}},
            colour = G.C.RED
        }
    end
end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo