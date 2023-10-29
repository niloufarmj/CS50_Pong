PADDLE = {
    Width = 6,
    Height = 25, 
    Speed = 150,
}

Player = {}

function Player:new(x, y)
    local obj = {
        x = x,
        y = y,
        score = 0,
        dy = 0
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Player:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + -PADDLE.Speed * dt)
    elseif self.dy > 0 then
        self.y = math.min(WINDOW.VirtualHeight - PADDLE.Height, self.y + PADDLE.Speed * dt)
    end
end

function Player:draw()
    love.graphics.rectangle('fill', self.x, self.y, PADDLE.Width, PADDLE.Height)
end
