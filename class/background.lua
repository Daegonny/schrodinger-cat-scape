Class = require 'lib.class'

Background = Class{
    init = function(self, x, y, img_path)
      self.x = x
      self.y = y
      self.img = love.graphics.newImage(img_path)
    end
}

function Background:draw()
  love.graphics.draw(self.img, self.x, self.y)
end
