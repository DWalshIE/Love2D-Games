-- runs when game loads
-- major variables declared here
function love.load()
    
end

--[[ variables altered here
     dt stands for delta time
     is our game loop, gets called every frame our game runs at --]]
function love.update(dt)
     
end


-- Reserved for graphics/images
-- Don't declare calculations/important vars here
function love.draw()
    love.graphics.rectangle("fill", 200, 400, 200, 100)
    love.graphics.circle("fill", 300, 200, 100)
end