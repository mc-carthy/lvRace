local Vector2 = require("src.utils.Vector2")

local car = {}

local update = function(self, dt)
    local dRot = 0
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        dx, dy = Vector2.pointFromRotDist(math.deg(self.rot), self.moveSpeed * dt)
        dRot = (self.rotSpeed / (Vector2.magnitude(dx, dy) / self.moveSpeed))
        self.x = self.x + dx
        self.y = self.y + dy
    end

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        self.rot = self.rot + dRot * dt
    end

    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        self.rot = self.rot - dRot * dt
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
    inst.moveSpeed = 450
    inst.rotSpeed = 0.05

    inst.update = update
    inst.draw = draw

    return inst
end

return car
