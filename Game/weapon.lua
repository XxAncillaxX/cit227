Weapon = {}
Weapon.__index = Weapon

function Weapon:Create()
    local this ={
        cooldown = 0.15,
        timer = 0,
        weapon_type = "bullet"
    }
    setmetatable(this, self)
    return(this)
end

function Weapon:swapBullet()
    if (self.weapon_type == "bullet") then
        self.weapon_type = "machine gun"
    elseif (self.weapon_type == "machine gun") then
        self.weapon_type = "bullet"
    end
end
function Weapon:fire()
    -- swap bullet type
    if (self.weapon_type == "bullet") then
        -- create a bullet
        self.cooldown = 0.15
        local b = Bullet:Create(ship.x, ship.y, 0, -200, 10)
        -- add it to the bullet table directly
        table.insert(bullets, b)
        self.timer = self.cooldown
    end
    if (self.weapon_type == "machine gun") then
        -- create a bullet
        self.cooldown = 0.08
        
        local b = Bullet:Create(ship.x-8, ship.y, 0, -200, 5)
        -- add it to the bullet table directly
        table.insert(bullets, b)
        self.timer = self.cooldown

        local b2 = Bullet:Create(ship.x+7, ship.y, 0, -200, 5)
        -- add it to the bullet table directly
        table.insert(bullets, b2)
        self.timer = self.cooldown
    end
end

function Weapon:update(dt)
    self.timer = self.timer - dt
    if input:pressed('swap') then
        self:swapBullet()
    end
    if input:down('fire') then
        if self.timer <= 0 then
            self:fire()
            -- reset the cooldown timer
        end
    end
end