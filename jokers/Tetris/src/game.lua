local Tetromino = require(notbalatro and "src.tetromino" or "tetromino")
local Board = require(notbalatro and "src.board" or "board")

Tetris = {}

Tetris.colors = {
    background = HEX('2d433c'),
    mult = HEX('FE5F55'),
    dark_mult = HEX('cc4846'),
    speedlevels = {
        [1] = HEX('ebf6f8'),
        [2] = HEX('c7d6d9'),
        [3] = HEX('FE5F55'),
        [4] = HEX('cc4846'),
        [5] = HEX('55a383'),
        [6] = HEX('4d8276'),
        [7] = HEX('4f6367'),
        [8] = HEX('445457'),
        [9] = HEX('009cfd'),
        [10] = HEX('1685cb'),
        [11] = HEX('8a71e1'),
        [12] = HEX('6059a0'),
        [13] = HEX('e47c4c'),
        [14] = HEX('a66040'),
        [15] = HEX('ffe4a6'),
        [16] = HEX('f2c255'),
        [17] = HEX('c09533')
    }
}

Tetris.speeds = {
    [1] = 1.0,
    [2] = 0.9385416667,
    [3] = 0.8770833333,
    [4] = 0.815625,
    [5] = 0.7541666667,
    [6] = 0.6927083333,
    [7] = 0.63125,
    [8] = 0.5697916667,
    [9] = 0.5083333333,
    [10] = 0.446875,
    [11] = 0.3854166667,
    [12] = 0.3239583333,
    [13] = 0.2625,
    [14] = 0.2010416667,
    [15] = 0.1395833333,
    [16] = 0.078125,
    [17] = 0.0166666667,
}

Tetris.keysPressed = {}
Tetris.keyDelayTimers = {}
Tetris.keyDelayThreshold = 0.04

function Tetris:getRandomTetrominoShape()
    local tetrominoShapes = {"I", "O", "T", "J", "L", "S", "Z"}
    local randomIndex = math.random(1, #tetrominoShapes)
    local shape = tetrominoShapes[randomIndex]
    return shape
end

function Tetris.load()
    Tetris.board = Board:new('main', 10, 20)
    Tetris.mult = Board:new('mult', 3, 25, 4, 10, 2)
    Tetris.speed = Board:new('speed', 1, 17, 51, 9, 3)

    local nextShape = Tetris:getRandomTetrominoShape()

    Tetris.currentTetromino = Tetromino:new(nextShape, 5, 1)
    Tetris.currentTetromino.board = Tetris.board

    Tetris.ghostTetromino = nil
    Tetris.linesCleared = 0
    Tetris.lockDelay = 0
    Tetris.gameOver = false
    Tetris.dropTimer = 0
    Tetris.actionTimer = 0
    Tetris.speedLevel = 1

    Tetris.keyDelayTimers = {left = 0, right = 0}
end

function Tetris.update(dt)
    if Tetris.gameOver then
        Tetris.load()
        return
    end

    Tetris.dropTimer = (Tetris.dropTimer or 0) + dt

    if (Tetris.linesCleared >= (Tetris.speedLevel * 5 + 5)) and not (Tetris.speedLevel >= 17) then
        Tetris.speedLevel = Tetris.speedLevel + 1
    end

    if Tetris.dropTimer >= Tetris.speeds[Tetris.speedLevel] then
        if not Tetris.moveTetromino(0, 1) then
            Tetris:hardDrop()
            Tetris.dropTimer = 0
        else
            Tetris.lockDelay = 0
        end

        Tetris.dropTimer = 0
    end

    local actionSpeed = 0.05
    Tetris.actionTimer = (Tetris.actionTimer or 0) + dt

    if Tetris.actionTimer >= actionSpeed then
        for key, _ in pairs(Tetris.keysPressed) do
            if Tetris.keyDelayTimers[key] then
                Tetris.keyDelayTimers[key] = Tetris.keyDelayTimers[key] + dt
            end
        end

        if Tetris.keysPressed["left"] and Tetris.keyDelayTimers["left"] >= Tetris.keyDelayThreshold then
            Tetris.moveTetromino(-1, 0)
        end
        if Tetris.keysPressed["right"] and Tetris.keyDelayTimers["right"] >= Tetris.keyDelayThreshold then
            Tetris.moveTetromino(1, 0)
        end
        if Tetris.keysPressed["down"] then
            Tetris.moveTetromino(0, 1)
        end

        Tetris.actionTimer = 0
    end

    Tetris:updateGhostTetromino()
end

function Tetris:updateGhostTetromino()
    local ghost = Tetromino:new(Tetris.currentTetromino.type, Tetris.currentTetromino.x, Tetris.currentTetromino.y)
    ghost.rotation = Tetris.currentTetromino.rotation
    ghost.shape = Tetromino.shapes[ghost.type][ghost.rotation + 1]

    while not Tetris.board:checkCollision(ghost) do
        ghost.y = ghost.y + 1
    end

    ghost.y = ghost.y - 1

    Tetris.ghostTetromino = ghost
end

function Tetris.moveTetromino(dx, dy)
    local ret = true
    Tetris.currentTetromino.x = Tetris.currentTetromino.x + dx
    Tetris.currentTetromino.y = Tetris.currentTetromino.y + dy
    if Tetris.board:checkCollision(Tetris.currentTetromino) then
        ret = false
        Tetris.currentTetromino.x = Tetris.currentTetromino.x - dx
        Tetris.currentTetromino.y = Tetris.currentTetromino.y - dy
    end
    return ret
end

function Tetris:hardDrop()
    if Tetris.gameOver then
        return
    end
    Tetris.currentTetromino.y = Tetris.ghostTetromino.y

    Tetris.board:lockTetromino(Tetris.currentTetromino)

    local rowsCleared = Tetris.board:clearRows()
    Tetris.linesCleared = Tetris.linesCleared + rowsCleared

    local newShape = Tetris:getRandomTetrominoShape()

    Tetris.currentTetromino = Tetromino:new(newShape, 5, 1)
    Tetris.currentTetromino.board = Tetris.board

    Tetris:updateGhostTetromino()

    if Tetris.board:checkCollision(Tetris.currentTetromino) then
        Tetris.gameOver = true
    end
end

function Tetris.draw(x_offset, y_offset)
    x_offset = x_offset or 0
    y_offset = y_offset or 0
    Tetris.board:draw(x_offset, y_offset)
    Tetris.mult:draw(x_offset, y_offset)
    Tetris.speed:draw(x_offset, y_offset)

    if Tetris.ghostTetromino then
        local ghostColor = Tetromino.colors[Tetris.ghostTetromino.type]
        love.graphics.setColor(ghostColor[1], ghostColor[2], ghostColor[3], 0.3)
        Tetris.ghostTetromino:draw(x_offset, y_offset)
    end

    local currentColor = Tetromino.colors[Tetris.currentTetromino.type]
    love.graphics.setColor(currentColor[1], currentColor[2], currentColor[3])
    Tetris.currentTetromino:draw(x_offset, y_offset)

    local multSquares = math.min(Tetris.linesCleared, Tetris.mult.height * Tetris.mult.width)

    local otherRed = false
    for i = 0, multSquares - 1 do
        local row = Tetris.mult.height - math.floor(i / Tetris.mult.width)
        local col = (i % Tetris.mult.width) + 1

        local screenX = (col - 1) * Tetris.mult.scale + Tetris.mult.x + x_offset
        local screenY = (row - 1) * Tetris.mult.scale + Tetris.mult.y + y_offset
        local filledColor
        if otherRed then filledColor = Tetris.colors.dark_mult else filledColor = Tetris.colors.mult end
        otherRed = not otherRed
        love.graphics.setColor(filledColor)
        love.graphics.rectangle("fill", screenX, screenY, Tetris.mult.scale, Tetris.mult.scale)
    end

    local speedSquares = Tetris.speedLevel
    local color = 1
    for i = 0, speedSquares - 1 do
        local col = (1 % Tetris.speed.width) + 1
        local row = Tetris.speed.height - math.floor(i / Tetris.speed.width)
        local screenX = (col - 1) * Tetris.speed.scale + Tetris.speed.x + x_offset
        local screenY = (row - 1) * Tetris.speed.scale + Tetris.speed.y + y_offset
        local filledColor
        filledColor = Tetris.colors.speedlevels[color]
        color = color + 1
        otherRed = not otherRed
        love.graphics.setColor(filledColor)
        love.graphics.rectangle("fill", screenX, screenY, Tetris.speed.scale, Tetris.speed.scale)
    end

    love.graphics.setColor(1, 1, 1)
end

function Tetris.keypressed(key)
    if Tetris.gameOver then
        if key == "space" then
            Tetris.load()
        end
        return
    end

    Tetris.keysPressed[key] = true
    Tetris.keyDelayTimers[key] = 0

    Tetris.keysPressed[key] = true
    if key == "left" then
        Tetris.moveTetromino(-1, 0)
    end
    if key == "right" then
        Tetris.moveTetromino(1, 0)
    end
    if key == "down" then
        Tetris.moveTetromino(0, 1)
    end
    if key == "up" then
        Tetris:hardDrop()
    end
    if key == "z" then
        Tetris.currentTetromino:rotate(false)
    end
    if key == "x" then
        Tetris.currentTetromino:rotate(true)
    end

end

function Tetris.keyreleased(key)
    Tetris.keysPressed[key] = false
    Tetris.keyDelayTimers[key] = 0
end

return Tetris