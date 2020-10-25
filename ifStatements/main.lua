message = 5
chicken = "10"
output = chicken * 3

function love.draw()
    love.graphics.setFont(love.graphics.newFont(50))
    love.graphics.print(message)
end
