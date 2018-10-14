Car = Class{}

local carSpritePath = "assets/sprites/car.png"

function Car:init(params)
    self.image = love.graphics.newImage(carSpritePath)
    self.x = params.x
    self.y = params.y
    self.rot = params.rot or 0
    self.moveSpeed = 450
    self.rotSpeed = 0.05
end

function Car:update(dt)
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

function Car:draw()
    love.graphics.draw(self.image, self.x, self.y, -self.rot, 1, 1, self.image:getWidth() / 2, self.image:getHeight() / 2)
end