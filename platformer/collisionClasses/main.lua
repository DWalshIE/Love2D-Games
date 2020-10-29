function love.load()
    -- wf represents windfield code cloned in
    wf = require 'libraries/windfield/windfield'

    -- params represent gravity for the physics world, x and y
    world = wf.newWorld(0, 800, false)

    --[[ 
        need different collision classes as certain colliders 
        will behave differently, such as a platform or spikes 
    --]]
    
    world:addCollisionClass('Platform')
    world:addCollisionClass('Player'--[[{ignores = {'Platform'}}--]])
    world:addCollisionClass('Danger')

    -- x,y, width and height
    player = world:newRectangleCollider(360, 100, 80, 80, {collision_class = "Player"})
    player:setFixedRotation(true)
    player.speed = 240

    -- making a platform for the player to landon
    platform = world:newRectangleCollider(250, 400, 300, 100, {collision_class = "Platform"})
    test = 1

    -- static means it will not move
    platform:setType('static')

    dangerZone = world:newRectangleCollider(0, 550, 800, 50, {collision_class = "Danger"})
    dangerZone:setType('static')
end


function love.update(dt)
    world:update(dt)

    -- if player body still exists then run
    if player.body then
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

        -- if player ever enters another collider of type danger
        if player:enter('Danger') then
            player:destroy()
        end
    end
end

function love.draw()
    world:draw()
end

function love.keypressed(key)
    if key == 'up' then
        player:applyLinearImpulse(0, -4000) -- will make object jump
    end
end