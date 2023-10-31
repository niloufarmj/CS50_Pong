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
    END = 3
}

winningPlayer = ''
winningScore = 3


function initValues() 
    player1 = Player:new(15, 79)
    player2 = Player:new(WINDOW.VirtualWidth - 20, WINDOW.VirtualHeight - 50)
    ball = Ball:new(WINDOW.VirtualWidth / 2 - 2.5, WINDOW.VirtualHeight / 2 + 27.5, 5)

    currentState = GameState.START 
end

function reset() 
    player1.x = 15
    player1.y = 79
    player2.x = WINDOW.VirtualWidth - 20
    player2.y = WINDOW.VirtualHeight - 50
    ball:reset()
    currentState = GameState.START 
end


function love.load()
    -- love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Pong')

    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 10)
    largeFont = love.graphics.newFont('font.ttf', 25)

    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }
    
    push:setupScreen(WINDOW.VirtualWidth, WINDOW.VirtualHeight, WINDOW.Width, WINDOW.Height, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    initValues()
end

function love.resize(w, h)
    push:resize(w, h)
end


function love.update(dt) 
    
    if currentState == GameState.PLAY then
        -- player 1 movement
        if (love.keyboard.isDown('up') or love.keyboard.isDown('w')) and player1.y > 60 then
            player1.dy = -1
        elseif (love.keyboard.isDown('down') or love.keyboard.isDown('s')) and player1.y < WINDOW.VirtualHeight - 30 then
            player1.dy = 1
        else
            player1.dy = 0
        end
        player1:update(dt)

        -- player 2 movement (AI)
        if ball.dx > 0 and ball.x > WINDOW.VirtualWidth / 2 then
            local targetY = ball.y - PADDLE.Height / 2

            if targetY < player2.y then
                player2.dy = -1
            elseif targetY > player2.y then
                player2.dy = 1
            else
                player2.dy = 0
            end
        else
            player2.dy = 0
        end
        player2:update(dt)

        -- ball movement
        if ball:collides(player1) then
            ball.dx = math.abs(ball.dx) -- Invert the horizontal velocity
            ball.x = player1.x + PADDLE.Width + ball.radius -- Move the ball outside the paddle
            sounds['paddle_hit']:play()
        
            -- Randomize the vertical velocity
            if ball.dy < 0 then
                ball.dy = -math.random(50, 130)
            else
                ball.dy = math.random(50, 130)
            end
        end

        if ball:collides(player2) then
            ball.dx = -math.abs(ball.dx) -- Invert the horizontal velocity
            ball.x = player2.x - ball.radius -- Move the ball outside the paddle
            sounds['paddle_hit']:play()
        
            -- Randomize the vertical velocity
            if ball.dy < 0 then
                ball.dy = -math.random(50, 130)
            else
                ball.dy = math.random(50, 130)
            end
        end

        if ball.y - ball.radius <= 57 then
            ball.dy = math.abs(ball.dy) -- Invert the vertical velocity
            sounds['wall_hit']:play()
        end
        if ball.y + ball.radius > WINDOW.VirtualHeight - 5 then
            ball.dy = -math.abs(ball.dy) -- Invert the vertical velocity
            sounds['wall_hit']:play()
        end

        if ball.x > WINDOW.VirtualWidth then
            player1.score = player1.score + 1
            sounds['score']:play()

            if player1.score == winningScore then
                winningPlayer = 'player1'
                currentState = GameState.END
            else
                currentState = GameState.START
                reset()
            end
        end
        if ball.x < 0 then
            player2.score = player2.score + 1
            sounds['score']:play()

            if player2.score == winningScore then
                winningPlayer = 'player2'
                currentState = GameState.END
            else
                currentState = GameState.START
                reset()
            end
        end

        
        ball:update(dt)
    end
end



function drawUI()
    love.graphics.setFont(smallFont)
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
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

function drawResult()
    love.graphics.setColor(255/255, 76/255, 132/255, 0.8)
    love.graphics.setFont(largeFont)
    love.graphics.printf(
        tostring(winningPlayer) .. ' WINS!',    
        0,                     
        70,  
        WINDOW.VirtualWidth,       
        'center') 
    love.graphics.printf(
        ' Press Enter to Restart',    
        0,                     
        120,  
        WINDOW.VirtualWidth,       
        'center') 
end

function love.draw()
    push:apply('start')

    drawUI()

    if currentState == GameState.END then
        drawResult()
    else 
        player1:draw() -- left paddle
        player2:draw() -- right paddle
        ball:draw() -- ball
    end

    drawFPS()

    push:apply('end')
end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'return' then
        if currentState == GameState.START then
            currentState = GameState.PLAY
        elseif currentState == GameState.END then
            initValues()
        else
            reset()
        end
    end
end