push = require 'push'

WINDOW = {
    Width = 1000,
    Height = 600,
    VirtualWidth = 350,
    VirtualHeight = 200
}

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

function love.draw()
    push:apply('start')

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
        'Player 1 : 0',    
        -90,                     
        37.5,  
        WINDOW.VirtualWidth,       
        'center') 
    love.graphics.printf(
        'Player 2 : 0',    
        90,                     
        37.5,  
        WINDOW.VirtualWidth,       
        'center') 

    love.graphics.rectangle('fill', 15, 70, 6, 25) -- left paddle
    love.graphics.rectangle('fill', WINDOW.VirtualWidth - 20, WINDOW.VirtualHeight - 50, 6, 25) -- right paddle
    love.graphics.circle("fill", WINDOW.VirtualWidth / 2 - 2.5, WINDOW.VirtualHeight / 2 + 27.5, 5) -- ball
    push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end