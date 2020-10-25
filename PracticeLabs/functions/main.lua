message = 0

-- i is a parameter
function increaseMessage(i)
    message = message + i
end


function double(val)
    val = val * 2
    return val
end

--[[increaseMessage(39)
increaseMessage(5)--]]

message = double(12)
chicken  = double(message)


function love.draw()
    love.graphics.setFont(love.graphics.newFont(50))
    love.graphics.print(chicken)
end
