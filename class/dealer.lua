Class = require 'lib.class'

Dealer = Class{
    init = function(self, cards, smallBlind, bigBlind)
      self.pot = 0
      self.cards = cards
      self.smallBlind = smallBlind
      self.bigBlind = bigBlind
    end
}

function Dealer:showCards (n)
  for i=1, n, 1 do
    print(self.cards[i].value.." "..self.cards[i].suit)
  end
end

function Dealer:getCards()
  return self.cards
end
