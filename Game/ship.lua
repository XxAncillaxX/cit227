--Creating OOP class
--Creating meta table
--Defining table
Ship = {type = "ship"}
Ship.__index = Ship

--creating a new instance of the table
-- : allows Ship to refer to it's self
function Ship:Create()
    --Create a new local table
    -- Set up insatnce variable
    --this tells the code where to look up the code with in the Ship {}
    local this = {
        x = 0,
        y = 80,
        w = 16,
        h = 16,
        xSpeed = 0,
        ySpeed = 0,
        topSpeed = 100,
        facing = "right",
        image = love.graphics.newImage("assets/graphics/spritesheets/ship.png"),
        animations = nil,
        animation = nil,
        time = 0,
        weapon = Weapon:Create(0.1),
        map = nil
    }

    -- Setting up grid and anim8
    local grid = anim8.newGrid(16, 24, this.image:getDimensions())
    local dur = 0.1
    -- adding animations table to Ship
    this.animations = {
            -- grid(4, '1-3') example using column instead of row
            -- current grids use row method

            farLeft = anim8.newAnimation(grid(1, '1-2'), dur),
            left = anim8.newAnimation(grid(2, '1-2'), dur),
            still = anim8.newAnimation(grid(3, '1-2'), dur),
            right = anim8.newAnimation(grid(4, '1-2'), dur),
            farRight = anim8.newAnimation(grid(5, '1-2'), dur)
        }
        -- setting default animation for Ship
        this.animation = this.animations.still

    -- Make this an object and return it
    setmetatable(this, self)
    return(this)
end

function Ship:setMap(m)
    self.map = m
end

function shipFilter(ship, other)
    if (other.type == "collectible") then
        return("cross")
    else
        return("slide")
    end
end


function Ship:update(dt)
    self.time = self.time + dt
    self:handleInput(dt)
    self.weapon:update(dt)
    self.animation:update(dt)
    self.x = self.x + (self.xSpeed * dt)
    self.y = self.y + (self.ySpeed * dt)
    local goalX = self.x + (self.xSpeed * dt)
    local goalY = self.y + (self.ySpeed * dt)
    -- Refrence to self.map.world to keep following code less wordy
    local world = self.map.world
    local actualX, actualY, cols, len = world:move(self, goalX, goalY, shipFilter)
    self.x = actualX
    self.y = actualY
    if len > 0 then
        -- if we collided with a colletible
        -- remove it
        log.trace("COLLISIONS")
    end
end

function Ship:clamp(val)
    local min = 1.00
    local max = 250.00
    if (val >= max) then
        return max
    elseif (val <= min) then
        return min
    else
        return (val)
    end
end

function Ship:handleInput(dt)
    if input:down('right') then
        --self:move('right')
        self.xSpeed = self.topSpeed
        self.animation = self.animations.farRight
        self.x = self:clamp(self.x)
    elseif input:down('left') then
        --self:move('left')
        self.xSpeed = -self.topSpeed
        self.animation = self.animations.farLeft
        self.x = self:clamp(self.x)
    else
        self.xSpeed = 0
        self.animation = self.animations.still
    end--if

    if input:down('up') then
        --self:move('up')
        self.ySpeed = -self.topSpeed
    elseif input:down('down') then
        --self:move('down')
        self.ySpeed = self.topSpeed
    else
        self.ySpeed = 0
    end
end

function Ship:draw()
    self.animation:draw(self.image, self.x, self.y)
end
