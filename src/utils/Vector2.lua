Vector2 = {}

local pow = math.pow
local sqrt = math.sqrt

function Vector2.angle(x1, y1, x2, y2)
    local rad = -math.atan2(y2 - y1, x2 - x1)
    local deg = math.deg(rad)

    if deg < 0 then deg = deg + 360 end

    return deg
end

function Vector2.magnitude(x, y)
    return sqrt(pow(x, 2) + pow(y, 2))
end

function Vector2.normalised(x, y)
    mag = V.magnitude(x, y)
    nX = x / mag
    ny = y / mag
    return nx, ny
end

function Vector2.pointFromRotDist(rot, dist)
    local x = dist * math.cos(math.rad(rot))
    local y = dist * -math.sin(math.rad(rot))

    return x, y
end