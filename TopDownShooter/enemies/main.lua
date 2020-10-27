function love.load()
    sprites = {}
    sprites.background = love.graphics.newImage('sprites/background.png')
    sprites.bullet = love.graphics.newImage('sprites/bullet.png')
    sprites.player = love.graphics.newImage('sprites/player.png')
    sprites.zombie = love.graphics.newImage('sprites/zombie.png')

    player = {}
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    -- set to 180 as 3 times 60 is 180, dt is 1/60 so need high value
    player.speed = 180

    tempRotation = 0
    zombies = {}

end


function love.update(dt)
    -- for everytime d is pressed, x position is increased by 1
    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed*dt
    end
    if love.keyboard.isDown("a") then
        player.x = player.x - player.speed*dt
    end
    if love.keyboard.isDown("w") then
        player.y = player.y - player.speed*dt
    end
    if love.keyboard.isDown("s") then
        player.y = player.y + player.speed*dt
    end

    tempRotation = tempRotation +  0.01

end

function love.draw()
    love.graphics.draw(sprites.background, 0 , 0)

    love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngle(), nil, nil, 
    sprites.player:getWidth() / 2, sprites.player:getHeight() / 2)

    for i,z in ipairs(zombies) do
        love.graphics.draw(sprites.zombie, z.x, z.y)  
    end
end

function love.keypressed(key)
    if key == "space" then
        spawnZombie()
    end

end

function playerMouseAngle()
   return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX() ) + math.pi
end

function spawnZombie()
    local zombie = {}
    zombie.x = math.random(0, love.graphics.getWidth())
    zombie.y = math.random(0, love.graphics.getHeight())
    zombie.speed = 100
    table.insert(zombies, zombie)
end

