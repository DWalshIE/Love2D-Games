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
    -- start off at 10 seconds
    timer = 10

    -- setting font for score text
    gameFont = love.graphics.newFont(40)
end

--[[ variables altered here
     dt stands for delta time
     is our game loop, gets called every frame our game runs at
     value of dt gets changed every single frame with love.update
     value that its set to is amount of time that has passed between
     previous frame and current frame --]]
function love.update(dt)

    --[[ because condition is greater than 0,
        it can still go below 0 if timer were at
        a value of 0.5 and dt had a value of 1 --]]
   if timer > 0 then
     timer = timer - dt
   end

   --[[ if timer ever does fall below 0, this statement
        catches that and keeps it at 0 --]]
   if timer < 0 then
     timer = 0
   end  
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

    -- printing our timer
    -- ceiling rounds number up to next int
    -- floor rounds number down to next int
    love.graphics.print(math.ceil(timer), 300, 0)
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

            --[[ if score increases, we know to change position of target
            target.x = 500
            target.y = 400 --]]

            -- .getWidth gets width of game window in pixels
            -- we can use target.radius to make sure there is space between circle and edge of screen
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        end
    end
end

-- will use distance formula to calculate distance from circle
-- aka calculate distance between 2 points
function distanceBetween(x1, y1, x2, y2)
   return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

