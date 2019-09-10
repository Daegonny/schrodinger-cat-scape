Class = require "lib.class"
anim8 = require "lib.anim8"

Obstacle = Class{
  init = function(self)
    self.x = 720  + self:randomizeX()
    self.y = 29
    self.vm = 150
    self.w = 20
    self.h = 25
    self:randomizeX()
  end
}

function Obstacle:randomizeX()
  return math.random(0, 9)*125
end
function Obstacle:getX()
  return self.x
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


function Obstacle:determineObstacle()

end

function Obstacle:checkBound()
  if self.x < 0 - self.w then
      self.x = 720 + self:randomizeX()
      self.vm = self.vm + 25
  end
end

function Obstacle:move(dt)
  --ALWAYS left
  self.x = self.x - (self.vm * dt)
end

function Obstacle:update(dt)
  self:move(dt)
  self:checkBound()
  --move
end

function Obstacle:draw()
  love.graphics.setColor(1, 0, 0)
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end
