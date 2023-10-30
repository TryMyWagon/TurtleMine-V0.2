
--[[
local function cretin()
    local BlockBool, data = turtle.inspect()
    if BlockBool then
        F = data.name
    end
end
local function digCheckFront()
    cretin()
    while turtle.inspect() == true and F == "minecraft:sandstone" do
        turtle.dig()
    end
end
digCheckFront()
]]--

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
local function forwardOne(distanceInput)
    if (distanceInput ~= nil or 0) then
        for distance = 1, distanceInput do
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
    end
end

function Test()
    io.write('Distance? (n) ')
    local distanceInput = io.read()
    print("Moving ", distanceInput, " blocks forward" )
    forwardOne(distanceInput)
end

Test()