Car = Class{}

local carSpritePath = "assets/sprites/car.png"

function Car:init(params)
    self.image = love.graphics.newImage(carSpritePath)
    self.x = params.x
    self.y = params.y
    self.rot = params.rot or 0
    self.acc = 450
    self.dec = 700
    self.speed = 0
    self.rotSpeed = 0.05
end

function Car:update(dt)
    local dx, dy, dRot = 0, 0, 0
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        self.speed = self.speed + self.acc * dt
    elseif love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        if self.speed > 0 then
            self.speed = self.speed - self.dec * dt
        else
            self.speed = self.speed - self.acc * dt
        end
    else
        self.speed = self.speed * 0.95
    end

    dx, dy = Vector2.pointFromRotDist(math.deg(self.rot), self.speed * dt)
    dRot = (self.rotSpeed / (Vector2.magnitude(dx, dy) / self.speed))
    self.x = self.x + dx
    self.y = self.y + dy

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        self.rot = self.rot + dRot * dt
    end

    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        self.rot = self.rot - dRot * dt
    end
end

function Car:draw()
    love.graphics.draw(self.image, self.x, self.y, -self.rot, 0.25 * SCALE_FACTOR, 0.25 * SCALE_FACTOR, self.image:getWidth() / 2, self.image:getHeight() / 2)
end