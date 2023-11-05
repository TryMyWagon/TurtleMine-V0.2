-- direction is 1 to 4
local facing = {}
local dir = 1
facing[dir] = "north"
facing[dir] = "east"
facing[dir] = "south"
facing[dir] = "west"

local coordinates = {}
coordinates["x"] = 0
coordinates["z"] = 0
coordinates["y"] = 0


-- establishes direction and turn functions with rotation ammount arguments
local function turnRight(turnCount)
    turnCount = turnCount or 1
    for i = 1, turnCount, 1 do
        turtle.turnRight()
        if dir == 4 then
            dir = 1
        else
            dir = dir + 1
        end
    end
end
local function turnLeft(turnCount)
    turnCount = turnCount or 1
    for i = 1, turnCount, 1 do
        turtle.turnLeft()
        if dir == 1 then
            dir = 4
        else
            dir = dir - 1
        end
    end
end
-- function for changing the faced direction with parseable north, east, south, west, arguments
local function faceCardinaldirection(direction)
    if direction == "north" then
        while dir ~= 1 do
            if dir == 4 then
                turnRight()
                break
            end
            turnLeft()
        end
    elseif direction == "east" then
        while dir ~= 2 do
            if dir == 1 then
                turnRight()
                break
            end
            turnLeft()
        end
    elseif direction == "south" then
        while dir ~= 3 do
            if dir == 2 then
                turnRight()
                break
            end
            turnLeft()
        end
    elseif direction == "west" then
        while dir ~= 4 do
            if dir == 3 then
                turnRight()
                break
            end
            turnLeft()
        end
    end
end
-- function to dig infront (gravity block proof) with a clause to disable mining of turtles
local function digCheckFront()
    while turtle.detect() == true do
        local blockBool, data = turtle.inspect()
            local blockID
        if blockBool then
            local blockID = data.name
        end
        while turtle.detect() == true and blockID ~= "computercraft:turtle_expanded" do
            turtle.dig()
        end
    end
end
local function digCheckUp()
    while turtle.detectUp() == true do
        local blockBool, data = turtle.inspectUp()
            local blockID
        if blockBool then
            local blockID = data.name
        end
        while turtle.detectUp() == true and blockID ~= "computercraft:turtle_expanded" do
            turtle.digUp()
        end
    end
end
local function digCheckDown()
    while turtle.detectDown() == true do
        local blockBool, data = turtle.inspectDown()
            local blockID
        if blockBool then
            local blockID = data.name
        end
        while turtle.detectDown() == true and blockID ~= "computercraft:turtle_expanded" do
            turtle.digDown()
        end
    end
end

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

-- movement to keep track of cartesian position
local function forwardOne(move)
    move = move or 1
    for i = 1, move do
        if turtle.detect() == true then
            digCheckFront()
        elseif turtle.detect() == false then
            turtle.forward()
            if dir == 1 then
                coordinates["x"] = coordinates["x"] + 1
            elseif dir == 2 then
                coordinates["z"] = coordinates["z"] + 1
            elseif dir == 3 then
                coordinates["x"] = coordinates["x"] - 1
            elseif dir == 4 then
                coordinates["z"] = coordinates["z"] - 1
            end
        end
    end
end
-- movement to keep track of vertical axis
local function transpose(vert, height)
    height = height or 1
    if vert == "up" then
        for i = 1, height do
            digCheckUp()
            turtle.up()
            coordinates["y"] = coordinates["y"] + 1
        end
    elseif vert == "down" then
        for i = 1, height do
            digCheckDown()
            turtle.down()
            coordinates["y"] = coordinates["y"] - 1
        end
    end
end

-- place the setup down function
-- put end chest in 2nd slot
-- materials for the chest;
-- s1 disk drive
-- s2 floppy disk
-- s3 storage chest
-- s5 regular chest
-- s6 coal block
local function placeBase()
    turtle.select(2)
    if turtle.getItemCount() > 0 then
        digCheckFront()
        turtle.place()
        for slotCount = 2, 6 do
            turtle.select(slotCount)
            turtle.suck()
        end
        turtle.select(2)
        turtle.placeUp()
        turtle.select(3)
        turtle.dropUp()
        faceCardinaldirection("south")
        forwardOne()
        transpose("up")
        turtle.select(4)
        turtle.placeDown()
        turtle.select(5)
        turtle.placeUp()
        turtle.select(6)
        turtle.dropUp(64)
        forwardOne()
        faceCardinaldirection("north")
    end
end
-- init
placeBase()