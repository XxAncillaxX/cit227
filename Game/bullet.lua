Bullet = {}
Bullet.__index = Bullet

function Bullet:Create(x, y, xSpeed, ySpeed)
    local this ={
        x = x,
        y = y,
        width = 0,
        height = 0,
        xSpeed = 0,
        ySpeed = 0,
        image = love.graphics.newImage("assets/graphics/spritesheets/laser-bolts.png"),
        animation = nil,
        damage = 10,
        piercing = false
    }
        -- Setting up grid and anim8
        local grid = anim8.newGrid(16, 16, this.Image:getDimensions())
        local dur = 0.1
        -- setting default animation for Ship
        this.animation = anim8.newAnimation(grid('1-2', 2), dur),
    
    setmetatable(this, self)
    return(this)
end

function Bullet:update(dt)
    self.x = self.x + self.xSpeed
    self.y = self.y + self.ySpeed
    self.animiation:update(dt)
    -- colllision detection and resolution
    -- check to see if it's offscreen or destroyed
end