
Class = require 'lib.class'

Direction = Class{
  init = function(self, name, xv, yv)
    self.name = name
    self.xv = xv
    self.yv = yv
  end
}

function Direction:get_name()
  return self.name
end

function Direction:get_xv()
  return self.xv
end

function Direction:get_yv()
  return self.yv
end
