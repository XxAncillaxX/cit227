--Require Section
Input = require('library/Input')
anim8 = require('library/anim8')
require('hero')
require('input_bindings')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- Creating the Hero Object
    hero = Hero:Create()

end--load

function love.update(dt)
    hero:update(dt)
end--update

function love.draw()
    hero:draw()
end--draw
