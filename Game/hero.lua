--Creating OOP class
--Creating meta table
--Defining table
Hero = {}
Hero.__index = Hero

--creating a new instance of the table
-- : allows Hero to refer to it's self
function Hero:Create()
    --Create a new local table
    -- Set up insatnce variable
    --this tells the code where to look up the code with in the Hero {}
    local this = {
        x = 0,
        y = 80,
        y_offSet = 0,
        w = 0,
        h = 0,
        speed = 0,
        topSpeed = 100,
        facing = "right",
        Image = love.graphics.newImage("assets/graphics/hero.png"),
        animations = nil,
        animation = nil,
        time = 0
    }

    -- Setting up grid and anim8
    local grid = anim8.newGrid(16, 16, this.Image:getDimensions())
    -- adding animations table to hero
    this.animations = {
            -- grid(4, '1-3') example using column instead of row
            -- current grids use row method
            walk = anim8.newAnimation(grid('1-6', 2), 0.1),
            idle = anim8.newAnimation(grid('1-3', 1), 0.3),
            swim = anim8.newAnimation(grid('1-6', 4), 0.25),
            attack = anim8.newAnimation(grid('1-3', 5), 100.00)
        }
        -- setting default animation for hero
        this.animation = this.animations.walk

    -- Make this an object and return it
    setmetatable(this, self)
    return(this)
end

function Hero:update(dt)
    self.time = self.time + dt
    self:handleInput(dt)
    self.animation:update(dt)
    self.x = self.x + (self.speed * dt)
    self.y_offSet = 60 * math.sin(self.time * 3)
end

function Hero:handleInput(dt)
    if input:down('right') then
        self:move('right')
    elseif input:down('left') then
        self:move('left')
    elseif input:down('up') then
        self:move('up')
    elseif input:pressed('action') then
        self.animation = self.animations.attack
    else
        self.speed = 0
        self.animation = self.animations.idle
    end--if
end

function Hero:move(dir)
    self.speed = self.topSpeed
    if (dir == "left") then
        self.speed = -self.speed
    end
    self.animation = self.animations.walk
    if (self.facing ~= dir) then
        self.animation:flipH()
        self.animations.idle:flipH()
        self.facing = dir
    end-- end hero.facing if
end

function Hero:draw()
    self.animation:draw(self.Image, self.x, self.y+self.y_offSet, 0, 3, 3)
end