function love.load()

    anim8 = require 'libraries/anim8/anim8'

    sprites = {}
    sprites.playerSheet= love.graphics.newImage('sprites/playerSheet.png')

    local grid = anim8.newGrid(614, 564, sprites.playerSheet:getWidth(), sprites.playerSheet:getHeight())

    animations = {}
    animations.idle = anim8.newAnimation(grid('1-15',1), 0.05)
    animations.jump = anim8.newAnimation(grid('1-7',2),0.05)
    animations.run = anim8.newAnimation(grid('1-15',3),0.05)
    -- wf represents windfield code cloned in
    wf = require 'libraries/windfield/windfield'

    -- params represent gravity for the physics world, x and y
    world = wf.newWorld(0, 800, false)

    world:setQueryDebugDrawing(true)

    --[[ 
        need different collision classes as certain colliders 
        will behave differently, such as a platform or spikes 
    --]]
    
    world:addCollisionClass('Platform')
    world:addCollisionClass('Player'--[[{ignores = {'Platform'}}--]])
    world:addCollisionClass('Danger')

    -- x,y, width and height
    player = world:newRectangleCollider(360, 100, 40, 100, {collision_class = "Player"})
    player:setFixedRotation(true)
    player.speed = 240
    player.animation = animations.idle

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

    player.animation:update(dt)
end

function love.draw()
    world:draw()

    local px, py = player:getPosition()
    player.animation:draw(sprites.playerSheet, px, py, nil, 0.25, nil, 130, 300)
end

function love.keypressed(key)
    if key == 'up' then
        local colliders = world:queryRectangleArea(player:getX() - 20, player:getY() + 50, 40, 2, {'Platform'})

        -- only allow player to jump if there is at least 1 collider
        if #colliders > 0 then
            player:applyLinearImpulse(0, -4000) -- will make object jump
        end
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        local colliders = world:queryCircleArea(x, y, 200, {'Platform', 'Danger'})
        for i,c in ipairs(colliders) do
            c:destroy()
        end
    end
end