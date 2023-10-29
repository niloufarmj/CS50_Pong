Ball = {}

function Ball:new(x, y, diameter)
    local obj = {
        x = x,
        y = y,
        diameter = diameter,
        dy = math.random(2) == 1 and -100 or 100,
        dx = math.random(-50, 50),
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Ball:reset()
    self.x = WINDOW.VirtualWidth / 2 - 2.5
    self.y = WINDOW.VirtualHeight / 2 + 27.5
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, self.diameter)
end
