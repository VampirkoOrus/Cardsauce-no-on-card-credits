local consumInfo = {
    name = 'Top Slots - Spotting The Best',
    key = 'topslots',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        extra = {
            winnings = nil,

            conv_money = 1,
            conv_score = 5,
            prob_double = 6,
            double = 2,
            prob_triple = 8,
            triple = 3,

            runtime = 2,
            uses = 0,
        },
        activated = false,
        slide_move = 0,
        slide_out_delay = 0,
        destroy = false,
    },
    origin = 'rlm'
}

local slide_out = 8.25
local slide_mod = 0.25
local slide_out_delay = 1

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}
    return { vars = { card.ability.extra.conv_money, card.ability.extra.conv_score, G.GAME.probabilities.normal, card.ability.extra.prob_double, card.ability.extra.prob_triple, card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.set_ability(self, card, initial, delay_sprites)
    if next(SMODS.find_card("c_csau_moodyblues")) then
        card.ability.extra.runtime = card.ability.extra.runtime*2
    end
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.individual or context.blueprint
    if card.ability.activated and context.end_of_round and not card.debuff and not bad_context then
        if G.GAME.chips > G.GAME.blind.chips then
            local percent = ((G.GAME.chips - G.GAME.blind.chips) / G.GAME.blind.chips) * 100
            local money = math.floor(percent / card.ability.extra.conv_score) + card.ability.extra.conv_money
            local doubled, tripled = false, false
            if pseudorandom('READYOURMACHINES') < G.GAME.probabilities.normal / card.ability.extra.prob_double then
                money = money * card.ability.extra.double
                doubled = true
            end
            if pseudorandom('NOCONTROLOVERTHAT') < G.GAME.probabilities.normal / card.ability.extra.prob_triple then
                money = money * card.ability.extra.triple
                tripled = true
            end
            card.ability.extra.winnings = money
            card.ability.extra.uses = card.ability.extra.uses + 1
            if doubled or tripled then
                return {
                    message = localize((doubled and tripled and 'k_ts_wild') or (doubled and not tripled and 'k_ts_doubled') or (tripled and not doubled and 'k_ts_tripled')),
                    card = card
                }
            end
        end
    end
    if context.starting_shop and not context.blueprint then
        if card.ability.extra.uses >= card.ability.extra.runtime then
            G.FUNCS.destroy_tape(card)
            card.ability.destroyed = true
        end
    end
end

function consumInfo.calc_dollar_bonus(self, card)
    if card.ability.extra.winnings then
        return card.ability.extra.winnings
    end
end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

local mod = SMODS.current_mod
local mod_path = SMODS.current_mod.path:match("Mods/[^/]+")..'/'

mod['c_csau_'..consumInfo.key..'_tape'] = love.graphics.newImage(mod_path..'assets/1x/vhs/'..(consumInfo.tapeKey or 'blackspine')..'.png')
mod['c_csau_'..consumInfo.key..'_sleeve'] = love.graphics.newImage(mod_path..'assets/1x/vhs/'..consumInfo.key..'.png')

local setupTapeCanvas = function(self, card, tape, sleeve)
    card.children.center.video = love.graphics.newCanvas(self.width or 71, self.height or 95)
    card.children.center.video:renderTo(function()
        love.graphics.clear(1,1,1,0)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(mod[card.config.center.key..'_tape'], ((self.width or 71)/2)+card.ability.slide_move, (self.height or 95)/2,0,1,1,71/2,95/2)
        love.graphics.draw(mod[card.config.center.key..'_sleeve'],((self.width or 71)/2)-card.ability.slide_move,(self.height or 95)/2,0,1,1,71/2,95/2)
    end)
end

function consumInfo.draw(self,card,layer)
    if card.area and card.area.config.collection and not self.discovered then
        return
    end

    love.graphics.push('all')
    love.graphics.reset()
    if not card.children.center.video then
        setupTapeCanvas(self, card, mod[card.config.center.key..'_tape'], mod[card.config.center.key..'_sleeve'])
    end

    if card.ability.activated and card.ability.slide_move < slide_out then
        if card.ability.slide_out_delay < slide_out_delay then
            card.ability.slide_out_delay = card.ability.slide_out_delay + slide_mod
        else
            card.ability.slide_move = card.ability.slide_move + slide_mod
        end
    elseif not card.ability.activated and card.ability.slide_move > 0 then
        card.ability.slide_out_delay = 0
        card.ability.slide_move = card.ability.slide_move - slide_mod
    end

    card.children.center.video:renderTo(function()
        love.graphics.clear(1,1,1,0)
        love.graphics.draw(mod[card.config.center.key..'_tape'], ((self.width or 71)/2)+card.ability.slide_move, (self.height or 95)/2,0,1,1,71/2,95/2)
        love.graphics.draw(mod[card.config.center.key..'_sleeve'],((self.width or 71)/2)-card.ability.slide_move,(self.height or 95)/2,0,1,1,71/2,95/2)
    end)
    love.graphics.pop()
end

return consumInfo