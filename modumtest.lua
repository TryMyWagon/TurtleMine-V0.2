
--[[
for i = 1, 16 do
    local modem = peripheral.wrap("left")
    modem.open(3)  -- Open channel 3 so that we can listen on it
    local event, modemSide, senderChannel, 
      replyChannel, message, senderDistance = os.pullEvent("modem_message")

    local turtleCount = tonumber(message)

    if turtleCount > 20 then
        while true do
           turtle.turnLeft()
        end
    end
    sleep(5)
end
]]--

local function cum(name)
  if name == "pretzel" then
    while true do
      turtle.turnLeft()
    end
  else
    print("lack of pretzelsk")
  end
end

cum("real")




local function coordinates(x, z, y)
  
end
local coordinates = {}
coordinates[1] = 0
coordinates[2] = 0
coordinates[3] = 0
X = coordinates[1]
Z = coordinates[2]
Y = coordinates[3]

end