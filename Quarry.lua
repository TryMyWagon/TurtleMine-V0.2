
-- Cartesian coordinates start at 0, 0 
--[[
1 = xPos+              (1. ~ x+)
2 = zPos-                  |
3 = xPos-                  |
4 = zPos+     (4. ~ z+)----|----(2. ~ z-)
.                          |
.                          |
.                      (3. ~ x-)
]]


-- x Position and z Position;
xPos = 0
zPos = 0

-- Direction is 1 to 4
tDir = 1


local function forwardOne()
    turtle.forward()
    if tDir == 1 then
        xPos = xPos + 1
    elseif tDir == 3 then
        xPos = xPos - 1
    elseif tDir == 2 then
        zPos = zPos - 1
    elseif tDir == 4 then
        zPos = zPos + 1
    end
end

local function turnRight()
    turtle.turnRight()
    if tDir == 4 then
        tDir = 1
    else
        tDir = tDir + 1
    end
end
local function turnLeft()
    turtle.turnLeft()
    if tDir == 1 then
        tDir = 4
    else
        tDir = tDir - 1
    end
end

local function digCheckFront()
    while turtle.detect() == true do
        turtle.dig()
    end
end
local function digCheckUp()
    while turtle.detectUp() == true do
        turtle.digUp()
    end
end



-- Diggy diggy hole

local function tunnelOne()
    digCheckFront()
    forwardOne()
    digCheckUp()
    turtle.digDown()
end
stripLength = 1
local function stripMine()
    while stripLength <= 16 do
        tunnelOne()
        stripLength = stripLength + 1
    end
end
stripRow = 1
jTurn = true

local function QuarryMain()
    while stripRow <= 16 do
        digCheckFront()
        forwardOne()
        stripMine()
        stripRow = stripRow + 1  
        stripLength = 1
        -- 90 degree turn direction (jTurn)
        -- (true = right)
        -- (false = left)
        if jTurn(true) then
            turnRight()
            tunnelOne()
            turnRight()
            jTurn = false
        elseif jTurn(false) then
            turnLeft()
            tunnelOne()
            turnRight()
            jTurn = true
        end
    end

end
QuarryMain()