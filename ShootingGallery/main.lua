-- runs when game loads
-- major variables declared here
function love.load()
    number = 0
end

--[[ variables altered here
     dt stands for delta time
     is our game loop, gets called every frame our game runs at --]]
function love.update(dt)
    number = number + 1 -- Increases by 1, every single frame
end


-- Reserved for graphics/images
-- Don't declare calculations/important vars here
function love.draw()
    love.graphics.print(number)
end