function love.load()
    target = {} 
    target.x = 300 -- target positions
    target.y = 300
    target.radius = 50

    score = 0
    timer = 0

    gameState = 1 -- 1 means player is at main menu, 2 is playing the game

    gameFont = love.graphics.newFont(30) -- font size of our game

    sprites = {} -- will hold our sprites
    sprites.sky = love.graphics.newImage('gameSprites/sky.png')
    sprites.target = love.graphics.newImage('gameSprites/target.png')
    sprites.crosshairs = love.graphics.newImage('gameSprites/crosshair.png')

    love.mouse.setVisible(false) -- making mouse invisible
end

function love.update(dt)
    if timer>0 then timer = timer-dt else timer=0 gameState=1 end
end

function love.draw()
    love.graphics.draw(sprites.sky, 0, 0) -- drawing background
    love.graphics.setColor(1, 1, 1) -- set score colour to white
    love.graphics.setFont(gameFont) -- set secore font
    love.graphics.print("Score: ".. score, 5, 5) -- place score in top left corner
    love.graphics.print("Time left: " .. math.ceil(timer), 300, 5) -- printing our timer

    if gameState == 1 then -- if at main menu
        love.graphics.printf("Click to begin!", 0, 180, love.graphics.getWidth(), "center")
        love.graphics.printf("Left Click for 1 point", 0, 230, love.graphics.getWidth(), "center")
        love.graphics.printf("Right Click for 2 points, but lose time!", 0, 280, love.graphics.getWidth(), "center")
        love.graphics.printf("Careful, if you miss you lose a point!", 0, 330, love.graphics.getWidth(), "center")
    end

    if gameState == 2 then -- if game has started
        love.graphics.draw(sprites.target, target.x - (target.radius + 27), 
        target.y - (target.radius + 22)) -- making crosshair follow mouse
    end
    love.graphics.draw(sprites.crosshairs, love.mouse.getX() - 45, love.mouse.getY() - 45)
end

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

function distanceBetween(x1, y1, x2, y2) -- calculate distance between crosshair and target
   return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

