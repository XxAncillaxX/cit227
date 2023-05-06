HUD = {}
HUD.__index = HUD

pgBarParams = {
    x = 10,
    y = 10,
    w = 40,
    h = 10,
    borderSize = 1,
    cornerRadius = 2,
    fgColor = {0.5, 0.5, 0.9}
}

function HUD:Create(game, ship, map)
    local this = {
        game = game,
        ship = ship,
        map = map,
        bar = ProgressBar:Create(pgBarParams)
    }

    setmetatable(this, self)
    return(this)
end

function HUD:update(dt)
    self.bar:update(dt)
end

function HUD:draw()
    -- points
    -- lives
    -- health (if using)
    -- level number
    -- shield (duration, durability, etc)
    -- indicator for active weapon
    self.bar:draw()
    love.graphics.print(#self.map.bullets, 10, 30)
    --love.graphics.print(self.ship.shield, 10, 60)
    love.graphics.printf(self.game.points, 10, 10, self.game.width - 20, 'center')
end