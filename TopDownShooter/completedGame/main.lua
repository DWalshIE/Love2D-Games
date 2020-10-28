function love.load()
    -- Gives a unique value that will diff for each player
    math.randomseed(os.time())

    -- Sprite table containing all sprites for game
    sprites = {}
    sprites.background = love.graphics.newImage('sprites/background.png')
    sprites.bullet = love.graphics.newImage('sprites/bullet.png')
    sprites.player = love.graphics.newImage('sprites/player.png')
    sprites.zombie = love.graphics.newImage('sprites/zombie.png')

    -- player table, will hold relevant attributes
    player = {}
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2

    -- set to 180 as 3 times 60 is 180, dt is 1/60 so need high value
    player.speed = 180
    player.injured = false
    player.injuredSpeed = 290

    -- Setting font size for game texts
    myFont = love.graphics.newFont(30)

    tempRotation = 0

    -- Tables for our zombies and bullets
    zombies = {}
    bullets = {}

    -- Will hold score for game
    score = 0
    gameState = 1
    maxTime = 2
    timer = maxTime
end


function love.update(dt)

    -- Once gameState is playing set speed to player speed
    if gameState == 2 then
        local moveSpeed = player.speed

        -- once player is injured increase their speed
        if player.injured then
            moveSpeed = player.injuredSpeed
        end

        -- for everytime d is pressed, x position is increased by 1
        if love.keyboard.isDown("d") and player.x < love.graphics.getWidth() then
            player.x = player.x + moveSpeed*dt
        end
        if love.keyboard.isDown("a") and player.x > 0 then
            player.x = player.x - moveSpeed*dt
        end
        if love.keyboard.isDown("w") and player.y > 0 then
            player.y = player.y - moveSpeed*dt
        end
        if love.keyboard.isDown("s") and player.y < love.graphics.getHeight() then
            player.y = player.y + moveSpeed*dt
        end
    end

    tempRotation = tempRotation +  0.01

    -- Looping through zombies table
    for i,z in ipairs(zombies) do
        z.x = z.x + (math.cos(zombiePlayerAngle(z)) * z.speed * dt)
        z.y = z.y + (math.sin(zombiePlayerAngle(z)) * z.speed * dt)

        -- Getting distance between player and zombie
        if distanceBetween(z.x, z.y, player.x, player.y) < 30 then

            -- If player wasn't already injured then set to true as is now injured
            if player.injured == false then
                player.injured = true
                z.dead = true
            else
                -- player is already injured and touched zombie so end game
                for i,z in ipairs(zombies) do
                    zombies[i] = nil
                    gameState = 1
                    player.injured = false
                    player.x = love.graphics.getWidth() / 2
                    player.y = love.graphics.getHeight() / 2
                end
            end
        end
    end

    for i,b in ipairs(bullets) do
        b.x = b.x + (math.cos(b.direction) * b.speed * dt)
        b.y = b.y + (math.sin(b.direction) * b.speed * dt)
    end

    --[[
        i = number of elements in bullet table
        following 1 is ending value, ends at 1
        negative 1 means it decreases by 1
     --]]
    for i=#bullets, 1, -1 do
        local b = bullets[i] -- b represents current bullet obj we're looking at
        if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth()
        or b.y > love.graphics.getHeight() then
            table.remove(bullets, i)
        end
    end

    -- Getting distance between zombie and bullet to determine if dead
    for i,z in ipairs(zombies) do
        for j,b in ipairs(bullets) do
            if distanceBetween(z.x, z.y, b.x, b.y) < 20 then
                z.dead  = true
                b.dead = true
                score = score + 1
            end
        end
    end

    -- removing the current instance of the zombie that is dead
    for i=#zombies, 1, -1 do
        local z = zombies[i]
        if z.dead == true then
            table.remove(zombies, i)
        end
    end

    -- removing current instance of bullet if no longer in use
    for i=#bullets, 1, -1 do
        local b = bullets[i]
        if b.dead == true then
            table.remove(bullets, i)
        end
    end

    -- if the game is playing set the timer for zombies to spawn
    if gameState == 2 then
        timer = timer - dt
        if timer <= 0 then
            spawnZombie()
            maxTime = 0.95 * maxTime
            timer = maxTime
        end
    end
end

function love.draw()
    
    -- Drawing background
    love.graphics.draw(sprites.background, 0 , 0)  
    
    -- if player gets injured set their sprite to red
    if player.injured then 
        love.graphics.setColor(1, 0, 0)
    end

    -- draw sprite 
    love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngle(), nil, nil, 
    sprites.player:getWidth() / 2, sprites.player:getHeight() / 2)

    -- setting back to white
    love.graphics.setColor(1, 1, 1)

    -- if at main menu display to player to click to begin
    if gameState == 1 then
        love.graphics.setFont(myFont)
        love.graphics.printf("Click anywhere to begin!", 0, 50, love.graphics.getWidth(), "center")
    end

    -- displaying the player's score
    love.graphics.printf("Score: " .. score, 0, love.graphics.getHeight() - 100, love.graphics.getWidth(), "center")

    -- drawing zombies to screen
    for i,z in ipairs(zombies) do
        love.graphics.draw(sprites.zombie, z.x, z.y, zombiePlayerAngle(z),nil,nil, sprites.zombie:getWidth()/2, sprites.zombie:getHeight()/2)  
    end

    -- drawing bullet to screen
    for i,b in ipairs(bullets) do
        love.graphics.draw(sprites.bullet, b.x, b.y, nil, 0.5, nil, sprites.bullet:getWidth() / 2, sprites.bullet:getHeight() / 2)
    end

end

-- if space bar is pressed spawn zombie
function love.keypressed(key)
    if key == "space" then
        spawnZombie()
    end
end

-- spawn bullet if game started else start game
function love.mousepressed(x, y, button)
    if button == 1 and gameState == 2 then
        spawnBullet()
    elseif button == 1 and gameState == 1 then
        gameState = 2
        maxTime = 2
        timer = maxTime
        score = 0
    end
end

-- get angle between player and mouse 
function playerMouseAngle()
   return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX() ) + math.pi
end

-- getting angle between zombie and player
function zombiePlayerAngle(enemy)
    return math.atan2(player.y - enemy.y, player.x - enemy.x)
end

function spawnZombie()
    -- local zombie table to hold relevant attributes
    local zombie = {}
    zombie.x = 0
    zombie.y = 0
    zombie.speed = 140
    zombie.dead = false

    -- spawning areas for zombie
    local side = math.random(1,4)
    if side == 1 then
        zombie.x = -30
        zombie.y = math.random(0, love.graphics.getHeight())
    elseif side == 2 then
        zombie.x = love.graphics.getWidth() + 30
        zombie.y = math.random(0, love.graphics.getHeight())
    elseif side == 3 then
        zombie.x = math.random(0, love.graphics.getWidth())
        zombie.y = -30
    elseif side == 4 then
        zombie.x = math.random(0, love.graphics.getWidth())
        zombie.y = love.graphics.getHeight() + 30
    end
    table.insert(zombies, zombie)
end

function spawnBullet()
    -- local bullet table to hold relevant attributes
    local bullet = {}
    bullet.x = player.x
    bullet.y  = player.y 
    bullet.speed = 500
    bullet.dead = false
    bullet.direction = playerMouseAngle()
    table.insert(bullets, bullet)
end

-- distance between 2 points function
function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

