require("src/utils/dependencies")

function love.load()
    car = Car({ x = 50, y = 50 })
end

function love.update(dt)
    car:update(dt)
end

function love.draw()
    car:draw()
end
