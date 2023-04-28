
Map = {}
Map.__index = Map

function Map:Create(filename, ship, gameHeight)
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
        enemies = {},
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
        -- collectibles
        for i, c in ipairs(this.collectibles) do
            c:update(dt)
        end
        -- update bullets
        updateBullets(dt)
        -- update enemies
    end

    function sprite_layer:draw()
        -- draw collectibles
        for i, c in ipairs(this.collectibles) do
            c:draw()
        end
        -- draw enemies
        -- draw bullets
        for i, b in ipairs(bullets) do
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
            local c = Collectible:Create(object.x, object.y-16)
            c.points = object.properties.points
            this.world:add(c, c.x, c.y, c.w, c.h)
            table.insert(this.collectibles, c)
        elseif (object.type) == "spawnPoint" then
            -- Setting Ship Spawn point by using using the object.x and y values and saving them to the ships x and y
            this.ship.x = object.x
            this.ship.y = object.y
            -- adding the ship to the map and passing the information needed to set it in place
            this.world:add(this.ship, object.x, object.y, this.ship.w, this.ship.h)
            -- setting the ship to the map
            this.ship:setMap(this)
        end
    end
    return(this)

end

function Map:update(dt)
    self.ty = self.ty + self.scrollSpeed * dt
    self.tilemap:update(dt)
end

function Map:draw()
    love.graphics.draw(self.background)
    self.tilemap:draw(0, self.ty)
end

function updateBullets(dt)
    -- loop through the indexed pairs of a lua table
    -- very similar to loopin through a list/array by index number
    -- will eventually remove bullets here as well
    for i, b in ipairs(bullets) do
        b:update(dt)
    end
end

function Map:removeaCollectible(collectible)
    for i=#self.collectibles,1,-1 do
        local c = self.collectibles[i]
        if collectible == c then
            table.remove(self.collectibles, i)
        end
    end
end