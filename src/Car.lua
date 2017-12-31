local car = {}

local update = function(self, dt)
    
end

local draw = function(self)
    love.graphics.draw(self.image, self.x, self.y, self.rot)
end

car.create = function(spritePath, x, y, rot)
    local inst = {}

    inst.image = love.graphics.newImage(spritePath)
    inst.x = x
    inst.y = y
    inst.rot = rot or 0

    inst.update = update
    inst.draw = draw

    return inst
end

return car
