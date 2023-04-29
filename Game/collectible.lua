Collectible = {type = "collectible"}
Collectible.__index = Collectible

function Collectible:Create(def)
    local this = {
        x = def.x,
        y = def.y,
        w = 16,
        h = 16,
        image = love.graphics.newImage("assets/graphics/spritesheets/power-up.png"),
        animation = nil,
        points = def.properties.points,
        collectibleType = def.properties.type,
        params = def.properties.params
    }

    local grid = anim8.newGrid(16, 16, this.image:getDimensions())
    this.animation = anim8.newAnimation(grid(def.properties.frames, def.properties.row), 0.5)

    setmetatable(this, self)
    return(this)

end

function Collectible:update(dt)
    self.animation:update(dt)
end

function Collectible:draw()
    self.animation:draw(self.image, self.x, self.y)
end