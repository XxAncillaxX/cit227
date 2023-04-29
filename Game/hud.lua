HUD = {}
HUD.__index = HUD

function HUD:Create(game, ship)
    local this = {
        game = game,
        ship = ship
    }

    setmetatable(this, self)
    return(this)
end

function HUD:update(dt)
end

function HUD:draw()
    love.graphics.printf(self.game.points, 10, 10, self.game.width - 20, 'center')
end