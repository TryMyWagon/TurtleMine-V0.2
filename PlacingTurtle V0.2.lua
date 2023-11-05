-- establishes direction and turn functions with rotation ammount arguments
TDir = 1
local function turnRight(turnCount)
    turnCount = turnCount or 1
    for dir = 1, turnCount, 1 do
        turtle.turnRight()
        if TDir == 4 then
            TDir = 1
        else
            TDir = TDir + 1
        end
    end
end
local function turnLeft(turnCount)
    turnCount = turnCount or 1
    for dir = 1, turnCount, 1 do
        turtle.turnLeft()
        if TDir == 1 then
            TDir = 4
        else
            TDir = TDir - 1
        end
    end
end
-- function for changing the faced direction with parseable north, east, south, west, arguments
local function faceCardinalDirection(direction)
    if direction == "north" then
        while TDir ~= 1 do
            if TDir == 4 then
                turtle.turnRight()
                break
            end
            turnLeft()
        end
    elseif direction == "east" then
        while TDir ~= 2 do
            if TDir == 1 then
                turnRight()
                break
            end
            turnLeft()
        end
    elseif direction == "south" then
        while TDir ~= 3 do
            if TDir == 2 then
                turnRight()
                break
            end
            turnLeft()
        end
    elseif direction == "west" then
        while TDir ~= 4 do
            if TDir == 3 then
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
        if blockBool then
            BlockID = data.name
        end
        while turtle.detect() == true and BlockID ~= "computercraft:turtle_expanded" do
            turtle.dig()
        end
    end
end
-- main() function
local function main()
    turtle.select(2) 
    if turtle.getItemCount() > 0 then
        digCheckFront()
        turtle.place()
        for slotCount = 2, 4 do
            turtle.select(slotCount)
            turtle.suck()
        end
        turtle.select(2)
        turtle.placeUp()
        turtle.select(3)
        turtle.dropUp()
        faceCardinalDirection("south")
    end
end
-- init
main()