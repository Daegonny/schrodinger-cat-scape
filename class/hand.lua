Class = require 'lib.class'

Hand = Class{
    init = function(self, cards, ranking)
      self.cards = cards
      self.ranking = ranking
      self.points = 0
      self:computePoints()
    end
}

function Hand:getCards()
  return self.cards
end

function Hand:getRanking()
  return self.ranking
end

function Hand:getPoints()
  return self.points
end

function Hand:computePoints ()
  p = 0
  for _, card in pairs(self.cards) do
    p = p + card.value
  end
  self.points = p
end

function Hand:getName()
 name = ""
 if self.ranking == 1 then
   name = 'Straight Flush'
 elseif self.ranking == 2 then
   name = 'Four of a Kind'
 elseif self.ranking == 3 then
   name = 'Full House'
 elseif self.ranking == 4 then
   name = 'Flush'
 elseif self.ranking == 5 then
   name = 'Straight'
 elseif self.ranking == 6 then
   name = 'Three of a Kind'
 elseif self.ranking == 7 then
   name = 'Two Pair'
 elseif self.ranking == 8 then
   name = 'One Pair'
 elseif self.ranking == 9 then
   name = 'Hight Card'
 end
 return name
end


--1 Straight Flush
--2 Four of a Kind
--3 Full House
--4 Flush
--5 Straight
--6 Three of a Kind
--7 Two Pair
--8 One Pair
--9 Hight Card
