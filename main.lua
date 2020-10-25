message = 5
chicken = "10"
output = chicken * 3
message = "no"


message = message - 2
message
message = "this just a test"
function love.draw()
    love.graphics.setFont(love.graphics.newFont(50))
    love.graphics.print(message)
end
