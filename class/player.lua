Class = require 'lib.class'

Player = Class{
    init = function(self, money, cards)
      self.money = money
      self.cards = cards
    end
}

function Player:getCards ()
  return self.cards
end
