local consumInfo = {
    name = 'Double Down',
    set = "VHS",
    cost = 4,
    alerted = true,
    activation = true,
    config = {
        extra = {
            x_mult = 2
        },
        activated = false,
        slide_move = 0,
        destroy = false,
    },
}

local slide_out = 8.25
local slide_mod = 0.25

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}
    return { vars = { card.ability.extra.x_mult } }
end

function consumInfo.calculate(self, card, context)
    if card.ability.activated and context.final_scoring_step then
        card.ability.destroy = true
        return {
            x_mult = card.ability.extra.x_mult,
            card = card
        }
    end
    if context.remove_playing_cards and card.ability.destroy then
        G.FUNCS.destroy_tape(card)
    end
end

function consumInfo.can_use(self, card)
    return true
end

local mod = SMODS.current_mod
local mod_path = SMODS.current_mod.path:match("Mods/[^/]+")..'/'

mod.doubledown_tape = love.graphics.newImage(mod_path..'assets/1x/consumables/blackspine.png')
mod.doubledown_sleeve = love.graphics.newImage(mod_path..'assets/1x/consumables/doubledown.png')

local setupTapeCanvas = function(self, card, tape, sleeve)
    card.children.center.video = love.graphics.newCanvas(self.width or 71, self.height or 95)
    card.children.center.video:renderTo(function()
        love.graphics.clear(1,1,1,0)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(mod.doubledown_tape, ((self.width or 71)/2)+card.ability.slide_move, (self.height or 95)/2,0,1,1,71/2,95/2)
        love.graphics.draw(mod.doubledown_sleeve,((self.width or 71)/2)-card.ability.slide_move,(self.height or 95)/2,0,1,1,71/2,95/2)
    end)
end

function consumInfo.draw(self,card,layer)
    if card.area and card.area.config.collection and not self.discovered then
        return
    end

    love.graphics.push('all')
    love.graphics.reset()
    if not card.children.center.video then
        setupTapeCanvas(self, card, mod.doubledown_tape, mod.doubledown_sleeve)
    end

    if card.ability.activated and card.ability.slide_move < slide_out then
        card.ability.slide_move = card.ability.slide_move + slide_mod
    elseif not card.ability.activated and card.ability.slide_move > 0 then
        card.ability.slide_move = card.ability.slide_move - slide_mod
    end

    card.children.center.video:renderTo(function()
        love.graphics.clear(1,1,1,0)
        love.graphics.draw(mod.doubledown_tape, ((self.width or 71)/2)+card.ability.slide_move, (self.height or 95)/2,0,1,1,71/2,95/2)
        love.graphics.draw(mod.doubledown_sleeve,((self.width or 71)/2)-card.ability.slide_move,(self.height or 95)/2,0,1,1,71/2,95/2)
    end)
    love.graphics.pop()
end

return consumInfo