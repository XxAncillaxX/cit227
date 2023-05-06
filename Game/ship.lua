--Creating OOP class
--Creating meta table
--Defining table
Ship = {type = "ship"}
Ship.__index = Ship

--creating a new instance of the table
-- : allows Ship to refer to it's self
function Ship:Create(map)
    --Create a new local table
    -- Set up insatnce variable
    --this tells the code where to look up the code with in the Ship {}
    local this = {
        x = map.spawnPoint.x,
        y = map.spawnPoint.y,
        w = 16,
        h = 16,
        xSpeed = 0,
        ySpeed = 0,
        topSpeed = 150,
        facing = "right",
        image = love.graphics.newImage("assets/graphics/spritesheets/ship.png"),
        animations = nil,
        animation = nil,
        time = 0,
        weapon = Weapon:Create('laser', map),
        --weapon = Weapon:Create('spread', map),
        shield = nil,
        map = map
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
        this.map:addShip(this)
    -- Make this an object and return it
    setmetatable(this, self)
    return(this)
end

function shipFilter(ship, other)
    if (other.type == "collectible") then
        return("cross")
    elseif (other.type == "obstacle") then
        return("touch")
    else
        return("slide")
    end
end


function Ship:update(dt)
    self.time = self.time + dt
    self:handleInput(dt)
    self.weapon:update(dt)
    self.animation:update(dt)
    --self.x = self.x + (self.xSpeed * dt)
    --self.y = self.y + (self.ySpeed * dt)
    -- Update ship's coordinates with collison detection
    local goalX = self.x + (self.xSpeed * dt)
    local goalY = self.y + (self.ySpeed * dt)
    -- Refrence to self.map.world to keep following code less wordy
    local world = self.map.world
    local actualX, actualY, cols, len = world:move(self, goalX, goalY, shipFilter)
    self.x = actualX
    self.y = actualY
    if len > 0 then -- if there were any
        -- for each collision in the collision table
        for i, c in ipairs(cols) do
            -- if we collided with a colletible
            if c.other.type == "collectible" then 
                -- add point total
                -- do the thing the collectible does
                if c.other.collectibleType == "weapon" then
                    ship.weapon = Weapon:Create(c.other.params, self.map)
                end
                -- play a sound
                Sounds.collectible:play()
                -- remove it (collision world, AND the map)
                world:remove(c.other)
                self.map:removeaCollectible(c.other)
                game:addPoints(c.other.points)
            elseif c.other.type =="bullet" then
                -- if the bullet is an enemy bullet
                -- if shield is actie, take damage
                -- otherwise ship takes damage
            elseif c.other.type == "enemy" then
                -- if shield is actie, take damage
                -- otherwise ship takes damage
            elseif c.other.type == "obstacle" then
                -- if shield is actie, take damage
                -- otherwise ship takes damage
                world:remove()
            end
        end
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
    -- handling ships x movement
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
    -- handling ships y movement
    if input:down('up') then
        --self:move('up')
        self.ySpeed = -self.topSpeed
    elseif input:down('down') then
        --self:move('down')
        self.ySpeed = self.topSpeed
    else
        --enable to have ship stay still on map when scrolling is on
        self.ySpeed = -self.map.scrollSpeed
        --enable to have ship stay still on map when scholling is off
        --self.ySpeed = 0
    end

    -- handling ships fire
    if input:down('fire') then
        self.weapon:trigger()
    end

    --handle shield input (if necessary)
    -- not if it activate upon collection
    -- check 'pressed' if it's an activate/deactivate toggle
    -- check 'down' if it's enabled only when held down
    -- check 'up' to deactivate
    if input:pressed('shield') then
        
    end

end

function Ship:draw()
    self.animation:draw(self.image, self.x, self.y)
end
