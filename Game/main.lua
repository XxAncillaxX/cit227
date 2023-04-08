--Require Section
Input = require('library/Input')
anim8 = require('library/anim8')
require('hero')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    input = Input()
    input:bind('w', 'up')
    input:bind('s', 'down')
    input:bind('d', 'right')
    input:bind('a', 'left')
    input:bind('space', 'action')

    hero = Hero:Create()

end--load

function love.update(dt)
    hero:update(dt)
end--update

function love.draw()
    hero:draw()
end--draw
