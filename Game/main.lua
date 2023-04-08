--Require Section
require('dependencies')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- Creating the Hero Object
    hero = Hero:Create()

end--load

function love.update(dt)
    --updating hero object
    hero:update(dt)
end--update

function love.draw()
    --drawing hero object
    hero:draw()
end--draw
