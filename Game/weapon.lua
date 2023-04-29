weaponTypes = {
    laser = {
        bulletType = "laser",
        cooldown = 0.3
    },
    spread = {
        bulletType = "spread",
        cooldown = 0.5
    },
    super = {
        bulletType = "beam",
        charge = 0
    },
    plasma = {
        bulletType = "plasma",
        cooldown = 0.8
    }
}

Weapon = {}
Weapon.__index = Weapon

function Weapon:Create(type, map)
    local def = weaponTypes[type]
    local this ={
        cooldown = def.cooldown,
        bulletType = def.bulletType,
        timer = 0,
        map = map
        --weapon_type = "bullet"
    }
    setmetatable(this, self)
    return(this)
end
--[[
function Weapon:swapBullet()
    if (self.weapon_type == "bullet") then
        self.weapon_type = "machine gun"
    elseif (self.weapon_type == "machine gun") then
        self.weapon_type = "bullet"
    end
end
]]

function Weapon:fire()
    if self.bulletType == "laser" then
        self:fireLaser()
    elseif self.bulletType == "spread" then
        self:fireSpread()
    elseif self.bulletType == "plasma" then
        self:firePlasma()
    end
end

function Weapon:firePlasma()
end

function Weapon:fireSpread()
    local b1 = Bullet:Create('spread', ship.x, ship.y, 0, -200)
    local b2 = Bullet:Create('spread', ship.x, ship.y, -35, -200)
    local b3 = Bullet:Create('spread', ship.x, ship.y, 35, -200)
    table.insert(self.map.bullets, b1)
    table.insert(self.map.bullets, b2)
    table.insert(self.map.bullets, b3)
    self.timer = self.cooldown
    Sounds.laser:play()
end

function Weapon:fireLaser()
        local b = Bullet:Create('laser', ship.x, ship.y, 0, -200)
        -- add it to the bullet table directly
        table.insert(self.map.bullets, b)
        self.timer = self.cooldown
end

function Weapon:update(dt)
    self.timer = self.timer - dt
    if input:pressed('swap') then
        self:swapBullet()
    end
    if input:down('fire') then
        if self.timer <= 0 then
            self:fire()
            Sounds.laser:play()
            -- reset the cooldown timer
        end
    end
end
