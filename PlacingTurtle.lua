local function Main()
    local computer = peripheral.wrap('down')
    turtle.select(1)
    turtle.placeDown()
    turtle.dropDown(64)
    computer.turnOn()
    sleep(10)
end
Main()