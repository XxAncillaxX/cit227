Game = {}
Game.__index = Game

function Game:Create(width, height)
    local this = {
        points = 0,
        level_number = 0,
        lives = 3,
        width = width,
        height = height
    }
    setmetatable(this, self)
    return(this)
end

function Game:addPoints(pts)
    self.points = self.points + pts
end