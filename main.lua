--imports
Gamestate = require 'lib.gamestate'
lovebird =  require "lib.lovebird"
require('class.background')
require('class.screen')
require('class.card')
require('class.deck')
require('class.player')
require('class.dealer')

--states
game = {}

--substates
preflop = {}
flop = {}
turn = {}
river = {}
showdown = {}

--love bare functions
function love.load()

	math.randomseed(os.time())

  --screen
	screen = Screen(loader)

  --GameState essential functions
	Gamestate.registerEvents()
  Gamestate.switch(game)
end

function love.update(dt)
	lovebird.update()
end

function love.draw()
end

------------------------------------------------
--state game

function game:init()
	deck = Deck()
	inGameCards = {}
end

function game:enter()
	for i=1,9, 1 do
		inGameCards[i] = deck:drawCard(inGameCards)
	end

	player = Player(1000, {inGameCards[1], inGameCards[2]})
	rival = Player(1000, {inGameCards[3], inGameCards[4]})
	dealer = Dealer({inGameCards[5], inGameCards[6],inGameCards[7], inGameCards[8], inGameCards[9]}, 100, 200)

	print("Meowww Let's play poker!!!")

end

function game:update(dt)
end

function game:draw()
end

function game:keyreleased(key,code)
	if key == 'space' then
		Gamestate.switch(preflop)
	end
end

------------------------------------------------
--state preflop
function preflop:enter()
	print("-----------pre flop-------------")
	print("player cards")
	print(player.cards[1].value.." of "..player.cards[1].suit)
	print(player.cards[2].value.." of "..player.cards[2].suit)
	print("--------------------------------")
	print("rival cards")
	print(rival.cards[1].value.." of "..rival.cards[1].suit)
	print(rival.cards[2].value.." of "..rival.cards[2].suit)
	print("--------------------------------")
end

function preflop:update(dt)
end

function preflop:draw()
end

function preflop:keyreleased(key,code)
	if key == 'space' then
		Gamestate.switch(river)
	end
end

------------------------------------------------
--state flop
function flop:enter()
	print("-----------flop-----------------")
	print("table cards")
	dealer:showCards(3)
	print("--------------------------------")
end

function flop:update(dt)
end

function flop:draw()
end

function flop:keyreleased(key,code)
	if key == 'space' then
		Gamestate.switch(turn)
	end
end

------------------------------------------------
--state turn
function turn:enter()
	print("-----------turn-----------------")
	print("table cards")
	dealer:showCards(4)
	print("--------------------------------")
end

function turn:update(dt)
end

function turn:draw()
end

function turn:keyreleased(key,code)
	if key == 'space' then
		Gamestate.switch(river)
	end
end

------------------------------------------------
--state river
function river:enter()
	print("-----------river-----------------")
	print("table cards")
	dealer:showCards(5)
	print("--------------------------------")
end

function river:update(dt)
end

function river:draw()
end

function river:keyreleased(key,code)
	if key == 'space' then
		Gamestate.switch(showdown)
	end
end

------------------------------------------------
--state showdown
function showdown:enter()
	print("-----------Hands-----------------")
	playerBestHand = deck:determineBestHand(dealer:getCards(), player:getCards())
	rivalBestHand = deck:determineBestHand(dealer:getCards(), rival:getCards())

	print("--Player have "..playerBestHand:getName().."--")
	deck:showCards(playerBestHand:getCards())
	print("Ranking: "..playerBestHand:getRanking().." Points: "..playerBestHand:getPoints())

	print("--Rival has "..rivalBestHand:getName().."--")
	deck:showCards(rivalBestHand:getCards())
	print("Ranking: "..rivalBestHand:getRanking().." Points: "..rivalBestHand:getPoints())
	print("--------------------------------")
end

function showdown:update(dt)
end

function showdown:draw()
end

function showdown:keyreleased(key,code)

end
