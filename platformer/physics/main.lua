function love.load()
    -- wf represents windfield code cloned in
    wf = require 'libraries/windfield/windfield'

    -- params represent gravity for the physics world, x and y
    world = wf.newWorld(0, 100)

    -- x,y, width and height
    player = world:newRectangleCollider(360, 100, 80, 80)

    -- making a platform for the player to landon
    platform = world:newRectangleCollider(250, 400, 300, 100)
    test = 1

    -- static means it will not move
    platform:setType('static')
end


function love.update(dt)
    world:update(dt)
end


function love.draw()
    world:draw()
end