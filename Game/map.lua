
Map = {}
Map.__index = Map

function Map:Create(filename, ship)
    local map = sti('assets/maps/' .. filename)
    
    local this = {
        tilemap = map,
        pixelWidth = map.width,
        pixelHeight = map.height,
        tileWidth = map.tilewidth,
        tileHeight = map.tileHeight,
        ship = ship,
        enemies = {},
        bullets = {},
        enemyBullets = {},
        collectibles = {},
        music = map.music
    }

    setmetatable(this, self)
    return(this)

end

function Map:update(dt)
    self.tilemap:update(dt)
end

function Map:draw()
    self.tilemap:draw()
end