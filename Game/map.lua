
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
    print(map.ty)
    setmetatable(this, self)
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