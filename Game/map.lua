 Map = {}
 Map.__index = Map

 function Map:Create(filename, ship)
    local map = sti('assets/maps/level1.lua')
    
    local this = {
        ship = ship,
        enemies = {},
        bullets = {},
        enemyBullets = {},
        collectibles = {}
        
    }
end