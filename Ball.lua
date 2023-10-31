Ball = {}

function Ball:new(x, y, radius)
    local obj = {
        x = x,
        y = y,
        radius = radius,
        dy = math.random(2) == 1 and -100 or 100,
        dx = math.random(2) == 1 and math.random(-80, -130) or math.random(80, 130)
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Ball:reset()
    self.x = WINDOW.VirtualWidth / 2 - 2.5
    self.y = WINDOW.VirtualHeight / 2 + 27.5
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-80, 80)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Ball:collides(player)
    if self.x - self.radius > player.x + PADDLE.Width or player.x > self.x + self.radius then
        return false
    end

    if self.y - self.radius > player.y + PADDLE.Height or player.y > self.y + self.radius then
        return false
    end 

    return true
end
