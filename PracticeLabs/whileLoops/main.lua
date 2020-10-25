message = 0
test = 0

while message < 100 do 
    message  =  message + 1
    test = test - 5
end


function love.draw()
    love.graphics.setFont(love.graphics.newFont(50))
    love.graphics.print(test)
end
