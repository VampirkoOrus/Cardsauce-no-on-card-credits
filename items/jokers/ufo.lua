
local jokerInfo = {
    name = "UFO COMODIN",
    config = {
        wasShop = false,
        extra = 3,
        ufo_rounds = 0,
        card_key = nil,
        card_ability = nil,
    },
    rarity = 3,
    cost = 9,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    hasSoul = true,
    no_soul_shadow = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = G.P_TAGS.tag_negative
    info_queue[#info_queue+1] = {key = "csau_artistcredit_2", set = "Other", vars = { G.csau_team.gote, G.csau_team.ele } }
    return { vars = { card.ability.ufo_rounds, card.ability.extra } }
end

function jokerInfo.add_to_deck(self, card)
    local deletable_jokers = {}
    for k, v in pairs(G.jokers.cards) do
        if not v.ability.eternal then deletable_jokers[#deletable_jokers + 1] = v end
    end
    local _card =  pseudorandom_element(deletable_jokers, pseudoseed('ufo_choice'))
    card.ability.card_key = _card.config.center.key
    card.ability.card_ability = _card.ability
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.75,
        func = function()
            _card:start_dissolve()
        return true end
    }))
end

function jokerInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.individual or context.blueprint
    if context.end_of_round and not bad_context then
        card.ability.ufo_rounds = card.ability.ufo_rounds + 1
        if card.ability.ufo_rounds == card.ability.extra then
            local eval = function(card) return not card.REMOVED end
            juice_card_until(card, eval, true)
        end
        return {
            message = (card.ability.ufo_rounds < card.ability.extra) and (card.ability.ufo_rounds..'/'..card.ability.extra) or localize('k_active_ex'),
            colour = G.C.FILTER
        }
    end
    if context.selling_self and (card.ability.ufo_rounds >= card.ability.extra) and not context.blueprint then
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
        local _card = SMODS.create_card({ set = 'Joker', area = G.jokers, key = card.ability.card_key, edition = 'e_negative' } )
        _card.ability = card.ability.card_ability
        _card:start_materialize()
        _card:add_to_deck()
        G.jokers:emplace(_card)
    end
end

return jokerInfo