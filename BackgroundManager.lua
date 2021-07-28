BackgroundManager = {}
BackgroundManager.__index = BackgroundManager

function BackgroundManager:new()
    local object = {}
    setmetatable(object, BackgroundManager)
    object.path = nil
    return object
end

function BackgroundManager:set(path)
    self.path = path
    self.backgroundImage = love.graphics.newImage(path)
end

function BackgroundManager:draw()
    love.graphics.draw(self.backgroundImage, 0, 0)
end