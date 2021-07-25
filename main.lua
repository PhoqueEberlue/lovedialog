function love.load()
    love.window.setFullscreen(true)
    require("GameManager")
    MainGameManager = GameManager:new("flexgang")
end

function love.update(dt)
    MainGameManager:update(dt)
end

function love.draw()
    MainGameManager:draw()
end
