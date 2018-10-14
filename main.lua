require("src/utils/dependencies")

SCALE_FACTOR = 3

function love.load()
    love.window.setMode(love.graphics.getWidth() * SCALE_FACTOR, love.graphics.getHeight() * SCALE_FACTOR)
    car = Car({ x = 50, y = 50 })
end

function love.update(dt)
    car:update(dt)
end

function love.draw()
    love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    love.graphics.scale(SCALE_FACTOR)
    love.graphics.origin()
    love.graphics.setColor(0.25, 0.25, 0.25, 0.5)
    love.graphics.line(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, car.x, car.y)
    love.graphics.setColor(1, 1, 1, 1)
    car:draw()
end
