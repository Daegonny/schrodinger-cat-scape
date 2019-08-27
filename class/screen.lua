Class = require 'lib.class'

Screen = Class{
    init = function(self, loader)
    	self.lg = love.graphics
    	self.actualWidth = 0
    	self.actualHeight = 0
    	self.defaultWidth = 720
    	self.defaultHeight = 50
    	self.topEdge = 0
    	self.leftEdge = 0
    	self.full = false
    	self.index = 1
    	self.maxIndex = 1
    	self.loader = loader
    	self.tableScreen = {}
    	self.resolutions = {
    		{ width = self.defaultWidth/2 , height =  self.defaultHeight/2},
    		{ width = self.defaultWidth , height =  self.defaultHeight}
    	}
    	self:start()
    end
}

function Screen:setActualWidth(actualWidth)
	self.actualWidth = actualWidth
end

function Screen:getActualWidth()
	return self.actualWidth
end

function Screen:setActualHeight(actualHeight)
	self.actualHeight = actualHeight
end

function Screen:getActualHeight()
	return self.actualHeight
end

function Screen:setTopEdge(topEdge)
	self.topEdge = topEdge
end

function Screen:getTopEdge()
	return self.topEdge
end

function Screen:setLeftEdge(leftEdge)
	self.leftEdge = leftEdge
end

function Screen:getLeftEdge()
	return self.leftEdge
end

function Screen:setFull(full)
	self.full = full
end

function Screen:getFull()
	return self.full
end

function Screen:setIndex(index)
	self.index = index
end

function Screen:getIndex()
	return self.index
end

function Screen:setMaxIndex(maxIndex)
	self.maxIndex = maxIndex
end

function Screen:getMaxIndex()
	return self.maxIndex
end

function Screen:getConstWidth()
	return self:getActualWidth()/self.defaultWidth
end

function Screen:getConstHeight()
	return self:getActualHeight()/self.defaultHeight
end

function Screen:push()
	love.graphics.push()
end

function Screen:pop()
	love.graphics.pop()
end

function Screen:scale()
	if self:getFull() then
	    love.graphics.translate(self:getLeftEdge(), self:getTopEdge())
	end
	love.graphics.scale(self:getConstWidth(), self:getConstHeight())
end

function Screen:changeResolution()
	self:setActualWidth(self.resolutions[self:getIndex()]["width"])
	self:setActualHeight(self.resolutions[self:getIndex()]["height"])
	self:setMode()
	self:calculateEdges()
end

function Screen:increaseResolution()
	if self:getIndex() < self:getMaxIndex() then
		self:setIndex(self:getIndex() + 1)
		self:changeResolution()
	end
end

function Screen:decreaseResolution()
	if self:getIndex() > 1 then
		self:setIndex(self:getIndex() - 1)
		self:changeResolution()
	end
end

function Screen:calculateEdges()
	self:setTopEdge((self.resolutions[self:getMaxIndex()]["height"] - self:getActualHeight()) / 2)
	self:setLeftEdge((self.resolutions[self:getMaxIndex()]["width"] - self:getActualWidth()) / 2)
end

function Screen:toggleFull()
	self:setFull(not self:getFull())
	self:setMode()
end

function Screen:setMode()
	love.window.setMode( self:getActualWidth(), self:getActualHeight() ,{fullscreen = self:getFull()})
end

function Screen:getMaxResolution()
	local modes = love.window.getFullscreenModes()
	table.sort(modes, function(a, b) return a.width*a.height > b.width*b.height end)
	return modes[1]
end

function Screen:getMaxResolutionAvailable()
	local max = self:getMaxResolution()
	local index
	for k,v in pairs(self.resolutions) do
		if max["width"] >= v["width"] and max["height"] >= v["height"]   then
		    index = k
		end
	end
	self:setMaxIndex(index)
end

function Screen:start()
	self:getMaxResolutionAvailable()
	self:setFull(false)
	self:setIndex(self:getMaxIndex())
	self:changeResolution()
end
