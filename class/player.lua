Class = require "lib.class"
anim8 = require "lib.anim8"

Player = Class{
  init = function(self, x, y, name, directions, control_keys)
    self.x = x
    self.y = y
    self.name = name
    self.vj = 200
    self.vf = 185
    self.w = 16
    self.h = 16
    self.angle = 0
    self.directions = directions
    self.control_keys = control_keys
    --set jump and ground vars
    self.jump_limit = 0 - 2.5 * self.h
    self.fall_limit = 43 - self.h
    self.positions = {ground =  0, jump = 1, fall = 2}
    self.position_current = self.positions["ground"]
    --set animations from sprite sheet
    self:setup_sheets()
    self:setup_animations()
  end
}

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
  -- self.imgs = {}
  -- self.imgs["idle"] = love.graphics.newImage("assets/sprites/"..self.name.."_Monster_Idle_4.png")
  -- self.imgs["walk"] = love.graphics.newImage("assets/sprites/"..self.name.."_Monster_Walk_6.png")
  -- self.imgs["air"] = love.graphics.newImage("assets/sprites/"..self.name.."_Monster_Jump_8.png")
  -- self.img_current = self.imgs["idle"]
end

function Player:setup_animations()
  -- self.animations = {}
  -- self.grid_idle = anim8.newGrid(self.w, self.h, self.imgs["idle"]:getWidth(), self.imgs["idle"]:getHeight())
  -- self.grid_walk = anim8.newGrid(self.w, self.h, self.imgs["walk"]:getWidth(), self.imgs["walk"]:getHeight())
  -- self.grid_air = anim8.newGrid(self.w, self.h, self.imgs["air"]:getWidth(), self.imgs["air"]:getHeight())
  -- self.animations.idle = anim8.newAnimation(self.grid_idle('1-4',1), 0.2)
  -- self.animations.walk = anim8.newAnimation(self.grid_walk('1-6',1), 0.2)
  -- self.animations.jump = anim8.newAnimation(self.grid_air('1-4',1), 0.2, 'pauseAtEnd')
  -- self.animations.fall = anim8.newAnimation(self.grid_air('5-8',1), 0.2, 'pauseAtEnd')
  -- self.animation = self.animations.idle
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
  -- if self.position_current == self.positions["ground"] then
  --   self.img_current = self.imgs["idle"]
  --   self.animation = self.animations.idle
  -- elseif self.position_current == self.positions["jump"] then
  --   self.img_current = self.imgs["air"]
  --   self.animation = self.animations.jump
  -- elseif self.position_current == self.positions["fall"] then
  --   self.img_current = self.imgs["air"]
  --   self.animation = self.animations.fall
  -- end
end

function Player:keyreleased(key, code)
   if self.control_keys.up then
      self.position_current = self.positions["fall"]
   end
end

function Player:update(dt)
  -- self:determine_sprite()
  self:check_is_jumping(dt)
  self:check_is_falling(dt)
  self:check_is_on_ground()
  self:check_is_on_top()
  -- self.animation:update(dt)
end

function Player:draw()
  love.graphics.setColor(0, 0, 1)
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
  --self.animation:draw(self.img_current, self.x + self.img_offset, self.y, self.angle, self.dir:get_xv(), 1)
end
