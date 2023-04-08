
Input = require("library/Input")

function love.load()
    input = Input()
    input:bind('d', 'right')
    input:bind('a', 'left')
    input:bind('space', 'action')
    --input:bind('')
    love.graphics.setBackgroundColor(0, 0, 0, 0)
end

function handleInput(dt)
    if input:down('right') then
        rect1.speed = rect1.topSpeed
    elseif input:down('left') then
        rect1.speed = -rect1.topSpeed
    else
        rect1.speed = 0
    end
end

function love.update(dt)

end

function love.draw()
    love.graphics.print("hello world", 0,0)
end