function love.load()
    love.window.setMode(1000, 768)

    anim8 = require 'libraries/anim8/anim8'
    sti = require 'libraries/Simple-Tiled-Implementation/sti'

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

    require('player')

    -- making a platform for the player to landon
    platform = world:newRectangleCollider(250, 400, 300, 100, {collision_class = "Platform"})
    test = 1

    -- static means it will not move
    platform:setType('static')

    dangerZone = world:newRectangleCollider(0, 550, 800, 50, {collision_class = "Danger"})
    dangerZone:setType('static')

    loadMap()
end


function love.update(dt)
    world:update(dt)
    gameMap:update(dt)
    playerUpdate(dt)
end

function love.draw()
    gameMap:drawLayer(gameMap.layers["Tile Layer 1"])
    world:draw()
    drawPlayer()
end

function love.keypressed(key)
    if key == 'up' then
        -- only allow player to jump if there is at least 1 colliderr
        if player.grounded then
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

function loadMap()
    gameMap = sti("maps/level1.lua")
end