
require('libs/tween')

ProgressBar = {}
ProgressBar.__index = ProgressBar

-- width = math.min(actor.hp, 150)

function ProgressBar:Create(params)
  local this = {
    x = params.x,
    y = params.y,
    w = params.w,
    h = params.h or 20,
    imageName = params.imageName,
    image = nil,
    animate = params.animate,
    borderSize = params.borderSize or 2,
    borderColor = params.borderColor or {1, 1, 1},
    bgColor = params.bgColor or {0.9, 0, 0},
    fgColor = params.fgColor or {1, 0.8, 0},
    maxVal = params.maxVal or 10,
    value = params.value or params.maxVal or 10,
    tween = nil,
    tweenDuration = params.animDuration or 0.55,
    cornerRadius = params.cornerRadius or 0
  }

  if params.animate == nil then
    params.animate = true
  end

  if params.imageName then
    this.image = love.graphics.newImage(params.imageName)
    this.image:setFilter("nearest", "nearest")
    this.bg = love.graphics.newQuad(1, 1, 1, 8, this.image:getDimensions())
    this.fg = {}
    this.fg[1] = love.graphics.newQuad(3, 1, 1, 8, this.image:getDimensions())
    this.left = love.graphics.newQuad(5, 1, 2, 8, this.image:getDimensions())
    this.center = love.graphics.newQuad(8, 1, 1, 8, this.image:getDimensions())
    this.right = love.graphics.newQuad(10, 1, 2, 8, this.image:getDimensions())
    this.fg[2] = love.graphics.newQuad(13, 1, 1, 8, this.image:getDimensions())
    this.fg[3] = love.graphics.newQuad(15, 1, 1, 8, this.image:getDimensions())
    this.fg[4] = love.graphics.newQuad(17, 1, 1, 8, this.image:getDimensions())
    this.canvas = love.graphics.newCanvas(this.w+2, 8)
  end


  this.tween = Tween:Create(this.value, this.value, 0)

  setmetatable(this, self)
  return(this)
end

function ProgressBar:update(dt)
    self.tween:Update(dt)
end

function ProgressBar:draw()
  if self.image then
    self:imageDraw()
  else
    self:rectDraw()
  end
end

function ProgressBar:drawImageBar(index, size)
  local len = size or self.w
  if index > 0 then
    love.graphics.draw(self.image, self.fg[index], self.x+1, self.y+0, 0, len, 1)
  end
end

function ProgressBar:imageDraw()
  -- draw bg
  --love.graphics.setCanvas(self.canvas)
    love.graphics.draw(self.image, self.bg, self.x+1, self.y+0, 0, self.w, 1)
    -- draw fg
    if self.tween:Value() > 0 then
      --local barWidth = self.w
      --local ratio = barWidth / self.maxVal
      --local fgWidth = self.tween:Value() * ratio
      --local scale = barWidth / fgWidth
      local fullBars = math.floor(self.tween:Value() / self.w)
      local partialSize = self.tween:Value() % self.w
      for i=1, fullBars do
        self:drawImageBar(i)
      end
      if partialSize > 0 then
        self:drawImageBar(fullBars+1, partialSize)
      end
      --love.graphics.draw(self.image, self.fg, 1, 0, 0, fgWidth, 1)

    end
    -- draw border
    love.graphics.draw(self.image, self.left, self.x+0, self.y+0)
    love.graphics.draw(self.image, self.center, self.x+2, self.y+0, 0, self.w-2, 1)
    love.graphics.draw(self.image, self.right, self.x+self.w, self.y+0)
  --love.graphics.setCanvas()
  --love.graphics.draw(self.canvas, self.x, self.y, 0, 2, 2)
end


function ProgressBar:getImage()
  -- draw bg
  love.graphics.setCanvas(self.canvas)
    love.graphics.draw(self.image, self.bg, 1, 0, 0, self.w, 1)
    -- draw fg
    if self.tween:Value() > 0 then
      --local barWidth = self.w
      --local ratio = barWidth / self.maxVal
      --local fgWidth = self.tween:Value() * ratio
      --local scale = barWidth / fgWidth
      local fullBars = math.floor(self.tween:Value() / self.w)
      local partialSize = self.tween:Value() % self.w
      for i=1, fullBars do
        self:drawImageBar(i)
      end
      if partialSize > 0 then
        self:drawImageBar(fullBars+1, partialSize)
      end
      --love.graphics.draw(self.image, self.fg, 1, 0, 0, fgWidth, 1)

    end
    -- draw border
    love.graphics.draw(self.image, self.left, 0, 0)
    love.graphics.draw(self.image, self.center, 2, 0, 0, self.w-2, 1)
    love.graphics.draw(self.image, self.right, self.w, 0)
  love.graphics.setCanvas()
  return(self.canvas)
end

function ProgressBar:rectDraw()
  local r,g,b,a = love.graphics.getColor()
  love.graphics.setColor(self.borderColor)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, self.cornerRadius, self.cornerRadius)

  love.graphics.setColor(self.bgColor)
    love.graphics.rectangle("fill", self.x + self.borderSize, self.y + self.borderSize, self.w - self.borderSize * 2, self.h - self.borderSize * 2, self.cornerRadius, self.cornerRadius)

    if self.tween:Value() > 0 then
      local barWidth = self.w - self.borderSize * 2
      local ratio = barWidth / self.maxVal
      local value = self.value
      if self.animate then
        log.trace("using Tween value")
        value = self.tween:Value()
      end
      local fgWidth = value * ratio
      local scale = barWidth / fgWidth

      love.graphics.setColor(self.fgColor)
      love.graphics.rectangle("fill", self.x + self.borderSize, self.y + self.borderSize, fgWidth, self.h - self.borderSize * 2, self.cornerRadius, self.cornerRadius)
    end
  love.graphics.setColor(r, g, b, a)
end

function ProgressBar:setValue(value)
  self.value = math.min(self.maxVal, value)
end

function ProgressBar:getValue()
  return(self.value)
end

function ProgressBar:decreaseValue(delta)
  local oldVal = self.value
  self.value = math.max(0, self.value - delta)
  if self.animate and oldVal ~= self.value then
    self.tween = Tween:Create(oldVal, self.value, self.tweenDuration, Tween.EaseOutElastic)
  end
end

function ProgressBar:increaseValue(delta)
  local oldVal = self.value
  self.value = math.min(self.maxVal, self.value + delta)
  if self.animate and oldVal ~= self.value then
    self.tween = Tween:Create(oldVal, self.value, self.tweenDuration, Tween.EaseOutCirc)
  end
end

function ProgressBar:keypressed(key)
   if key == 'left' then
      self:decreaseValue(50)
   elseif key == 'right' then
      self:increaseValue(50)
   elseif key == 'down' then
      self:decreaseValue(75)
   elseif key == 'up' then
      self:increaseValue(75)
   end
end
