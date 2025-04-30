local jokerInfo = {
    name = "Bulkin' The Mouscles",
    config = {
        extra = {
            x_mult = 1,
            x_mult_mod = 0.1,
        },
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.mary } }
    return { vars = { card.ability.extra.x_mult_mod, card.ability.extra.x_mult } }
end

local function upgrade(card, amount)
    amount = amount or 1
    if not card.debuff then
        card.ability.extra.x_mult = card.ability.extra.x_mult + (card.ability.extra.x_mult_mod * amount)
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}}})
    end
end

function jokerInfo.calculate(self, card, context)
    if context.using_consumeable and not card.debuff and not context.blueprint then
        local cons = context.consumeable
        if cons.ability.name == "Strength" then
            upgrade(card, #G.hand.highlighted)
        end
    end
    if context.joker_main and to_big(card.ability.extra.x_mult) > to_big(1) then
        return {
            xmult = card.ability.extra.x_mult
        }
    end
end

local card_set_ability_ref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    local old_center = self.config.center
    card_set_ability_ref(self, center, initial, delay_sprites)
    if self.area and (self.area == G.hand or self.area == G.play) and center ~= G.P_CENTERS.c_base and not initial then
        local bulks = SMODS.find_card("j_csau_bulk")
        if #G.hand.highlighted > 0 then
            for i, v in ipairs(bulks) do
                upgrade(v, #G.hand.highlighted)
            end
        else
            for i, v in ipairs(bulks) do
                upgrade(v)
            end
        end
    end
end

return jokerInfo