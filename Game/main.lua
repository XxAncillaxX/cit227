--Require Section
require('dependencies')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- Creating the Hero Object
    --hero = Hero:Create()
    ship = Ship:Create()
    bg = love.graphics.newImage("assets/graphics/backgrounds/parallax-space-background2.png")
    gameCanvas = love.graphics.newCanvas(270, 320)
end--load

function love.update(dt)
    --updating hero object
    --hero:update(dt)
    ship:update(dt)
end--update

function love.draw()
    -- Drawing to the gameCanvas
    love.graphics.setCanvas(gameCanvas)
        love.graphics.draw(bg, 0, 0)
        ship:draw()
    --back to Drawing on the screen
    love.graphics.setCanvas()
    love.graphics.draw(gameCanvas, 0, 0, 0, 2, 2)    
    --drawing hero object
    --hero:draw()
end--draw
