
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
        print(xRomPos, zRomPos)
        for xReturn = 1, xRomPos do
            if turtle.detect() == true then
                digCheckFront()
            end
            fuelCheck()
            forwardOne()
            print(xRomPos, zRomPos)
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
        -- stores location data in zRomPos
        zRomPos = zPos

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
            print(xRomPos, zRomPos)
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
            print(xRomPos, zRomPos)
        end
    end
end

local function QuarryMain()
    fuelCheck()
    digCheckFront()
    turtle.forward()
    digCheckUp()
    turtle.digDown()
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

QuarryMain()
RTB()
storeMaterials()
print(xRomPos, zRomPos)
RTS()