push = require 'push'

require 'Player'
require 'Ball'


WINDOW = {
    Width = 1000,
    Height = 600,
    VirtualWidth = 350,
    VirtualHeight = 210
}

GameState = {
    PLAY = 1,
    START = 2,
}


function initValues() 
    player1 = Player:new(15, 79)
    player2 = Player:new(WINDOW.VirtualWidth - 20, WINDOW.VirtualHeight - 50)
    ball = Ball:new(WINDOW.VirtualWidth / 2 - 2.5, WINDOW.VirtualHeight / 2 + 27.5, 5)

    currentState = GameState.START 
end


function love.load()
    -- love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Pong')

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


function love.update(dt) 
    
    if currentState == GameState.PLAY then
        -- player 1 movement
        if love.keyboard.isDown('w') and player1.y > 60 then
            player1.dy = -1
        elseif love.keyboard.isDown('s') and player1.y < WINDOW.VirtualHeight - 30 then
            player1.dy = 1
        else
            player1.dy = 0
        end
        player1:update(dt)

        -- player 2 movement
        if love.keyboard.isDown('up') and player2.y > 60 then
            player2.dy = -1
        elseif love.keyboard.isDown('down') and player2.y < WINDOW.VirtualHeight - 30 then
            player2.dy = 1
        else
            player2.dy = 0
        end
        player2:update(dt)

        -- ball movement
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + PADDLE.Width + ball.radius

            -- keep velocity going in the same direction, but randomize it
            if ball.dy < 0 then
                ball.dy = -math.random(50, 130)
            else
                ball.dy = math.random(50, 130)
            end
        end

        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - PADDLE.Width

            -- keep velocity going in the same direction, but randomize it
            if ball.dy < 0 then
                ball.dy = -math.random(50, 130)
            else
                ball.dy = math.random(50, 130)
            end
        end

        if ball.y - ball.radius <= 57 then
            ball.dy = math.random(50, 130)
        end
        if ball.y + ball.radius > WINDOW.VirtualHeight - 5 then
            ball.dy = -math.random(50, 130)
        end

        

        ball:update(dt)
    end
end



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

function drawFPS()
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

function love.draw()
    push:apply('start')

    drawUI()

    player1:draw() -- left paddle
    player2:draw() -- right paddle
    ball:draw() -- ball
    drawFPS()

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