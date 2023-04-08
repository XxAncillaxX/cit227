
--importing the anim* library
anim8 = require('library/anim8')

function love.load()
    --Setting the defualt filter for scaling
    love.graphics.setDefaultFilter('nearest', 'nearest')
    --Setting the backgroundColor
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)

    -- NPC 1 Table
    npc1 = {
        x = 100, 
        y = 500,
        image = love.graphics.newImage("assets/graphics/characters.png")
    }

    --NPC 2 Table
    npc2 = {
        x = 300,
        y = 500,
        image = love.graphics.newImage("assets/graphics/characters.png")
    }

    --NPC 3 Table
    npc3 = {
        x = 500,
        y = 500,
        image = love.graphics.newImage("assets/graphics/characters.png")
    }

    --NPC 4 Table
    npc4 = {
        x = 700,
        y = 500,
        image = love.graphics.newImage("assets/graphics/characters.png")
    }

    --Bird Table
    bird = {
        x = 0,
        y = 300,
        -- yOffset for bird to perform sin wave
        yOffset = 0,
        width = 50,
        speed = 150,
        direction = "right",
        image = love.graphics.newImage("assets/graphics/characters.png"),
        -- Time variable to calculate the sin of y
        time = 0
    }

    --Round Enemy Table
    roundEnemy ={
        x = 0,
        y= 100,
        width = 50,
        speed = 200,
        direction = "right",
        image = love.graphics.newImage("assets/graphics/characters.png")
    }

    --creating anim& grids for animations
    local grid = anim8.newGrid(16, 16, npc1.image:getDimensions())
    local grid2 = anim8.newGrid(16, 16, npc2.image:getDimensions())
    local grid3 = anim8.newGrid(16, 16, npc3.image:getDimensions())
    local grid4 = anim8.newGrid(16, 16, npc4.image:getDimensions())
    local grid5 = anim8.newGrid(16,16, roundEnemy.image:getDimensions())
    local grid6 = anim8.newGrid(16,16, bird.image:getDimensions())

    --Setting the animations for each npc and enemy
    npc1.animations = {
        idle = anim8.newAnimation(grid('1-3', 5), 0.35),
    }
    npc2.animations = {
        idle = anim8.newAnimation(grid2('8-12', 21), 0.35),
    }
    npc3.animations = {
        idle = anim8.newAnimation(grid3('14-19', 5), 0.35),
    }
    npc4.animations= {
        idle = anim8.newAnimation(grid4('14-19', 8), 0.35),
    }
    roundEnemy.animations = {
        rolling = anim8.newAnimation(grid5('8-13',19), 0.2),
    }
    bird.animations = {
        flying = anim8.newAnimation(grid6('8-13', 24), 0.2)
    }
    npc1.animation = npc1.animations.idle
    npc2.animation = npc2.animations.idle
    npc3.animation = npc3.animations.idle
    npc4.animation = npc4.animations.idle
    roundEnemy.animation = roundEnemy.animations.rolling
    bird.animation = bird.animations.flying
end

function love.update(dt)
    window_width = love.window.getMode()
    npc1.animation:update(dt)
    npc2.animation:update(dt)
    npc3.animation:update(dt)
    npc4.animation:update(dt)
    --Round Enemy animation update
    roundEnemy.animation:update(dt)
    --Bird animation update and sin wave updates
    bird.time = bird.time + dt
    bird.yOffset = 30 * math.sin(bird.time * 5)
    bird.animation:update(dt)

    -- Setting roundEnemy.x to the current speed * dt
    roundEnemy.x = roundEnemy.x + roundEnemy.speed * dt
    --checking if the value of x is less then 0
    if roundEnemy.x < 0 then
        --updating the speed minus the current speed
        roundEnemy.speed = -roundEnemy.speed
        -- checking which direction the round enemy is facing
        if roundEnemy.direction == "left" then
            -- fliping the sprite if it is facing left
            roundEnemy.animation:flipH()
            -- resetting the direction to right
            roundEnemy.direction = "right"
        end
    --else if to check if the enemy.x is greater then the window's width
    elseif roundEnemy.x + roundEnemy.width > window_width then
            --setting the speed minus the current speed
            roundEnemy.speed = -roundEnemy.speed
            --changing the direction to face left
            roundEnemy.direction = "left"
            --fliping the sprite
            roundEnemy.animation:flipH()
    end

    bird.x = bird.x + bird.speed * dt
    if bird.x < 0 then
        bird.speed = -bird.speed
        if bird.direction == "left" then
            bird.animation:flipH()
            bird.direction = "right"
        end
    elseif bird.x + bird.width > window_width then
            bird.speed = -bird.speed
            bird.direction = "left"
            bird.animation:flipH()
    end
end

function love.draw()
    --drawing npcs
    npc1.animation:draw(npc1.image, npc1.x, npc1.y, 0 ,3 ,3)
    npc2.animation:draw(npc2.image, npc2.x, npc2.y, 0, 3, 3)
    npc3.animation:draw(npc3.image, npc3.x, npc3.y, 0, 3, 3)
    npc4.animation:draw(npc4.image, npc4.x, npc4.y, 0, 3, 3)
    --drawing the roundEnemy
    roundEnemy.animation:draw(roundEnemy.image, roundEnemy.x, roundEnemy.y, 0, 3, 3)
    --drawing the bird
    bird.animation:draw(bird.image, bird.x, bird.y+bird.yOffset, 0, 3, 3)
    --print to watch if the variables are changing correctly
    love.graphics.print(roundEnemy.direction, 0, 0)
end
