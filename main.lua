push = require 'push'

WINDOW = {
    Width = 1000,
    Height = 600,
    VIRTUAL_WIDTH = 350,
    VIRTUAL_HEIGHT = 200
}

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(WINDOW.VIRTUAL_WIDTH, WINDOW.VIRTUAL_HEIGHT, WINDOW.Width, WINDOW.Height, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

end

function love.draw()
    push:apply('start')

    love.graphics.printf(
        'My First Game with LOVE2D:',    
        0,                     
        WINDOW.VIRTUAL_HEIGHT / 2 - 20,  
        WINDOW.VIRTUAL_WIDTH,       
        'center') 
        
    love.graphics.printf(
        'PONG',    
        0,                    
        WINDOW.VIRTUAL_HEIGHT / 2 + 10,  
        WINDOW.VIRTUAL_WIDTH,           
        'center') 

    push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end