Class = require "lib.class"
anim8 = require "lib.anim8"

Obstacle = Class{
  init = function(self)
    self.x = 720
    self.y = 28
    self.vm = 250
    self.w = 16
    self.h = 16
    self.level = 0
    self.img = love.graphics.newImage("assets/img/pickle.png")
  end
}

function Obstacle:getX()
  return self.x
end

function Obstacle:getLevel()
  return self.level
end

function Obstacle:setLevel(level)
  self.level = level
end

function Obstacle:getY()
  return self.y
end

function Obstacle:getW()
  return self.w
end

function Obstacle:getH()
  return self.h
end

function Obstacle:increaseVm()
  self.vm = self.vm + 5
end

function Obstacle:checkBound(dt)
  if self.x <= (0 - (self.w + self.vm * dt)) then
      self.x = 720
      self.level = 1
  end
end

function Obstacle:move(dt)
  --ALWAYS left
  self.x = self.x - (self.vm * dt)
end

function Obstacle:update(dt)
  self:move(dt)
  self:checkBound(dt)
end

function Obstacle:draw()
  -- love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
  love.graphics.draw(self.img, self.x, self.y)
  -- love.graphics.print(self.vm , self.x,self.y-20)
end
