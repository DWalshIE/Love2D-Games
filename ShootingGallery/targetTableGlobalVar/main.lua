-- runs when game loads
-- major variables declared here
function love.load()
    -- refer to whenever want to talk about main circle target
    target = {} 

    -- target positions
    target.x = 300
    target.y = 300

    -- target sizes
    target.radius = 50

    -- keep track of score
    score = 0

    -- keep track of time in realtime
    timer = 0
end

--[[ variables altered here
     dt stands for delta time
     is our game loop, gets called every frame our game runs at --]]
function love.update(dt)
     
end


-- Reserved for graphics/images
-- Don't declare calculations/important vars here
function love.draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", target.x, target.y, target.radius)
end