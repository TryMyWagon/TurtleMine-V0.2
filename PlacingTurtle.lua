local function Main()
    turtle.select(1)
    turtle.place()
    turtle.drop(64)
    turtle.turnRight()
    local computer = peripheral.wrap('left')
    computer.turnOn(true)
    turtle.turnLeft()
    sleep(10)
end

Main()