notbalatro = true

require("src.misc_functions")
local game = require("src.game")

game.canvasWidth = 59
game.canvasHeight = 63
game.scale = 10
game.blockSize = math.floor(math.min(game.canvasWidth / 10, game.canvasHeight / 20))
game.gridOffsetX = 15
game.gridOffsetY = 1
tetrisSeed = tetrisSeed or love.math.random(1, 10000)
love.math.setRandomSeed(tetrisSeed)

function love.load()
    love.graphics.setBackgroundColor(game.colors.background)
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setMode(canvasWidth * ygtt.scale, canvasHeight * ygtt.scale, {resizable = false, vsync = true})
    game.canvas = love.graphics.newCanvas(canvasWidth, canvasHeight)
    game.load()
end

game.targetFrameTime = 1 / 60

function love.update(dt)
    local startTime = love.timer.getTime()

    game.update(dt)

    local frameTime = love.timer.getTime() - startTime
    
    if frameTime < game.targetFrameTime then
        love.timer.sleep(game.targetFrameTime - frameTime)
    end
end

function love.draw()
    love.graphics.setCanvas(game.canvas)
    love.graphics.clear()
    game.draw()
    love.graphics.setCanvas()

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(game.canvas, 0, 0, 0, ygtt.scale, ygtt.scale)
end

function love.keypressed(key)
    game.keypressed(key)
end

function love.keyreleased(key)
    game.keyreleased(key)
end

function love.conf(t)
    t.window.width = canvasWidth * ygtt.scale
    t.window.height = canvasHeight * ygtt.scale
    t.console = true
end