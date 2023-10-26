
-- Cartesian coordinates start at 0, 0 
--[[
1 = xPos+              (1. ~ x+)
2 = zPos+                 |
3 = xPos-                 |
4 = zPos-    (4. ~ z-)----|----(2. ~ z+)
.                         |
.                         |
.                     (3. ~ x-)
]]


-- x Position and z Position;
xPos = 0
zPos = 0

-- Rom 
xRomPos = 0
zRomPos = 0

-- Direction is 1 to 4
tDir = 1
tRomDir = 1

local function forwardOne()
    turtle.forward()
    if tDir == 1 then
        xPos = xPos + 1
    elseif tDir == 2 then
        zPos = zPos + 1
    elseif tDir == 3 then
        xPos = xPos - 1
    elseif tDir == 4 then
        zPos = zPos - 1
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
local function stripMine()
    local stripLength = 1
    while stripLength < 16 do
        tunnelOne()
        stripLength = stripLength + 1
    end
end

-- RTB function (stores starting location and direction data in x/zRomPos and tRomDir var's)
local function RTB()
    tRomDir = tDir
    if xPos > 0 then
        if tDir == 1 then
            turnRight()
            turnRight()
        elseif tDir == 2 then
            turnRight()
        elseif tDir == 4 then
            turnLeft()
        end
        -- stores location data in xRomPos
        xRomPos = xPos

        -- burns up x's location data
        x = xRomPos
        while x > 1 do
            if turtle.detect() == true then
                digCheckFront()
            end
            forwardOne()
            x = x - 1
        end
    end
    if zPos > 1 then
        if tDir == 1 then
            turnLeft()
        elseif tDir == 2 then
            turnRight()
            turnRight()
        elseif tDir == 3 then
            turnRight()
        end
        -- stores location data in zRomPos
        zRomPos = zPos

        -- burns up z's location data
        z = zRomPos
        while z > 0 do
            if turtle.detect() == true then
                digCheckFront()
            end
            forwardOne()
            z = z - 1
        end
    end
end


local function QuarryMain()
    tunnelOne()
    local jTurn = true
    local stripRow = 0
    while stripRow < 16 do
        stripMine()
        stripRow = stripRow + 1
        -- stripLength = 1
        -- 90 degree turn direction (jTurn)
        -- (true = right)
        -- (false = left)
        if stripRow == 16 then
            stripRow = 0
            break
        elseif jTurn == true then
            turnRight()
            tunnelOne()
            turnRight()
            jTurn = false
        elseif jTurn == false then
            turnLeft()
            tunnelOne()
            turnLeft()
            jTurn = true
        end
    end
end

QuarryMain()
RTB()