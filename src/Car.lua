local Vector2 = require("src.utils.Vector2")

local car = {}

local update = function(self, dt)
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        local dx, dy = Vector2.pointFromRotDist(math.deg(self.rot), self.moveSpeed * dt)
        self.x = self.x + dx
        self.y = self.y + dy
    end

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        local dRot = self.rotSpeed * dt
        self.rot = self.rot + dRot
    end

    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        local dRot = self.rotSpeed * dt
        self.rot = self.rot - dRot
    end
end

local draw = function(self)
    love.graphics.draw(self.image, self.x, self.y, -self.rot, 1, 1, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

car.create = function(spritePath, x, y, rot)
    local inst = {}

    inst.image = love.graphics.newImage(spritePath)
    inst.x = x
    inst.y = y
    inst.rot = rot or 0
    inst.moveSpeed = 150
    inst.rotSpeed = 1.5

    inst.update = update
    inst.draw = draw

    return inst
end

return car
