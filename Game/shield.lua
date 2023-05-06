Shield = {}
Shield.__index = Shield

function Shield:Create()
    local this = {
        -- use either duration or durability, not both
        duration = 5, -- starting value
        durabilty = 10, -- ten hits starting value
        image = nil,
        reflection = false, -- whether or not to reflect fire
    }

    setmetatable(this, self)
    return(this)
end


function Shield:activate()
end

function Shield:deactivate()
end

-- if using a durability style shield
function Shield:takeDamage(points)
end

function Shield:update(dt)
end

function Shield:draw()
    -- only when activated
end
