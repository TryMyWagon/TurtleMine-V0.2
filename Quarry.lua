
-- Cartesian coordinates start at 0, 0 
--[[
1 = XPos+             (1. ~ x+)
2 = ZPos+                 |
3 = XPos-                 |
4 = ZPos-    (4. ~ z-)----|----(2. ~ z+)
.                         |
.                         |
.                     (3. ~ x-)
]]


-- x Position and z Position;
XPos = 0
ZPos = 0

-- Rom 
XRomPos = 0
ZRomPos = 0

-- Direction is 1 to 4
TDir = 1
TRomDir = 1

-- movement to keep track of cartesian position
local function forwardOne()
    turtle.forward()
    if TDir == 1 then
        XPos = XPos + 1
    elseif TDir == 2 then
        ZPos = ZPos + 1
    elseif TDir == 3 then
        XPos = XPos - 1
    elseif TDir == 4 then
        ZPos = ZPos - 1
    end
end

-- Right and left turn direction reccords
local function turnRight()
    turtle.turnRight()
    if TDir == 4 then
        TDir = 1
    else
        TDir = TDir + 1
    end
end
local function turnLeft()
    turtle.turnLeft()
    if TDir == 1 then
        TDir = 4
    else
        TDir = TDir - 1
    end
end
-- function to face North (x+)
local function faceNorth()
    while TDir ~= 1 do
        if TDir == 4 then
            turnRight()
        elseif TDir == 3 then
            turnLeft()
        elseif TDir == 2 then
            turnLeft()
        end
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
-- pick up fuel from chest above (coal blocks)
local function fuelObtain()
    turtle.select(1)
--    if turtle.getItemDetail.name("minecraft:coal_block") then
--        fuelCheck()
--    else
    turtle.dropDown()
    turtle.suckUp(5)
    fuelCheck()
--    end
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
    if XPos == 0 and ZPos == 0 then
        if TDir == 1 then
            turnRight()
            turnRight()
        elseif TDir == 2 then
            turnRight()
        elseif TDir == 4 then
            turnLeft()
        end
        if TDir == 3 then
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


-- Return to base function (stores starting location and direction data in x/ZRomPos and TRomDir var's)
local function RTB()
    -- stores location data in XRomPos
    XRomPos = XPos
    -- stores location data in ZRomPos
    ZRomPos = ZPos
    -- stores direction data in TRomDir
    TRomDir = TDir
    if XPos > 0 then
        if TDir == 1 then
            turnRight()
            turnRight()
        elseif TDir == 2 then
            turnRight()
        elseif TDir == 4 then
            turnLeft()
        end
        for xReturn = 1, XRomPos do
            if turtle.detect() == true then
                digCheckFront()
            end
            fuelCheck()
            forwardOne()
        end
    end
    if ZPos > 0 then
        if TDir == 1 then
            turnLeft()
        elseif TDir == 2 then
            turnRight()
            turnRight()
        elseif TDir == 3 then
            turnRight()
        end
        for zReturn = 1, ZRomPos do
            if turtle.detect() == true then
                digCheckFront()
            end
            fuelCheck()
            forwardOne()
        end
    end
end

-- Return to scene function (Return to the cordinates stored in x/ZRomPos and TRomDir var's)
local function RTS()
    if XPos == 0 and ZPos == 0 then
        -- face x+ (east) and moves (XRomPos) distance in blocks
        if TDir == 1 then
            turnRight()
        elseif TDir == 3 then
            turnLeft()
        elseif TDir == 4 then
            turnRight()
            turnRight()
        end
        for returnZ = 1, ZRomPos do
            if turtle.detect() == true then
                digCheckFront()
            end
            fuelCheck()
            forwardOne()
        end
        -- face z+ (north) and moves (ZRomPos) distance in blocks
        if TDir == 2 then
            turnLeft()
        elseif TDir == 4 then
            turnRight()
        elseif TDir == 3 then
            turnRight()
            turnRight()
        end
        for returnX = 1, XRomPos do
            if turtle.detect() == true then
                digCheckFront()
            end
            fuelCheck()
            forwardOne()
        end

    end
end

-- navigates to chosen chunk grid coordinates
local function travelStartPoint()
    if TurtleCount >= 12 and TurtleCount <= 15 then
        for move = 1, 48 do
            fuelCheck()
            tunnelOne()
        end
    elseif TurtleCount >= 8 and TurtleCount <= 11  then
        for move = 1, 32 do
            fuelCheck()
            tunnelOne()
        end
    elseif TurtleCount >= 4 and TurtleCount <= 7 then
        for move = 1, 16 do
            fuelCheck()
            tunnelOne()
        end
    end
    local leftOrRight = {}
    leftOrRight[15] = false
    leftOrRight[14] = false
    leftOrRight[11] = false
    leftOrRight[10] = false
    leftOrRight[7] = false
    leftOrRight[6] = false
    leftOrRight[3] = false
    leftOrRight[2] = false
    leftOrRight[13] = true
    leftOrRight[9] = true
    leftOrRight[5] = true
    leftOrRight[1] = true
    if leftOrRight[TurtleCount] == false then
        turnLeft()
    elseif leftOrRight[TurtleCount] == true then
        turnRight()
    end
    local howManyBlocks = {}
    howManyBlocks[15] = 32
    howManyBlocks[11] = 32
    howManyBlocks[7] = 32
    howManyBlocks[3] = 32
    howManyBlocks[14] = 16
    howManyBlocks[10] = 16
    howManyBlocks[6] = 16
    howManyBlocks[2] = 16
    howManyBlocks[13] = 16
    howManyBlocks[9] = 16
    howManyBlocks[5] = 16
    howManyBlocks[1] = 16
    if(TurtleCount ~= 13 or 9 or 5 or 1) then
        for move = 1, howManyBlocks[TurtleCount] do
            fuelCheck()
            tunnelOne()
        end
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
    turtle.turnRight()
    turtle.turnRight()
    turtle.select(1)
    TurtleCount = (turtle.getItemCount())
    turtle.drop(64)
    turtle.turnLeft()
    fuelObtain()
    forwardOne()
    travelStartPoint()
    faceNorth()
    QuarryMain()
    RTB()
    storeMaterials()
    RTS()
end


mainInit()






-- // ADD // 
-- ERROR too many turtles
-- Collect fuel from above
-- fix grid patterning
-- create a program to make the turtles self build the whole operation 