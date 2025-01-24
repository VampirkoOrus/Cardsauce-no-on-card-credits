local mod = SMODS.current_mod
local mod_path = SMODS.current_mod.path:match("Mods/[^/]+")..'/'

function table.clear(t)
    for k in pairs(t) do
        t[k] = nil
    end
end
------------------------------Set up emulator
local oldRequire = require
require = function(path)
    if path == 'table.clear' then return end
    return assert(SMODS.load_file('jokers/Tetris/src/'..path..'.lua'))()
end

mod.tetris = require('game')
mod.tetris.canvasWidth = 59
mod.tetris.canvasHeight = 63
mod.tetris.scale = 1
mod.tetris.gridOffsetX = 15
mod.tetris.gridOffsetY = 1
mod.tetris.blockSize = math.floor(math.min(mod.tetris.canvasWidth / 10, mod.tetris.canvasHeight / 20))
mod.tetris.targetFrameTime = 1 / 60

mod.tetris.isActive = false
mod.tetris.showFullView = false

mod.tetris.linesCleared = 0

local loveKeyPressedRef = love.keypressed
local loveKeyReleasedRef = love.keyreleased
local loveUpdateRef = love.update
local loveDrawRef = love.draw

function love.keypressed(key)
    mod.tetris.keypressed(key)
    loveKeyPressedRef(key)
end

function love.keyreleased(key)
    mod.tetris.keyreleased(key)
    loveKeyReleasedRef(key)
end

function love.update(dt)
    loveUpdateRef(dt)

    if mod.tetris.isActive then
        mod.tetris.update(dt)
    end
end

local jokerInfo = {
    name = "YOU GOT THE TETRIS",
    config = {
        extra = {
            mult = 0
        }
    },
    rarity = 3,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    streamer = "joel",
}

mod.tetrisCardBase = love.graphics.newImage(mod_path..'assets/1x/jokers/tetris.png')
mod.tetrisCardOverlay = love.graphics.newImage(mod_path..'assets/1x/jokers/tetrisoverlay.png')

local setupCanvas = function(self)
    self.children.center.video = love.graphics.newCanvas(71,95) --why does this work lmaooooooo
    self.children.center.video:renderTo(function()
        love.graphics.clear(1,1,1,0)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(mod.tetrisCardBase)
    end)
end

jokerInfo.loc_vars = function (self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
end

jokerInfo.calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main then
        if to_big(card.ability.extra.mult) > to_big(0) then
            return {
                message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult,
            }
        end
    end
end

jokerInfo.add_to_deck = function(self, card)
    mod.tetris.load()
    mod.tetris.isActive = true
end

jokerInfo.remove_from_deck = function(self, card)
    mod.tetris.isActive = false
end

function jokerInfo.update(self, card, dt)
    if G.STAGE == G.STAGES.RUN then
        --do the Mario
        --swing your arms from side to side
        if mod.tetris.isActive then
            card.ability.extra.mult = mod.tetris.linesCleared
        else
            card.ability.extra.mult = 0
        end
    end
end

function jokerInfo.draw(self,card,layer)
    --Withouth love.graphics.push, .pop, and .reset, it will attempt to use values from the rest of
    --the rendering code. We need a clean slate for rendering to canvases.
    if card.area ~= G.jokers then
        return
    end

    love.graphics.push('all')
    love.graphics.reset()
    if not card.children.center.video then
        setupCanvas(card)
    end
    card.children.center.video:renderTo(function()
        if mod.tetris.isActive then
            mod.tetris.draw(6, 6)
        end
        love.graphics.draw(mod.tetrisCardOverlay)
    end)
    love.graphics.pop()
end

require = oldRequire

return jokerInfo