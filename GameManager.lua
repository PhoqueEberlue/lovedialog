GameManager = {}
GameManager.__index = GameManager


require("DialogManager")
require("BackgroundManager")
local json = require("src.lunajson")

function GameManager:new(filepath)
    local object = {}
    setmetatable(object, GameManager)
    object.filepath = filepath

    object.dialogManager = DialogManager:new()
    object.timeline = json.decode(io.open(filepath.."/data.json", "r"):read("*a"))
    object.timelineIndex = 1
    -- table of booleans idicating if an animation is finished or not
    object.status = {dialog = false}
    

    local firstDialog = object.timeline[1]
    object.dialogManager:newDialogBox(firstDialog.text, firstDialog.textAnimationDuration)


    object.backgroundManager = BackgroundManager:new()
    object.backgroundManager:set(filepath.."/background/"..firstDialog.backgroundImg)
    return object
end

function GameManager:update(dt)
    if not self.status.dialog then
        self.status.dialog = self.dialogManager:update(dt)
    end
    if self.status.dialog then
        if love.keyboard.isDown("a") then
            self.timelineIndex = self.timelineIndex + 1
            self.status.dialog = false
   
            local currentBox = self.timeline[self.timelineIndex]
            self.dialogManager:newDialogBox(currentBox.text, currentBox.textAnimationDuration)
            self.backgroundManager:set(self.filepath.."/background/"..currentBox.backgroundImg)
        end
    end
end

function GameManager:draw()
    self.backgroundManager:draw()
    self.dialogManager:draw()
end