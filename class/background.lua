Class = require 'lib.class'

Background = Class{
    init = function(self, x, y,imgPath)
      self.x = 0
      self.y = 0
      self.vm = 250
      self.img = love.graphics.newImage(imgPath)
    end
}

function Background:reset()
  self.x = 0
  self.y = 0
  self.vm = 250
end

function Background:increaseVm()
  self.vm = self.vm + 5
end

function Background:setImg(imgPath)
  self.img = love.graphics.newImage(imgPath)
end

function Background:update(dt)
  if self.x <= (self.vm*dt -720) then
    self.x = 0
  else
    self.x = self.x - self.vm*dt
  end
end

function Background:draw()
  love.graphics.draw(self.img, self.x, self.y)
  -- love.graphics.print(self.vm , 0, self.y)
end
