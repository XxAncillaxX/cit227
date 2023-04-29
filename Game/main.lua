
--Require Section
require('dependencies')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    --local font = love.graphics.newFont('')
    gameWidth = 270
    gameHeight = 320
    gameCanvas = love.graphics.newCanvas(270, 320)
    -- Creating the Hero Object
    game = Game:Create(gameWidth, gameHeight)
    -- Creating the map Object and passing it the level, refrence to the ship, gameHeight, and gameWidth
    map = Map:Create("level1.lua", gameHeight ,gameWidth)
    -- Creating the Ship Object
    ship = Ship:Create(map)
    -- Storing background image in to a variable
    bg = love.graphics.newImage("assets/graphics/backgrounds/parallax-space-background2.png")
    hud = HUD:Create(game, ship)
    -- table to store bullets as they are created
    --bullets = {}
end--load
--[[ @XxAncillaxX
function updateBullets(dt)
    -- loop through the indexed pairs of a lua table
    -- very similar to loopin through a list/array by index number
    -- will eventually remove bullets here as well
    for i, b in ipairs(bullets) do
        b:update(dt)
    end
end
]]
function love.update(dt)
    --updating hero object
    --hero:update(dt)
    map:update(dt)
    --ship:update(dt)
    --updateBullets(dt)
    hud:update(dt)
end--update

function love.draw()
    -- Drawing to the gameCanvas
    love.graphics.setCanvas(gameCanvas)
        love.graphics.clear()
        map:draw()
        --love.graphics.draw(bg, 0, 0)
        --ship:draw()
        --for i, b in ipairs(bullets) do
            --b:draw()
        --end
        hud:draw()
    --back to Drawing on the screen
    love.graphics.setCanvas()
    love.graphics.draw(gameCanvas, 0, 0, 0, 2, 2)    
    --drawing hero object
    --hero:draw()
end--draw
