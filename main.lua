WINDOW = {
    Height = 600,
    Width = 1000
}

function love.load()
    love.window.setMode(WINDOW.Width, WINDOW.Height, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

end

function love.draw()
    love.graphics.printf(
        'My First Game with LOVE2D:',    
        0,                      -- starting X (0 since we're going to center it based on width)
        WINDOW.Height / 2 - 20,  -- starting Y (halfway down the screen)
        WINDOW.Width,           -- number of pixels to center within (the entire screen here)
        'center') 
        
    love.graphics.printf(
        'PONG',    
        0,                      -- starting X (0 since we're going to center it based on width)
        WINDOW.Height / 2 + 10,  -- starting Y (halfway down the screen)
        WINDOW.Width,           -- number of pixels to center within (the entire screen here)
        'center') 
end