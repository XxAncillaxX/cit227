Collectible = {type = "collectible"}
Collectible.__index = Collectible

function Collectible:Create(x, y)
    local this = {
        x = x,
        y = y,
        w = 16,
        h = 16,
        image = love.graphics.newImage("assets/graphics/spritesheets/power-up.png"),
        animation = nil
    }

    local grid = anim8.newGrid(0, 0, 16, 16, this.Image:getDimensions())
    this.animation = anim8.newAnimation(grid('1-2', 1), 0.5)

    setmetatable(this, self)
    return(this)

end

function Collectible:update(dt)
    self.animation:update(dt)
end

function Collectible:draw()
    self.animation:draw(self.image, self.x, self.y)
end