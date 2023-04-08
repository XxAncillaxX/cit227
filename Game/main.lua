--Require Section
Input = require('library/Input')


function love.load()
    input = Input()

    hero = {
        x = 0,
        y = 0,
        w = 0,
        h = 0,
        image = love.graphics.newImage("assets/graphics/hero.png")
    }

end

function love.update(dt)

end

function love.draw()
    love.graphics.draw(hero.image, hero.x, hero.y, 0, 3, 3)
end