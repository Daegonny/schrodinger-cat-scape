Class = require 'lib.class'
require('class.card')
require('class.hand')

Deck = Class{
    init = function(self)
    end
}
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

function compare(a,b)
  return a.value < b.value
end

function Deck:sortCards(cards)
  table.sort(cards, compare)
  return cards
end

function Deck:determineHand(cards)
  sCards = self:sortCards(cards)

  if self:isStraightFlush(sCards) then
    hand = Hand(cards, 1)
  elseif self:is4ofaKind(sCards) then
    hand = Hand(cards, 2)
  elseif self:isFullHouse(sCards) then
    hand = Hand(cards, 3)
  elseif self:isFlush(sCards) then
    hand = Hand(cards, 4)
  elseif self:isStraight(sCards) then
    hand = Hand(cards, 5)
  elseif self:is3ofaKind(sCards) then
    hand = Hand(cards, 6)
  elseif self:is2pair(sCards) then
    hand = Hand(cards, 7)
  elseif self:is1pair(sCards) then
    hand = Hand(cards, 8)
  else
    hand = nil
  end
  return hand
end

function Deck:showCards(cards)
  for k,v in ipairs(cards) do
    print(v.value.." "..v.suit)
  end
end

function Deck:isSeq(card1, card2)
  return (card1.value+1) == card2.value or (card1.value == 13 and card2.value == 1)
end

function Deck:isStraight(cards)
  return self:isSeq(cards[1], cards[2]) and self:isSeq(cards[2], cards[3]) and self:isSeq(cards[3], cards[4]) and self:isSeq(cards[4], cards[5])
end

function Deck:isSomeSuit (cards, suit)
  return (cards[1].suit == suit and cards[2].suit == suit and cards[3].suit == suit and cards[4].suit == suit and cards[5].suit == suit)
end

function Deck:isFlush(cards)
  return self:isSomeSuit(cards, "clubs") or self:isSomeSuit(cards, "diamonds") or self:isSomeSuit(cards, "spades") or self:isSomeSuit(cards, "hearts")
end

function Deck:isStraightFlush(cards)
  return self:isStraight(cards) and self:isFlush(cards)
end

function Deck:is4ofaKind(cards)
  return (cards[1].value == cards[2].value and cards[2].value == cards[3].value and cards[3].value == cards[4].value)
  or (cards[2].value == cards[3].value and cards[3].value == cards[4].value and cards[4].value == cards[5].value)
end

function Deck:is3ofaKind(cards)
  return (cards[1].value == cards[2].value and cards[2].value == cards[3].value)
  or (cards[2].value == cards[3].value and cards[3].value == cards[4].value)
  or (cards[3].value == cards[4].value and cards[4].value == cards[5].value)
end

function Deck:is2pair(cards)
  return (cards[1].value == cards[2].value and cards[3].value == cards[4].value)
  or (cards[1].value == cards[2].value and cards[4].value == cards[5].value)
  or (cards[2].value == cards[3].value and cards[4].value == cards[5].value)
end

function Deck:is1pair(cards)
  return (cards[1].value == cards[2].value)
  or (cards[2].value == cards[3].value)
  or (cards[3].value == cards[4].value)
  or (cards[4].value == cards[5].value)
end

function Deck:isFullHouse(cards)
  return ((cards[1].value == cards[2].value) and (cards[3].value == cards[4].value and cards[4].value == cards[5].value))
  or ((cards[1].value == cards[2].value and cards[2].value == cards[3].value) and (cards[4].value == cards[5].value))
end

--Tenho certeza que há um modo mais inteligente de fazer isso
--mas por enquanto vai esse mesmo
function Deck:buildAllHands(cards)
  allHands = {}
  --todas da mesa
  table.insert(allHands, {cards[1], cards[2], cards[3], cards[4], cards[5]})
  --usando primeira carta e mesa
  table.insert(allHands, {cards[6], cards[2], cards[3], cards[4], cards[5]})
  table.insert(allHands, {cards[1], cards[6], cards[3], cards[4], cards[5]})
  table.insert(allHands, {cards[1], cards[2], cards[6], cards[4], cards[5]})
  table.insert(allHands, {cards[1], cards[2], cards[3], cards[6], cards[5]})
  table.insert(allHands, {cards[1], cards[2], cards[3], cards[4], cards[6]})
  --usando segunda carta e mesa
  table.insert(allHands, {cards[7], cards[2], cards[3], cards[4], cards[5]})
  table.insert(allHands, {cards[1], cards[7], cards[3], cards[4], cards[5]})
  table.insert(allHands, {cards[1], cards[2], cards[7], cards[4], cards[5]})
  table.insert(allHands, {cards[1], cards[2], cards[3], cards[7], cards[5]})
  table.insert(allHands, {cards[1], cards[2], cards[3], cards[4], cards[7]})
  --usando duas cartas e mesa
  table.insert(allHands, {cards[6], cards[7], cards[1], cards[2], cards[3]})
  table.insert(allHands, {cards[6], cards[7], cards[1], cards[2], cards[4]})
  table.insert(allHands, {cards[6], cards[7], cards[1], cards[2], cards[5]})
  table.insert(allHands, {cards[6], cards[7], cards[1], cards[3], cards[4]})
  table.insert(allHands, {cards[6], cards[7], cards[1], cards[3], cards[5]})
  table.insert(allHands, {cards[6], cards[7], cards[1], cards[4], cards[5]})
  table.insert(allHands, {cards[6], cards[7], cards[2], cards[3], cards[4]})
  table.insert(allHands, {cards[6], cards[7], cards[2], cards[3], cards[5]})
  table.insert(allHands, {cards[6], cards[7], cards[2], cards[4], cards[5]})
  table.insert(allHands, {cards[6], cards[7], cards[3], cards[4], cards[5]})
  --
  return allHands
end

function Deck:buildBestHands(allHands)
  bestHands = {}
  for k,cards in pairs(allHands) do
    candidateHand = self:determineHand(cards)
    if candidateHand ~= nil then
      table.insert(bestHands, candidateHand)
    end
  end
  return bestHands
end

function Deck:determineBestHand(fiveCards,twoCards)
  cards = {fiveCards[1], fiveCards[2], fiveCards[3], fiveCards[4], fiveCards[5], twoCards[1], twoCards[2],}
  allHands = self:buildAllHands(cards)
  bestHands = self:buildBestHands(allHands)
  if #bestHands == 0 then
    sortedCards = deck:sortCards(cards)
    return Hand({sortedCards[3], sortedCards[4], sortedCards[5], sortedCards[6], sortedCards[7],}, 9)
  else
    bestHand = bestHands[1]
    for k,v in pairs(bestHands) do
      if v:getRanking() < bestHand:getRanking() then
        bestHand = v
      elseif v:getRanking() == bestHand:getRanking() and (v:getPoints() > bestHand:getPoints()) then
        bestHand = v
      end
    end
  end
  return bestHand
end
