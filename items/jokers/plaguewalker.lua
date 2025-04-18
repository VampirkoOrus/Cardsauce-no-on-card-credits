local jokerInfo = {
    name = 'Plaguewalker',
    config = {
        debuff = false,
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "joel",
    origin = 'monkeywrench'
}

G.FUNCS.plaguewalker_active = function(card)
    card = card or nil
    local plaguewalkers = SMODS.find_card("j_csau_plaguewalker")
    for i, v in ipairs(plaguewalkers) do
        if (card and v ~= card) or not card then
            if not v.debuff then
                return true
            end
        end
    end
    return false
end

local gcxm_ref = Card.get_chip_x_mult
function Card:get_chip_x_mult(context)
    local ref = gcxm_ref(self, context)
    if self.ability.name == "Glass Card" and G.FUNCS.plaguewalker_active() then
        return 3
    else
        return ref
    end
end

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.zeurel } }
    return { vars = { G.GAME.probabilities.normal } }
end

local function activate(bool)
    if bool then
        G.P_CENTERS.m_glass.config.extra = 2
        G.P_CENTERS.m_glass.config.Xmult = 3
        for _, area in ipairs(SMODS.get_card_areas('playing_cards')) do
            for _, _card in ipairs(area.cards) do
                if SMODS.has_enhancement(_card, 'm_glass') then
                    _card.ability.extra = 2
                    _card.ability.Xmult = 3
                end
            end
        end
    else
        G.P_CENTERS.m_glass.config.extra = 4
        G.P_CENTERS.m_glass.config.Xmult = 2
        for _, area in ipairs(SMODS.get_card_areas('playing_cards')) do
            for _, _card in ipairs(area.cards) do
                if SMODS.has_enhancement(_card, 'm_glass') then
                    _card.ability.extra = 4
                    _card.ability.Xmult = 2
                end
            end
        end
    end
end

function jokerInfo.load(self, card)
    activate(true)
end

function jokerInfo.add_to_deck(self, card)
    activate(true)
end

function jokerInfo.remove_from_deck(self, card)
    if not G.FUNCS.plaguewalker_active(card) then
        activate(false)
    end
end

function jokerInfo.update(self, card)
    if card.debuff and not card.ability.debuff then
        card.ability.debuff = true
        if not G.FUNCS.plaguewalker_active(card) then
            activate(false)
        end
    elseif not card.debuff and card.ability.debuff then
        card.ability.debuff = false
        activate(true)
    end
end

return jokerInfo