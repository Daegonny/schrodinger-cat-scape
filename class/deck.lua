Class = require 'lib.class'
require('class.card')

Deck = Class{
    init = function(self)
      self.inGameCards = {}
    end
}

function Deck:suffle()
  self.inGameCards = {}
end

function putCardInGame (card)
  self.inGameCards[#self.inGameCards + 1] = card
end

function Deck:compareCards(card1, card2)
  return card1.value == card2.value and card1.suit == card2.suit
end

function Deck:randCard()
  suits = {"clubs", "diamonds", "spades", "hearts"}
  suit = suits[math.random(1, 4)]
  value = math.random(1, 13)
  return Card(value, suit)
end

function Deck:drawCard(cards)
  unique = false
  while(not unique) do
    newCard = self:randCard()
    unique = true
    if #cards > 0 then
      for k, card in pairs(cards) do
        if self:compareCards(newCard, card) then
          unique = false;
          break;
        end
      end
    end
  end
  return newCard
end
