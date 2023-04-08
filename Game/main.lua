
Input = require("library/Input")

function love.load()
    input = Input()
    input:bind('d', 'right')
    input:bind('a', 'left')
    input:bind('space', 'action')
    --input:bind('')
    love.graphics.setBackgroundColor(0, 0, 0, 0)

    rect1 = {
        x = 0,
        y = 0,
        w = 100,
        h = 100,
        speed = 0,
        topSpeed = 75,
        color = {1,0,0,1}
    }

    rect2 ={
        x = 150,
        y = 200,
        w = 100,
        h = 300,
        speed = 0,
        color = {0,1,0,1}
    }
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
    handleInput(dt)
    updateRect(rect1,dt)
    updateRect(rect2,dt)
end

function love.draw()
    love.graphics.print("hello world", 0,0)
    drawRect(rect2)
    drawRect(rect1)
end

function updateRect(rect, dt)
    rect.x = rect.x + (rect.speed * dt)
    rect.y = rect.y + (rect.speed * dt)
end

function drawRect(rect)
    love.graphics.setColor(rect.color)
    love.graphics.rectangle("fill", rect.x, rect.y, rect.w, rect.h)
    love.graphics.setColor(1,1,1,1)
end