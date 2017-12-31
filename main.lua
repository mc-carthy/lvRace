local Car = require("src.Car")

local car
local carSpritePath = "assets/sprites/car.png"

function love.load()
    car = Car.create(carSpritePath, 50, 50, 0)
end

function love.update(dt)
    car:update(dt)
end

function love.draw()
    car:draw()
end
