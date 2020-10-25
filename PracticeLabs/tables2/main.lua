message = 0

testScores = {95, 87, 98}
testScores.subject = "science"

-- i will start at index 1
-- s will then be 95
-- loop will then move onto contexts of loop
for i,s in ipairs(testScores) do
    message = message + s
end


function love.draw()
    love.graphics.setFont(love.graphics.newFont(50))
    love.graphics.print(testScores.subject)
end