Car = Class{}

local carSpritePath = "assets/sprites/car.png"

function Car:init(params)
    self.image = love.graphics.newImage(carSpritePath)
    self.x = params.x
    self.y = params.y
    self.speed = { x = 0, y = 0 }
    self.rot = params.rot or 0
    self.dRot = 0
    self.acc = 2
    self.dec = 500
    self.maxSpeed = 200
    self.rotSpeed = 0.1
    self.rotDamping = 0.01
    self.nextCheckpoint = 1
end

function Car:update(dt)
    self:calculateNextCheckpoint()
    
    local hAxis, vAxis = self:getInput()
    
    local ddRot = hAxis
    self.dRot = self.dRot + ddRot * self.rotSpeed * dt
    self.rot = (self.rot + self.dRot) * (1 - self.rotDamping)

    local ddX, ddY = math.cos(self.rot) * vAxis, -math.sin(self.rot) * vAxis
    self.speed.x = self.speed.x + ddX * self.acc * dt
    self.speed.y = self.speed.y + ddY * self.acc * dt
    self.x = self.x + self.speed.x
    self.y = self.y + self.speed.y
end

function Car:draw()
    love.graphics.setColor(0, 1, 1, 1)
    love.graphics.rectangle('fill', (track.tiles[self.nextCheckpoint].x - 1) * GRID_SIZE, (track.tiles[self.nextCheckpoint].y - 1)  * GRID_SIZE, GRID_SIZE, GRID_SIZE)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('line', (track.tiles[self.nextCheckpoint].x - 1) * GRID_SIZE, (track.tiles[self.nextCheckpoint].y - 1)  * GRID_SIZE, GRID_SIZE, GRID_SIZE)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(string.format("%.2f", Vector2.magnitude(self.speed.x, self.speed.y), 10, 10))
    love.graphics.draw(self.image, self.x, self.y, -self.rot, 0.15, 0.15, self.image:getWidth() / 2, self.image:getHeight() / 2)

    if self.x < 0 or self.x > SCREEN_WIDTH or self.y < 0 or self.y > SCREEN_HEIGHT then
        local centre = { x = SCREEN_WIDTH / 2, y = SCREEN_HEIGHT / 2}
        local dir = math.rad(Vector2.angle(centre.x, centre.y, self.x, self.y))
        local lineLength = 40
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.line(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, SCREEN_WIDTH / 2 + math.cos(dir) * lineLength, SCREEN_HEIGHT / 2 - math.sin(dir) * lineLength)
    end
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