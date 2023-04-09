
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
        -- update bullets
        updateBullets(dt)
        -- update enemies
    end

    function sprite_layer:draw()
        -- draw collectibles
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
    for k, object in pairs(this.tilemap.layers[2].objects) do
        --log.trace(inspect(object.type))
        if (object.type == "collectible") then
            -- insert collectible
        elseif (object.type) == "spawnPoint" then
            this.ship.x = object.x
            this.ship.y = object.y
        end
    end
    return(this)

end

function Map:update(dt)
    --self.ty = self.ty + self.scrollSpeed * dt
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
