function worldToGrid(pos)
    return math.ceil(pos.x / GRID_SIZE), math.ceil(pos.y / GRID_SIZE)
end