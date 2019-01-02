require("src/utils/dependencies")

SCALE_FACTOR = 3
SCREEN_WIDTH, SCREEN_HEIGHT = love.graphics.getWidth(), love.graphics.getHeight()

function love.load()
    love.window.setMode(love.graphics.getWidth() * SCALE_FACTOR, love.graphics.getHeight() * SCALE_FACTOR)
    car = Car({ x = GRID_SIZE, y = GRID_SIZE })
    track = Track({})
end

function love.update(dt)
    car:update(dt)
end

function love.draw()
    -- love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    love.graphics.scale(SCALE_FACTOR)
    -- love.graphics.translate(-love.graphics.getWidth() / 2, -love.graphics.getHeight() / 2)
    track:draw()
    love.graphics.setColor(0.25, 0.25, 0.25, 0.5)
    drawGrid()
    -- love.graphics.line(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, car.x, car.y)
    love.graphics.setColor(1, 1, 1, 1)
    car:draw()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function drawGrid()
    for x = 1, love.graphics.getWidth() / GRID_SIZE do
        for y = 1, love.graphics.getHeight() / GRID_SIZE do
            love.graphics.rectangle('line', (x - 1) * GRID_SIZE, (y - 1)  * GRID_SIZE, GRID_SIZE, GRID_SIZE)
        end
    end
end