for i = 1, 16 do 
    local modem = peripheral.wrap("left")
    modem.open(3)  -- Open channel 3 so that we can listen on it
    event, modemSide, senderChannel, 
      replyChannel, message, senderDistance = os.pullEvent("modem_message")
    Quandale = "Quandale"
    if Quandale == message then
        while true do
           turtle.turnLeft() 
        end
    end
    sleep(5)
end

