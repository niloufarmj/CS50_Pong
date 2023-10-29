push = require 'push'


-- window section

WINDOW = {
    Width = 1000,
    Height = 600,
    VirtualWidth = 350,
    VirtualHeight = 200
}

-- paddle section

PADDLE = {
    Width = 6,
    Height = 25, 
    Speed = 150,
}

-- player section

Player = {}

function Player:new(x, y)
    local obj = {
        x = x,
        y = y,
        score = 0,
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Player:update(dt)
    -- Your update code here
end

function Player:draw()
    -- Your drawing code here
end

player1 = Player:new(15, 79)
player2 = Player:new(WINDOW.VirtualWidth - 20, WINDOW.VirtualHeight - 50)


-- init screen

function love.load()
    -- love.graphics.setDefaultFilter('nearest', 'nearest')

    smallFont = love.graphics.newFont('ModernWarfare-OV7KP.ttf', 10)
    love.graphics.setFont(smallFont)

    push:setupScreen(WINDOW.VirtualWidth, WINDOW.VirtualHeight, WINDOW.Width, WINDOW.Height, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

end


-- update

function love.update(dt) 
    -- player 1 movement
    if love.keyboard.isDown('w') then
        player1.y = player1.y + -PADDLE.Speed * dt
    elseif love.keyboard.isDown('s') then
        player1.y = player1.y + PADDLE.Speed * dt
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        player2.y = player2.y + -PADDLE.Speed * dt
    elseif love.keyboard.isDown('down') then
        player2.y = player2.y + PADDLE.Speed * dt
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

    love.graphics.rectangle('fill', player1.x, player1.y, PADDLE.Width, PADDLE.Height) -- left paddle
    love.graphics.rectangle('fill', player2.x, player2.y, PADDLE.Width, PADDLE.Height) -- right paddle
    love.graphics.circle("fill", WINDOW.VirtualWidth / 2 - 2.5, WINDOW.VirtualHeight / 2 + 27.5, 5) -- ball
    push:apply('end')
end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end