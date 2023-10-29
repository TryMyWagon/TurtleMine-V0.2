local function Main()
    while true do
        turtle.select(1)
        turtle.place()
        turtle.drop(64)
        turtle.turnRight()
        local computer = peripheral.wrap('left')
        computer.turnOn()
        turtle.turnLeft()
        sleep(3)
    end
end

Main()