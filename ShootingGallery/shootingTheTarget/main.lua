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

    -- setting font for score text
    gameFont = love.graphics.newFont(40)
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

    -- setting score colour to white
    love.graphics.setColor(1, 1, 1)

    -- setting score font
    love.graphics.setFont(gameFont)

    -- places value of score in top left hand corner
    love.graphics.print(score, 0, 0)
end

--[[ 
     x and y represent mouse current position when pressed,
     button tells which button on mouse was clicked
 --]]
function love.mousepressed( x, y, button, istouch, presses )
    -- 1 represents left mouse click
    if button == 1 then
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            score = score + 1
        end
    end
end

-- will use distance formula to calculate distance from circle
-- aka calculate distance between 2 points
function distanceBetween(x1, y1, x2, y2)
   return math.sqrt((x1 - x2)^2 + (y2 - y1)^2)
end

