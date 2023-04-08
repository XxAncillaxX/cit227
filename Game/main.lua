--Require Section
Input = require('library/Input')
anim8 = require('library/anim8')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    input = Input()
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
        Image = love.graphics.newImage("assets/graphics/hero.png"),
        --frame = 1
    }
    -- Setting up grid and anim8
    local grid = anim8.newGrid(16, 16, hero.Image:getDimensions())
    -- adding animations table to hero
    hero.animations = {
        walk = anim8.newAnimation(grid('1-6', 2), 0.1),
        idle = anim8.newAnimation(grid('1-3', 1), 0.3),
        swim = anim8.newAnimation(grid('1-6', 4), 0.25)
    }

    hero.animation = hero.animations.swim

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

-- function to user Input
function handleInput(dt)
    if input:down('right') then
        hero.speed = hero.topSpeed
    elseif input:down('left') then
        hero.speed = -hero.topSpeed
    else
        hero.speed = 0
    end--if
end--handleInput

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

function updateHero(rect, dt)
    rect.x = rect.x + (rect.speed * dt)
end--updateHero