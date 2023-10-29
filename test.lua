local function digCheckFront()
    while turtle.detect() == true and turtle.inspect.name() ~= "computercraft:turtle_expanded" do
        turtle.dig()
    end
end
digCheckFront()