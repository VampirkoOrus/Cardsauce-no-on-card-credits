local jokerInfo = {
    name = "Bonzi Buddy",
    config = {
        extra = {
            mult = 0,
            mult_mod = 5,
            dollars = 5,
        },
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    display_size = { w = 71*1.47887323944, h = 95 },
    width = 105,
    sticker_offset = {
        x = 0,
    },
    streamer = "joel",
}

local function invertNum(n)
    return -n
end

local function getSignum(num)
    if num >= 0 then return "+" else return "" end
end


function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "artistcredit", set = "Other", vars = { csau_team.crispy } }
    return { vars = {card.ability.extra.mult_mod, card.ability.extra.dollars, getSignum(card.ability.extra.mult)..card.ability.extra.mult} }
end

function jokerInfo.calculate(self, card, context)
    if context.setting_blind and not card.getting_sliced and not card.debuff and not context.blueprint then
        if (G.GAME.dollars - card.ability.extra.dollars) > (0 or next(SMODS.find_card('j_credit_card')) and -20) then
            if card.ability.extra.mult < 0 then
                card.ability.extra.mult = invertNum(card.ability.extra.mult)
            end
            ease_dollars(-card.ability.extra.dollars)
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.MULT})
        else
            if card.ability.extra.mult > 0 then
                card.ability.extra.mult = invertNum(card.ability.extra.mult)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_negative_mult'), colour = G.C.DARK_EDITION})
            end
        end
    end
    if card.ability.extra.mult ~= 0 and context.joker_main and context.cardarea == G.jokers then
        return {
            mult = card.ability.extra.mult,
        }
    end
end

local upd = Game.update
csau_bonzi_dt = 0
function Game:update(dt)
    upd(self,dt)
    csau_bonzi_dt = csau_bonzi_dt + dt
    if G.P_CENTERS and G.P_CENTERS.j_csau_bonzi and csau_bonzi_dt > 0.1 then
        csau_bonzi_dt = 0
        local obj = G.P_CENTERS.j_csau_bonzi
        if (obj.pos.x == 5 and obj.pos.y == 1) then
            obj.pos.x = 0
            obj.pos.y = 0
        elseif (obj.pos.x < 5) then obj.pos.x = obj.pos.x + 1
        elseif (obj.pos.y < 1) then
            obj.pos.x = 0
            obj.pos.y = obj.pos.y + 1
        end
    end
end

return jokerInfo