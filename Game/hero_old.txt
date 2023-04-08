--Require Section
Input = require('library/Input')
anim8 = require('library/anim8')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    input = Input()
    input:bind('w', 'up')
    input:bind('s', 'down')
    input:bind('d', 'right')
    input:bind('a', 'left')
    input:bind('space', 'action')

    hero = {
        x = 0,
        y = 0,
        w = 0,
        h = 0,
        speed = 0,
        topSpeed = 100,
        facing = "right",
        Image = love.graphics.newImage("assets/graphics/hero.png"),
        --frame = 1
    }
    -- Setting up grid and anim8
    local grid = anim8.newGrid(16, 16, hero.Image:getDimensions())
    -- adding animations table to hero
    hero.animations = {
        -- grid(4, '1-3') example using column instead of row
        -- current grids use row method
        walk = anim8.newAnimation(grid('1-6', 2), 0.1),
        idle = anim8.newAnimation(grid('1-3', 1), 0.3),
        swim = anim8.newAnimation(grid('1-6', 4), 0.25),
        attack = anim8.newAnimation(grid('1-3', 5), 100.00)
    }
    -- setting default animation for hero
    hero.animation = hero.animations.walk

--[[
    example of using quads
    quads = {
        love.graphics.newQuad(0, 16, 16, 16, hero.Image:getDimensions()),
        love.graphics.newQuad(16, 16, 16, 16, hero.Image:getDimensions()),
        love.graphics.newQuad(32, 16, 16, 16, hero.Image:getDimensions()),
        love.graphics.newQuad(48, 16, 16, 16, hero.Image:getDimensions()),
        love.graphics.newQuad(64, 16, 16, 16, hero.Image:getDimensions()),
        love.graphics.newQuad(80, 16, 16, 16, hero.Image:getDimensions())
    }
    frameDuration = 0.10
    timer = frameDuration
]]
end--load

function love.update(dt)
    handleInput(dt)
    hero.animation:update(dt)
    updateHero(hero, dt)

--[[
    timer example to go with quads
    timer = timer - dt -- subtract the amount of time since the last frame
    if (timer <= 0) then -- if the timer expires, update the frame number
        hero.frame = hero.frame + 1
        if (hero.frame == 7) then
            hero.frame = 1
        end
        timer = frameDuration
    end
]]

end--update

function love.draw()
    --local frame = love.graphics.newQuad(0, 0, 16, 16, hero.Image:getDimensions())
    --love.graphics.draw(hero.Image, quads[hero.frame], hero.x, hero.y, 0, 3, 3)
    hero.animation:draw(hero.Image, hero.x, hero.y, 0, 3, 3)
end--draw

-- Additonal functions

-- function to user Input
function handleInput(dt)
    if input:down('right') then
        moveHero('right')
    elseif input:down('left') then
        moveHero('left')
    elseif input:down('up') then
        moveHero('up')
    elseif input:pressed('action') then
        hero.animation = hero.animations.attack
    else
        hero.speed = 0
        hero.animation = hero.animations.idle
    end--if
end--handleInput

function moveHero(dir)
    hero.speed = hero.topSpeed
    if (dir == "left") then
        hero.speed = -hero.speed
    end
    hero.animation = hero.animations.walk
    if (hero.facing ~= dir) then
        hero.animation:flipH()
        hero.animations.idle:flipH()
        hero.facing = dir
    end-- end hero.facing if
end

function updateHero(hero, dt)
    hero.x = hero.x + (hero.speed * dt)
    --hero.y = hero.y + (hero.speed * dt)
end--updateHero