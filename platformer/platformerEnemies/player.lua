    -- x,y, width and height
    player = world:newRectangleCollider(360, 100, 40, 100, {collision_class = "Player"})
    player:setFixedRotation(true)
    player.speed = 240
    player.animation = animations.idle
    player.isMoving = false
    player.grounded = true
    player.direction = 1

    function playerUpdate(dt)
         -- if player body still exists then run
        if player.body then
            local colliders = world:queryRectangleArea(player:getX() - 20, player:getY() + 50, 40, 2, {'Platform'})
            if #colliders > 0 then
                player.grounded = true
            else 
                player.grounded = false
            end
            player.isMoving = false
            -- get position of player
            local px, py = player:getPosition()
            if love.keyboard.isDown('right') then
                -- whenever right pressed we add 5 to current x pos
                player:setX(px + player.speed * dt)
                player.isMoving = true
                player.direction = 1
            end
            if love.keyboard.isDown('left') then
                -- whenever right pressed we sub 5 to current x pos
                player:setX(px - player.speed * dt)
                player.isMoving = true
                player.direction = -1
            end

            -- if player ever enters another collider of type danger
            if player:enter('Danger') then
                player:destroy()
            end
        end

        if player.grounded then
            if player.isMoving then 
                player.animation = animations.run
            else
                player.animation = animations.idle
            end
        else
            player.animation = animations.jump
        end
        player.animation:update(dt)
    end

    function drawPlayer()
        local px, py = player:getPosition()
        player.animation:draw(sprites.playerSheet, px, py, nil, 0.25 * player.direction, 0.25, 130, 300)
    end