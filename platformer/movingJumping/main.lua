function love.load()
    -- wf represents windfield code cloned in
    wf = require 'libraries/windfield/windfield'

    -- params represent gravity for the physics world, x and y
    world = wf.newWorld(0, 500)

    -- x,y, width and height
    player = world:newRectangleCollider(360, 100, 80, 80)
    player.speed = 240

    -- making a platform for the player to landon
    platform = world:newRectangleCollider(250, 400, 300, 100)
    test = 1

    -- static means it will not move
    platform:setType('static')
end


function love.update(dt)
    world:update(dt)

    -- get position of player
    local px, py = player:getPosition()
    if love.keyboard.isDown('right') then
        -- whenever right pressed we add 5 to current x pos
        player:setX(px + player.speed * dt)
    end
    if love.keyboard.isDown('left') then
        -- whenever right pressed we sub 5 to current x pos
        player:setX(px - player.speed * dt)
    end
end

function love.draw()
    world:draw()
end

function love.keypressed(key)
    if key == 'up' then
        player:applyLinearImpulse(0, -7000) -- will make object jump
    end
end