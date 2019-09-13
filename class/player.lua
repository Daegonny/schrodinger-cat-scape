Class = require "lib.class"
anim8 = require "lib.anim8"

Player = Class{
  init = function(self, x, y, name, directions, control_keys)
    self.x = x
    self.y = y
    self.name = name
    self.vj = 200
    self.vf = 200
    self.w = 16
    self.h = 25
    self.score = 0
    self.angle = 0
    self.isGhost = false
    self.maxGhostPoints = 60
    self.ghostPoints = 0
    self.directions = directions
    self.control_keys = control_keys
    --set jump and ground vars
    self.jump_limit = 0 - 2 * self.h
    self.fall_limit = y
    self.positions = {ground =  0, jump = 1, fall = 2}
    self.position_current = self.positions["ground"]
    --set animations from sprite sheet
    self:setup_sheets()
    self:setup_animations()
  end
}

function Player:getScore()
  return self.score
end

function Player:setScore(score)
  self.score = score
end


function Player:getX()
  return self.x
end

function Player:getY()
  return self.y
end

function Player:getW()
  return self.w
end

function Player:getH()
  return self.h
end

function Player:setup_sheets()
  self.imgs = {}
  self.imgs["run"] = love.graphics.newImage("assets/img/cat-run.png")
  self.imgs["run-ghost"] = love.graphics.newImage("assets/img/cat-run-ghost.png")
  self.imgs["jump"] = love.graphics.newImage("assets/img/cat-jump.png")
  self.imgs["jump-ghost"] = love.graphics.newImage("assets/img/cat-jump-ghost.png")
  self.img_current = self.imgs["run"]
end

function Player:setup_animations()
  self.animations = {}
  self.grid = anim8.newGrid(self.w, self.h, self.imgs["run"]:getWidth(), self.imgs["run"]:getHeight())
  self.animations.run = anim8.newAnimation(self.grid('1-8',1), 0.1)
  self.animations.jump = anim8.newAnimation(self.grid('1-8',1), 0.05)
  self.animation = self.animations.run
end

function Player:can_jump()
  --if is on ground or above the height limit
  if self.y >= self.jump_limit and self.position_current == self.positions["jump"] then
    return true
  else
    return false
  end
end

function Player:can_fall()
  --if is on ground or above the height limit
  if self.position_current == self.positions["fall"] then
    return true
  else
    return false
  end
end

function Player:jump(dir, dt)
  if self:can_jump() then
    self.y = self.y + (self.vj * dir:get_yv() * dt)
  end
end

function Player:fall(dir, dt)
  if self:can_fall() then
    self.y = self.y + (self.vf * dir:get_yv() * dt)
  end
end

function Player:check_is_jumping(dt)
  if  self.position_current ~= self.positions["fall"] and love.keyboard.isDown(self.control_keys.up) then
    self.position_current = self.positions["jump"]
    self:jump(self.directions.up, dt)
  end
end

function Player:check_is_falling(dt)
  if  self.position_current == self.positions["fall"] then
    self:fall(self.directions.down, dt)
  end
end

function Player:check_is_on_ground()
  if self.position_current == self.positions["fall"] and self.y >= self.fall_limit then
    self.position_current = self.positions["ground"]
    self.y = self.fall_limit
  end
end

function Player:check_is_on_top()
  if self.position_current == self.positions["jump"] and self.y <= self.jump_limit then
    self.position_current = self.positions["fall"]
  end
end

function Player:determine_sprite()
  trick = ""
  if self.isGhost then
    trick ="-ghost"
  else
    trick = ""
  end

  if self.position_current == self.positions["ground"] then
    self.img_current = self.imgs["run"..trick]
    self.animation = self.animations.run
  else
    self.img_current = self.imgs["jump"..trick]
    self.animation = self.animations.jump
  end
end

function Player:keyreleased(key, code)
   if key == self.control_keys.up then
      self.position_current = self.positions["fall"]
   end
   if key == self.control_keys.ghost and self:canBeGhost() then
      self.isGhost = true
   end
end

function Player:canBeGhost()
  return self.ghostPoints >= 5
end

function Player:handleGhost(dt)
  if self.isGhost then
    self.ghostPoints = self.ghostPoints - 5*dt
    if self.ghostPoints <= 0 then
      self.isGhost = false
      self.ghostPoints = 0
    end
  elseif self.ghostPoints < self.maxGhostPoints then
    self.ghostPoints = self.ghostPoints + 5*dt
  end
end

function Player:update(dt)
  self:determine_sprite()
  self:check_is_jumping(dt)
  self:check_is_falling(dt)
  self:check_is_on_ground()
  self:check_is_on_top()
  self:setScore(self:getScore()+5*dt)
  self:handleGhost(dt)
  self.animation:update(dt)
end

function Player:drawPoints()
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("Score: "..math.floor(self.score), 30, 7)
  --love.graphics.print(math.floor(self.ghostPoints), 650,0)
  love.graphics.rectangle("line", 630, 7, self.maxGhostPoints, 12)
  love.graphics.setColor(0, 1, 0)
  love.graphics.rectangle("fill", 630, 8, math.floor(self.ghostPoints), 10)
  love.graphics.setColor(1, 1, 1)
end

function Player:draw()
  -- love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
  self.animation:draw(self.img_current, self.x, self.y)
  self:drawPoints()
end
