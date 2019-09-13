--imports
Gamestate = require 'lib.gamestate'
require('class.background')
require('class.direction')
require('class.player')
require('class.obstacle')
require('class.god')
require('class.screen')

--states
menu = {}
game = {}
gameOver = {}
pause = {}

--love bare functions
function love.load()
  --GameState essential functions
	screen = Screen()
	Gamestate.registerEvents()
  Gamestate.switch(menu)
end

function love.update(dt)
end

function love.draw()
end

------------------------------------------------
--state menu
function menu:init()

end

function menu:enter()
	--bgPaused = Background(0,0,"assets/img/states-paused.png")
end

function menu:update(dt)
end

function menu:draw()
	--bgPaused:draw()
	--love.graphics.print("Current Score: "..math.floor(player:getScore()), 500,15)
	--love.graphics.print("Press Space to resume game!", 500,30)
end

function menu:keyreleased(key,code)
	if key == 'space' then
		Gamestate.switch(game)
	end
end


------------------------------------------------
--state game

function game:enter()
	bgGame = Background(0,0,"assets/img/states-game.png")
	bgGame:reset()
	--creation 4 directions
	dir_down = Direction("down", 0, 1)
	dir_right = Direction("right", 1, 0)
	dir_up = Direction("up", 0, -1)
	dir_left = Direction("left", -1, 0)
	directions = {right = dir_right, left = dir_left, up = dir_up, down = dir_down}
	player = Player(300, 20, "Balinho", directions,  {up = "up", ghost = "g"})
	obstacles = {Obstacle()}
	god = God()
end

function game:update(dt)
	bgGame:update(dt)
	player:update(dt)
	god:updateObstacles(obstacles, bgGame, dt)
	if not god:isPlayerAlive(player, obstacles) then
		Gamestate.switch(gameOver)
	end
end

function game:draw()
	bgGame:draw()
	god:drawObstacles(obstacles)
	player:draw()
end

function game:keyreleased(key,code)
	player:keyreleased(key, code)
	if key == 'space' then
		Gamestate.push(pause)
	end
end

-----------------------------------
--state gameOver

function gameOver:enter()
	bgGameOver = Background(0,0,"assets/img/states-game-over.png")
end

function gameOver:update(dt)
end

function gameOver:draw()
	bgGameOver:draw()
	love.graphics.print("Final Score: "..math.floor(player:getScore()), 500,8)
	love.graphics.print("Press Space to play again", 500,22)
	love.graphics.print("or Esc to return to menu.", 500,34)
end

function gameOver:keyreleased(key,code)
	player:keyreleased(key, code)
	if key == 'space' then
		Gamestate.switch(game)
	end
	if key == 'escape' then
		Gamestate.switch(menu)
	end
end

-----------------------------------
--state pause

function pause:enter()
	bgPaused = Background(0,0,"assets/img/states-paused.png")
end

function pause:update(dt)
end

function pause:draw()
	bgPaused:draw()
	love.graphics.print("Current Score: "..math.floor(player:getScore()), 500,8)
	love.graphics.print("Press Space to resume game", 500,22)
	love.graphics.print("or Esc to return to menu.", 500,36)
end

function pause:keyreleased(key,code)
	player:keyreleased(key, code)
	if key == 'space' then
		Gamestate.pop()
	end
	if key == 'escape' then
		Gamestate.switch(menu)
	end
end
