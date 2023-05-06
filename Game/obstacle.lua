
Obstacle ={}
Obstacle.__index = Obstacle

function Obstacle:Create(def)
    local this = {
        x = def.x,
        y = def.y,
        w = def.width,
        h = def.height,
        --health = def.properties.health,
        --weapon = Weapon:Create(def.properties.weapon),
        image = love.graphics.newImage("assets/graphics/spritesheets/" .. def.properties.image),
        animation = nil,
        --points = def.points
    }

    local grid = anim8.newGrid(def.width, def.height, this.image:getDimensions())

    if (def.properties.frameRow == 0) then
        this.animation = anim8.newAnimation(grid(def.properties.frameColumn, def.properties.frames), def.properties.frameDuration)
    else
        this.animation = anim8.newAnimation(grid(def.properties.frames, def.properties.frameRow), def.properties.frameDuration)

    end
    setmetatable(this, self)
    return(this)
end

function Obstacle:update(dt)
    -- move enemy
    self.animation:update(dt)
    -- do collision detection
    -- check for bullets that are not from enemy's
end

function Obstacle:draw()
    self.animation:draw(self.image, self.x, self.y)
end
