Weapon = {}
Weapon.__index = Weapon

function Weapon:Create()
    local this ={
        cooldown = 0.15,
        timer = 0

    }
    setmetatable(this, self)
    return(this)
end

function Weapon:fire()
    -- create a bullet
    local b = Bullet:Create(ship.x, ship.y, 0, -200)
    -- add it to the bullet table directly
    table.insert(bullets, b)
    self.timer = self.cooldown
end

function Weapon:update(dt)
    self.timer = self.timer - dt
    if input:down('fire') then
        if self.timer <= 0 then
            self:fire()
            -- reset the cooldown timer
        end
    end
end