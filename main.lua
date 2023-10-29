push = require 'push'

require 'Player'
require 'Ball'

-- window section

WINDOW = {
    Width = 1000,
    Height = 600,
    VirtualWidth = 350,
    VirtualHeight = 200
}

-- game state section

GameState = {
    PLAY = 1,
    START = 2,
}


-- init screen

function initValues() 
    player1 = Player:new(15, 79)
    player2 = Player:new(WINDOW.VirtualWidth - 20, WINDOW.VirtualHeight - 50)
    ball = Ball:new(WINDOW.VirtualWidth / 2 - 2.5, WINDOW.VirtualHeight / 2 + 27.5, 5)

    currentState = GameState.START 
end

function love.load()
    -- love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 10)
    love.graphics.setFont(smallFont)

    push:setupScreen(WINDOW.VirtualWidth, WINDOW.VirtualHeight, WINDOW.Width, WINDOW.Height, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    initValues()
end


-- update

function love.update(dt) 
    
    if currentState == GameState.PLAY then
        -- player 1 movement
        if love.keyboard.isDown('w') then
            player1.dy = -1
        elseif love.keyboard.isDown('s') then
            player1.dy = 1
        else
            player1.dy = 0
        end
        player1:update(dt)

        -- player 2 movement
        if love.keyboard.isDown('up') then
            player2.dy = -1
        elseif love.keyboard.isDown('down') then
            player2.dy = 1
        else
            player2.dy = 0
        end
        player2:update(dt)

        -- ball movement
        ball:update(dt)
    end
end

-- draw

function drawUI()
    love.graphics.clear(35/255, 5/255, 65/255, 255/255)

    love.graphics.printf(
        'pong game made by nanami',    
        0,                     
        10,  
        WINDOW.VirtualWidth,       
        'center') 

    love.graphics.rectangle("fill", 5, 30, 340, 2)    
    love.graphics.rectangle("fill", 5, 50, 340, 2)
    love.graphics.rectangle("fill", WINDOW.VirtualWidth / 2 - 1, 30, 2, 20)  
    
    love.graphics.printf(
        'Player 1 : ' .. tostring(player1.score),    
        -90,                     
        37.5,  
        WINDOW.VirtualWidth,       
        'center') 
    love.graphics.printf(
        'Player 2 : ' .. tostring(player2.score),    
        90,                     
        37.5,  
        WINDOW.VirtualWidth,       
        'center') 
end


function love.draw()
    push:apply('start')

    drawUI()

    player1:draw() -- left paddle
    player2:draw() -- right paddle
    ball:draw() -- ball

    push:apply('end')
end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'return' then
        if currentState == GameState.START then
            currentState = GameState.PLAY
        else
            initValues()
        end
    end
end
