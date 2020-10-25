message = 0

testScores = {}

table.insert(testScores, 95)
table.insert(testScores, 87)
table.insert(testScores, 98)

testScores["math"] = 91

--[[testScores[1] = 95
testScores[2] = 87
testScores[3] = 98]]

message = testScores["math"]

function love.draw()
    love.graphics.setFont(love.graphics.newFont(50))
    love.graphics.print(message)
end
