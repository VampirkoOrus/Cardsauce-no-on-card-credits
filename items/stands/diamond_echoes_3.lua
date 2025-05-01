local consumInfo = {
    name = 'Echoes ACT3',
    set = 'csau_Stand',
    config = {
        evolved = true,
        stand_mask = true,
        aura_colors = { 'f9ec4bDC', '6edb75DC' },
        extra = {
            enhancement = 'm_stone',
            mult = 5,
        }
    },
    cost = 10,
    rarity = 'csau_EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'diamond',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.chvsau } }
    return {vars = {G.P_CENTERS[card.ability.extra.enhancement].name, card.ability.extra.mult}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_diamond_echoes_1']
    or G.GAME.used_jokers['c_csau_diamond_echoes_2'] then
        return false
    end
    
    return true
end

function consumInfo.calculate(self, card, context)
    if context.individual and context.cardarea == G.play and not card.debuff then
        if context.other_card.ability.effect == 'Stone Card' then
            return {
                func = function()
                    G.FUNCS.csau_flare_stand_aura(card, 0.38)
                end,
                mult = card.ability.extra.mult
            }
        end
    end
end

local ref_is = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if next(SMODS.find_card("c_csau_diamond_echoes_3")) and self.ability.effect == 'Stone Card' then return true end
    return ref_is(self, suit, bypass_debuff, flush_calc)
end


return consumInfo