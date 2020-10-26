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
    -- set to 0, when at main menu shouldn't be anything other than 0
    timer = 0

    -- when gameState at 1, we're at menu
    gameState = 1

    -- setting font for score text
    gameFont = love.graphics.newFont(40)

    -- will hold our games sprites
    sprites = {}
    sprites.sky = love.graphics.newImage('gameSprites/sky.png')
    sprites.target = love.graphics.newImage('gameSprites/target.png')
    sprites.crosshairs = love.graphics.newImage('gameSprites/crosshair.png')

    -- making our mouse invisible
    love.mouse.setVisible(false)
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

     -- Once timer hits 0 we will go back to main menu
     gameState = 1
   end  
end


-- Reserved for graphics/images
-- Don't declare calculations/important vars here
function love.draw()

    -- drawing background
    love.graphics.draw(sprites.sky, 0, 0)

    -- setting score colour to white
    love.graphics.setColor(1, 1, 1)

    -- setting score font
    love.graphics.setFont(gameFont)

    -- places value of score in top left hand corner
    love.graphics.print("Score: ".. score, 5, 5)

    -- printing our timer
    -- ceiling rounds number up to next int
    -- floor rounds number down to next int
    love.graphics.print("Time left: " .. math.ceil(timer), 300, 5)

    -- print message to end user to click to begin
    if gameState == 1 then
        love.graphics.printf("Click to begin!", 0, 180, love.graphics.getWidth(), "center")
        love.graphics.printf("Left Click for 1 point", 0, 230, love.graphics.getWidth(), "center")
        love.graphics.printf("Right Click for 2 points, but lose time!", 0, 280, love.graphics.getWidth(), "center")
        love.graphics.printf("Careful, if you miss you lose a point!", 0, 330, love.graphics.getWidth(), "center")
    end
    -- Target not visible as gameState at 2
    if gameState == 2 then
        -- making crosshair follow mouse perfectly
        love.graphics.draw(sprites.target, target.x - (target.radius + 27), target.y - (target.radius + 22))
    end
    love.graphics.draw(sprites.crosshairs, love.mouse.getX() - 45, love.mouse.getY() - 45)
end

--[[ 
     x and y represent mouse current position when pressed,
     button tells which button on mouse was clicked
 --]]
 function love.mousepressed( x, y, button, istouch, presses )
    if gameState == 2 then
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            if button == 1 then
            	score = score + 1
            elseif button == 2 then
            	score = score + 2
            	timer = timer - 1
            end
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        elseif score > 0 then
        	score = score - 1
        end
    elseif button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
        score = 0
    end
end

-- will use distance formula to calculate distance from circle
-- aka calculate distance between 2 points
function distanceBetween(x1, y1, x2, y2)
   return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

