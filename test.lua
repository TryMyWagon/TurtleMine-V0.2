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