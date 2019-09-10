--imports
Gamestate = require 'lib.gamestate'
require('class.background')
require('class.direction')
require('class.player')
require('class.obstacle')
require('class.god')

--states
game = {}
gameOver = {}

--love bare functions
function love.load()
  --GameState essential functions
	Gamestate.registerEvents()
  Gamestate.switch(game)
end

function love.update(dt)
end

function love.draw()
end

------------------------------------------------
--state game

function game:init()
	--creation 4 directions
  dir_down = Direction("down", 0, 1)
  dir_right = Direction("right", 1, 0)
  dir_up = Direction("up", 0, -1)
  dir_left = Direction("left", -1, 0)
  directions = {right = dir_right, left = dir_left, up = dir_up, down = dir_down}
end

function game:enter()
	player = Player(300, 29, "Balinho", directions,  {up = "up", down = "down", left = "left", right = "right"})
	obstacles = {Obstacle(), Obstacle(), Obstacle(), Obstacle(), Obstacle(), Obstacle()}
	god = God()
end

function game:update(dt)
	player:update(dt)
	god:updateObstacles(obstacles, dt)
	if not god:isPlayerAlive(player, obstacles) then
		--Gamestate.switch(gameOver)
	end
end

function game:draw()
	player:draw()
	god:drawObstacles(obstacles)
end

function game:keyreleased(key,code)
	player:keyreleased(key, code)
	if key == 'space' then
	--	Gamestate.switch(preflop)
	end
end

-----------------------------------
--state gameOver

function gameOver:enter()
end

function gameOver:update(dt)
end

function gameOver:draw()
	love.graphics.print("\'Cê perdeu, zé.", 0,0)
end

function gameOver:keyreleased(key,code)
	player:keyreleased(key, code)
	if key == 'space' then
		Gamestate.switch(game)
	end
end
