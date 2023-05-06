
backgroundUpdate = {
    background1 = "assets/graphics/backgrounds/parallax-space-background2.png",
    background2 = "assets/graphics/backgrounds/space-background.png"
}


Map = {}
Map.__index = Map

function Map:Create(filename, gameHeight)
    local map = sti('assets/maps/' .. filename)
    
    local this = {
        tilemap = map,
        pixelWidth = map.width * map.tilewidth,
        pixelHeight = map.height * map.tileheight,
        tileWidth = map.tilewidth,
        tileHeight = map.tileheight,
        ty = gameHeight - (map.height * map.tileheight),
        world = bump.newWorld(),
        ship = ship,
        spawnPoint = {},
        enemies = {},
        obstacles = {},
        bullets = {},
        enemyBullets = {},
        collectibles = {},
        music = map.music,
        scrollSpeed = 30,
        background = love.graphics.newImage("assets/graphics/backgrounds/parallax-space-background2.png")
    }
    --print(map.ty)
    setmetatable(this, self)

    -- reference to sprite layer
    local sprite_layer = this.tilemap.layers['sprite_layer']

    function sprite_layer:update(dt)
        -- update ship
        this.ship:update(dt)
        -- objects/hazards
        for i, o in ipairs(this.obstacles) do
            o:update(dt)
        end
        -- collectibles
        for i, c in ipairs(this.collectibles) do
            c:update(dt)
        end
        -- update bullets
        for i=#this.bullets, 1, -1 do
            local b = this.bullets[i]
            b:update(dt)
            if b:needsRemoved(this.ty) then
                table.remove(this.bullets,i)
            end
        end
        -- update enemies
        for i=#this.enemies, 1, -1 do
            local e = this.enemies[i]
            e:update(dt)
            --if e:needsRemoved(this.ty) then
                --table.remove(this.enemies,i)
            --end
        end
    end

    function sprite_layer:draw()
        -- draw collectibles
        for i, c in ipairs(this.collectibles) do
            c:draw()
        end
        -- draw enemies
        for i, e in ipairs(this.enemies) do
            e:draw()
        end

        -- draw obstacles
        for i, o in ipairs(this.obstacles) do
            o:draw()
        end

        -- draw bullets
        for i, b in ipairs(this.bullets) do
            b:draw()
        end
        -- draw ship
        this.ship:draw()
    end

    -- ipairs => indexed pairs in a non key/value table (traditional array)
    -- pair => for key/value pairs
    -- to hide the objects layer on the map unless there being looped through in the following code
    this.tilemap.layers['objects'].visible = false
    for k, object in pairs(this.tilemap.layers[2].objects) do
        --log.trace(inspect(object.type))
        if (object.type == "collectible") then
            -- insert collectible
            -- local is only specific to this code block!
            local c = Collectible:Create(object)
            c.points = object.properties.points
            this.world:add(c, c.x, c.y, c.w, c.h)
            table.insert(this.collectibles, c)
        elseif (object.type) == "spawnPoint" then
            -- Setting Ship Spawn point by using using the object.x and y values and saving them to the ships x and y
            this.spawnPoint.x = object.x
            this.spawnPoint.y = object.y
            -- adding the ship to the map and passing the information needed to set it in place
            --this.world:add(this.ship, object.x, object.y, this.ship.w, this.ship.h)
        elseif (object.type) == "enemy" then
            local e = Enemy:Create(object)
            table.insert(this.enemies, e)

        elseif(object.type) == "obstacle" then
            local o = Obstacle:Create(object)
            this.world:add(o, o.x, o.y, o.w, o.h)
            table.insert(this.obstacles, o)
        end
    end
    return(this)

end

function Map:addShip(ship)
    self.ship = ship
    self.world:add(self.ship, ship.x, ship.y, self.ship.w, self.ship.h)
end

function Map:update(dt)
    if self.ty < 0 then
        self.ty = self.ty + self.scrollSpeed * dt
    end
    self.tilemap:update(dt)
end

function Map:draw()
    love.graphics.draw(self.background)
    self.tilemap:draw(0, self.ty)
end
--[[
function updateBullets(dt)
    -- loop through the indexed pairs of a lua table
    -- very similar to loopin through a list/array by index number
    -- will eventually remove bullets here as well
    for i, b in ipairs(bullets) do
        b:update(dt)
    end
end
]]
function Map:removeaCollectible(collectible)
    for i=#self.collectibles,1,-1 do
        local c = self.collectibles[i]
        if collectible == c then
            table.remove(self.collectibles, i)
        end
    end
end