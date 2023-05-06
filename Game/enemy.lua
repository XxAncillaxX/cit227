Enemy ={}
Enemy.__index = Enemy

function Enemy:Create(x, y, def)
    local this = {
        x = x,
        y = y,
        health = def.health,
        bulletType = def.bulletType,
        image = love.graphics.newImage(def.imageFile),
        animation = nil,
        points = def.points
    }

    local grid = anim8.newGrid(def.width, def.height, this.image.getDimensions())
    this.animation = anim8.newAnimation(grid(unpack(def.frames), duration)
    
    setmetatable(this, self)
    return(this)
end

function Enemy:update(dt)

end

function Enemy:draw()

end

function Enemy:fire()

end