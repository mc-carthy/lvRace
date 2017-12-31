local Vector2 = require("src.utils.Vector2")

local car = {}

local update = function(self, dt)
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        local dx, dy = Vector2.pointFromRotDist(self.rot, self.moveSpeed * dt)
        self.x = self.x + dx
        self.y = self.y + dy
    end

end

local draw = function(self)
    love.graphics.draw(self.image, self.x, self.y, self.rot, 1, 1, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

car.create = function(spritePath, x, y, rot)
    local inst = {}

    inst.image = love.graphics.newImage(spritePath)
    inst.x = x
    inst.y = y
    inst.rot = rot or 0
    inst.moveSpeed = 50
    inst.rotSpeed = 5

    inst.update = update
    inst.draw = draw

    return inst
end

return car
