for i = 1, 16 do 
    local modem = peripheral.wrap("left")
    modem.open(3)  -- Open channel 3 so that we can listen on it
    event, modemSide, senderChannel, 
      replyChannel, message, senderDistance = os.pullEvent("modem_message")


    print(message)
    sleep(3)
end

