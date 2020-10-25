message = 0

function getHalf(i)
    local var = i -- local means its only accessible to the function defined in
    var = var / 2
    return var
end


function love.draw()
    love.graphics.setFont(love.graphics.newFont(50))
    love.graphics.print(message)
end
