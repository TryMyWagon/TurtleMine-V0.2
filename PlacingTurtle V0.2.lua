-- establishes direction and turn functions with rotation ammount arguments
TDir = 1
local function turnRight(turnCount)
    for dir = 1, turnCount do
        turtle.turnRight()
        if TDir == 4 then
            TDir = 1
        else
            TDir = TDir + 1
        end
    end
end
local function turnLeft(turnCount)
    for dir = 1, turnCount do
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
    if(faceCardinalDirection("north")) then
        while TDir == not 1 do
            if TDir == 4 then
                turtle.turnRight()
                break
            end
            turnLeft()
        end
    elseif(faceCardinalDirection("east")) then
        while TDir == not 2 do
            if TDir == 1 then
                turnRight()
                break
            end
            turnLeft()
        end
    elseif(faceCardinalDirection("south")) then
        while TDir == not 3 do
            if TDir == 2 then
                turnRight()
                break
            end
            turnLeft()
        end
    elseif(faceCardinalDirection("west")) then
        while TDir == not 4 do
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