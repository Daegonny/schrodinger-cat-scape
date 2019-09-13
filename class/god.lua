Class = require "lib.class"

God = Class{
  init = function(self)
  end
}

function God:isCollingd1D(aMin, aMax, bMin, bMax)
  return aMax >= bMin and aMin <= bMax
end

function God:isCollidingBoxes (box1, box2)
  isCollidingX = self:isCollingd1D(box1:getX(), box1:getX()+box1:getW() ,box2:getX(), box2:getX()+box2:getW())
  isCollidingY = self:isCollingd1D(box1:getY(), box1:getY()+box1:getH() ,box2:getY(), box2:getY()+box2:getH())
  return isCollidingX and isCollidingY
end

function God:updateObstacles(obstacles, background, dt)
  numObstacles = #obstacles
  levelCounter = 0
  for k, obstacle in pairs(obstacles) do
      obstacle:update(dt)
      levelCounter = levelCounter + obstacle:getLevel()
  end
  if levelCounter == numObstacles then
    for k, obstacle in pairs(obstacles) do
        obstacle:setLevel(0)
        obstacle:increaseVm()
        background:increaseVm()
    end
  end
end

function God:drawObstacles(obstacles)
  for k, obstacle in ipairs(obstacles) do
      obstacle:draw()
  end
end

function God:isPlayerAlive(player, obstacles)
  if not player.isGhost then
    for k, obstacle in ipairs(obstacles) do
      if self:isCollidingBoxes(player, obstacle) then
        return false
      end
    end
  end
  return true
end
