Bullet = {}
Bullet.__index = Bullet

function Bullet:Create(x, y, xSpeed, ySpeed)
    local this ={
        x = x,
        y = y,
        width = 0,
        height = 0,
        xSpeed = xSpeed,
        ySpeed = ySpeed,
        image = love.graphics.newImage("assets/graphics/spritesheets/laser-bolts.png"),
        animation = nil,
        damage = 10,
        piercing = false
    }
        -- Setting up grid and anim8
        local grid = anim8.newGrid(16, 16, this.image:getDimensions())
        local dur = 0.1
        -- setting default animation for Ship
        this.animation = anim8.newAnimation(grid('1-2', 2), dur),
    
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
end