Car = Class{}

local carSpritePath = "assets/sprites/car.png"

function Car:init(params)
    self.image = love.graphics.newImage(carSpritePath)
    self.x = params.x
    self.y = params.y
    self.rot = params.rot or 0
    self.acc = 250
    self.dec = 500
    self.speed = 0
    self.maxSpeed = 200
    self.rotSpeed = 5
    self.nextCheckpoint = 1
end

function Car:update(dt)
    self:calculateNextCheckpoint()
    
    local hAxis, vAxis = self:getInput()
    local dx, dy, dRot = 0, 0, 0

    self.rot = self.rot + (hAxis * self.rotSpeed) * dt

    if vAxis > 0 then
        self.speed = self.speed + self.acc * vAxis * dt
    elseif vAxis < 0 then
        if self.speed > 0 then
            self.speed = self.speed - self.dec * dt
        else
            self.speed = self.speed - self.acc * dt
        end
    else
        self.speed = self.speed * 0.95
    end

    if self.speed > self.maxSpeed then
        self.speed = self.maxSpeed
    elseif self.speed < -self.maxSpeed then
        self.speed = -self.maxSpeed
    end

    if math.abs(self.speed) < 0.1 then
        self.speed = 0
    end

    if self.speed ~= 0 then
        dx, dy = Vector2.pointFromRotDist(math.deg(self.rot), self.speed * dt)
        dRot = math.abs(self.speed / 50)
        self.x = self.x + dx
        self.y = self.y + dy
    end
end

function Car:draw()
    love.graphics.setColor(0, 1, 1, 1)
    love.graphics.rectangle('fill', (track.tiles[self.nextCheckpoint].x - 1) * GRID_SIZE, (track.tiles[self.nextCheckpoint].y - 1)  * GRID_SIZE, GRID_SIZE, GRID_SIZE)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('line', (track.tiles[self.nextCheckpoint].x - 1) * GRID_SIZE, (track.tiles[self.nextCheckpoint].y - 1)  * GRID_SIZE, GRID_SIZE, GRID_SIZE)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(string.format("%.2f", self.speed), 10, 10)
    love.graphics.draw(self.image, self.x, self.y, -self.rot, 0.05 * SCALE_FACTOR, 0.05 * SCALE_FACTOR, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

function Car:calculateNextCheckpoint()
    local gridX, gridY = worldToGrid({ x = self.x, y = self.y })
    local nextCheckpointTile = track.tiles[self.nextCheckpoint]
    if nextCheckpointTile.x == gridX and nextCheckpointTile.y == gridY then 
        self.nextCheckpoint = self.nextCheckpoint + 1 
        if self.nextCheckpoint > #track.tiles then
            self.nextCheckpoint = 1
        end
    end
end

function Car:getInput()
    local hAxis, vAxis = 0, 0

    if love.keyboard.isDown('up') then
        vAxis = vAxis + 1
    end
    if love.keyboard.isDown('down') then
        vAxis = vAxis - 1
    end
    if love.keyboard.isDown('left') then
        hAxis = hAxis + 1
    end
    if love.keyboard.isDown('right') then
        hAxis = hAxis - 1
    end

    return hAxis, vAxis
end