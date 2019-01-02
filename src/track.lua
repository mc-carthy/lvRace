Track = Class{}

function Track:init(params)
    self.tiles = {}
    self:createTrack()
end

function Track:createTrack()
    table.insert(self.tiles, { x = 2, y = 2})
    table.insert(self.tiles, { x = 5, y = 1})
    table.insert(self.tiles, { x = 8, y = 2})
    table.insert(self.tiles, { x = 8, y = 5})
    table.insert(self.tiles, { x = 5, y = 4})
    table.insert(self.tiles, { x = 2, y = 5})
end

function Track:draw()
    for k, v in pairs(self.tiles) do
        love.graphics.setColor(1, 0, 1, 1)
        love.graphics.rectangle('fill', (v.x - 1) * GRID_SIZE, (v.y - 1)  * GRID_SIZE, GRID_SIZE, GRID_SIZE)
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle('line', (v.x - 1) * GRID_SIZE, (v.y - 1)  * GRID_SIZE, GRID_SIZE, GRID_SIZE)
    end
end