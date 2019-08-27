--imports
Gamestate = require 'lib.gamestate'
lovebird =  require "lib.lovebird"
require('class.background')
require('class.screen')
require('class.card')
require('class.deck')

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
end

function love.draw()
end

--state game

function game:enter()

	deck = Deck()
	cards = {}
	n = 40
	for i=1,40, 1 do
		cards[i] = deck:drawCard(cards)
		print(cards[i].value.." of "..cards[i].suit)
	end

end

function game:update(dt)
end

function game:draw()
  screen:push()
    screen:scale()

  screen:pop()
end

function game:keyreleased(key,code)
    if key == 'p' then
    	screen:increaseResolution()
    end

    if key == 'o' then
    	screen:decreaseResolution()
    end
end
