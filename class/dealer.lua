Class = require 'lib.class'

Dealer = Class{
    init = function(self, pot, cards, smallBlind, bigBlind)
      self.pot = 0
      self.smallBlind = smallBlind
      self.bigBlind = bigBlind
    end
}
