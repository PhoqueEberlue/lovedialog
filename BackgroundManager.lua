BackgroundManager = {}
BackgroundManager.__index = BackgroundManager

function BackgroundManager:new()
    local object = {}
    setmetatable(object, BackgroundManager)
    object.path = nil
    return object
end

function BackgroundManager:set(path)
    if path ~= self.path then
        self.path = path
        self.backgroundImage = love.graphics.newImage(path)
    end
end

function BackgroundManager:draw()
    love.graphics.draw(self.backgroundImage, 0, 0)
end