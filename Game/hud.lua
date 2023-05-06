HUD = {}
HUD.__index = HUD

function HUD:Create(game, ship)
    local this = {
        game = game,
        ship = ship,
        bar = ProgressBar:Create({x=10, y=10, 40})
    }

    setmetatable(this, self)
    return(this)
end

function HUD:update(dt)
end

function HUD:draw()
    -- points
    -- lives
    -- health (if using)
    -- level number
    -- shield (duration, durability, etc)
    -- indicator for active weapon
    love.graphics.printf(self.game.points, 10, 10, self.game.width - 20, 'center')
end