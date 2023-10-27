
-- Cartesian coordinates start at 0, 0 
--[[
1 = xPos+             (1. ~ x+)
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

-- movement to keep track of cartesian position
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

-- Right and left turn direction reccords
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

-- Fuelcheck function 
local function fuelCheck()
    if turtle.getFuelLevel() < 32 then
        print("Refueling")
    end
    while turtle.getFuelLevel() < 32 do
        turtle.select(1)
        turtle.refuel(1)
        if turtle.getFuelLevel() >= 32 then
            break
        end
        sleep(2)
    end
end

-- digChecks for gravel/sand etc
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
        fuelCheck()
        tunnelOne()
        stripLength = stripLength + 1
    end
end

-- Storage deposit function
local function storeMaterials()
    if xPos == 0 and zPos == 0 then
        if tDir == 1 then
            turnRight()
            turnRight()
        elseif tDir == 2 then
            turnRight()
        elseif tDir == 4 then
            turnLeft()
        end
        if tDir == 3 then
            turtle.forward()
            for store = 2, 16 do
                turtle.select(store)
                turtle.dropDown(64)
            end
            turtle.select(1)
            turnRight()
            turnRight()
            turtle.forward()
        end
    end
end


-- Return to base function (stores starting location and direction data in x/zRomPos and tRomDir var's)
local function RTB()
    -- stores location data in xRomPos
    xRomPos = xPos
    -- stores location data in zRomPos
    zRomPos = zPos
    -- stores direction data in tRomDir
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
        for xReturn = 1, xRomPos do
            if turtle.detect() == true then
                digCheckFront()
            end
            fuelCheck()
            forwardOne()
        end
    end
    if zPos > 0 then
        if tDir == 1 then
            turnLeft()
        elseif tDir == 2 then
            turnRight()
            turnRight()
        elseif tDir == 3 then
            turnRight()
        end
        for zReturn = 1, zRomPos do
            if turtle.detect() == true then
                digCheckFront()
            end
            fuelCheck()
            forwardOne()
        end
    end
end

-- Return to scene function (Return to the cordinates stored in x/zRomPos and tRomDir var's)
local function RTS()
    if xPos == 0 and zPos == 0 then
        -- face x+ (east) and moves (xRomPos) distance in blocks
        if tDir == 1 then
            turnRight()
        elseif tDir == 3 then
            turnLeft()
        elseif tDir == 4 then
            turnRight()
            turnRight()
        end
        for returnZ = 1, zRomPos do
            if turtle.detect() == true then
                digCheckFront()
            end
            fuelCheck()
            forwardOne()
        end
        -- face z+ (north) and moves (zRomPos) distance in blocks
        if tDir == 2 then
            turnLeft()
        elseif tDir == 4 then
            turnRight()
        elseif tDir == 3 then
            turnRight()
            turnRight()
        end
        for returnX = 1, xRomPos do
            if turtle.detect() == true then
                digCheckFront()
            end
            fuelCheck()
            forwardOne()
        end

    end
end

local function travelStartPoint()
    -- define right or left side 2 chunk columns from the placing turtle
    -- left = false
    -- right = true 
    
    -- annotaes the distance on the chunk grid (x) the turtle needs to travel by counting the ammount of turtles the placing turtle has left 
    local chunkRow = 0
    if turtleCount == 15 or 14 or 13 or 12 then
        chunkRow = 3
    elseif turtleCount == 11 or 10 or 9 or 8 then
        chunkRow = 2
    elseif turtleCount == 7 or 6 or 5 or 4 then
        chunkRow = 1
    elseif turtleCount == 3 or 2 or 1 or 0 then
        chunkRow = 0
    end
    local xStartingDistance = chunkRow * 16
    -- annotaes the distance on the chunk grid (z) the turtle needs to travel by counting the ammount of turtles the placing turtle has left 
    local chunkColumn = 1
    if turtleCount == 1 or 5 or 9 or 13 then
        chunkColumn = 2
    elseif turtleCount == 2 or 6 or 10 or 14 then
        chunkColumn = 1
    elseif turtleCount == 3 or 7 or 11 or 15 then
        chunkColumn = 1
    elseif turtleCount == 4 or 8 or 12 or 16 then
        chunkColumn = 2
    end
    local zStartingDistance = chunkColumn * 16

    -- moves to the location deduced by above
    for move = 1, xStartingDistance do
        fuelCheck()
        tunnelOne()
    end
    if facingColumn == false then
        turnRight()
    else
        turnLeft()
    end
    -- removes 16 blocks from the farthest right column because turtle is already in line with right side 1st column
    if facingColumn == true then
        zStartingDistance = zStartingDistance - 16
    end
    for move = 1, zStartingDistance do
        fuelCheck()
        tunnelOne()
    end
    if facingColumn == true then
        turnLeft()
    else
        turnRight()
    end
end

local function QuarryMain()
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
            fuelCheck()
            tunnelOne()
            turnRight()
            jTurn = false
        elseif jTurn == false then
            turnLeft()
            fuelCheck()
            tunnelOne()
            turnLeft()
            jTurn = true
        end
    end
end

local function mainInit()
    sleep(1)
    turtle.turnRight(2)
    turtle.select(1)
    turtleCount = (turtle.getItemCount())
    if turtleCount < 15 then
        facingColumn = false
    else
        facingColumn = true
    end
    turtle.drop(64)
    turtle.turnLeft()
    travelStartPoint()
end

mainInit()


-- // ADD // 
-- ERROR too many turtles 