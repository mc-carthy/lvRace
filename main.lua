require("src/utils/dependencies")

function love.load()
    car = Car({ x = 50, y = 50 })
end

function love.update(dt)
    car:update(dt)
end

function love.draw()
    love.graphics.setColor(0.25, 0.25, 0.25, 0.5)
    love.graphics.line(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, car.x, car.y)
    love.graphics.setColor(1, 1, 1, 1)
    car:draw()
end
