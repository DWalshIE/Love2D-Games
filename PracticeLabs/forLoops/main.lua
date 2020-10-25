message = 0
test = 0
pickle = 0

while message < 100 do 
    message  =  message + 1
    test = test - 5
end

--[[ i=1 is our iterator, gets updated every loop
 3 is the number iterator approaches, onces reached, loop ends
 1 is our step value, amount iterator changes for each loop
for i=1, 3, 1 do
    pickle = pickle + 10
end--]]

for i=1, 3, 1 do
    pickle = pickle + i
end


function love.draw()
    love.graphics.setFont(love.graphics.newFont(50))
    love.graphics.print(pickle)
end
