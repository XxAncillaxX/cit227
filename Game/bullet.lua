
bulletTypes = {
    laser = {
        frames = {'5-5', 1},
        damage = 3,
        piercing = false
    },
    spread = {
        frames = {'3-4', 1},
        damage = 1,
        piercing = false
    },
    plasma = {
        frames = {},
        damage = 5,
        piercing = true
    },
}

Bullet = {type = "bullet"}
Bullet.__index = Bullet

function Bullet:Create(bTypeName, x, y, xSpeed, ySpeed)
    local bType = bulletTypes[bTypeName]
    local this ={
        x = x,
        y = y,
        width = 0,
        height = 0,
        xSpeed = xSpeed,
        ySpeed = ySpeed,
        image = love.graphics.newImage("assets/graphics/spritesheets/laser-bolts.png"),
        animation = nil,
        animation2 = nil,
        damage = bType.damage,
        piercing = bType.piercing
    }
        -- Setting up grid and anim8
        local grid = anim8.newGrid(16, 16, this.image:getDimensions())
        --local grid = anim8.newGrid(16,16, this.image:getDimensions())
        local dur = 0.1
        -- setting default animation for Ship
        this.animation = anim8.newAnimation(grid(unpack(bType.frames)), dur)
        --this.animation2 = anim8.newAnimation(grid('2-3', 2), dur),

    setmetatable(this, self)
    return(this)
end

function Bullet:update(dt)
    self.x = self.x + self.xSpeed * dt
    self.y = self.y + self.ySpeed * dt
    self.animation:update(dt)
    -- colllision detection and resolution
    -- check to see if it's offscreen or destroyed
end

function Bullet:draw()
        self.animation:draw(self.image, self.x, self.y)
        --self.animation2:draw(self.image, self.x, self.y)
end