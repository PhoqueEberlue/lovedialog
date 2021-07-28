GameManager = {}
GameManager.__index = GameManager

require("DialogManager")
require("BackgroundManager")
local json = require("src.lunajson") -- https://github.com/grafi-tt/lunajson

function GameManager:new(filepath)
    local object = {}
    setmetatable(object, GameManager)
    object.filepath = filepath

    -- table of booleans idicating if an animation is finished or not
    object.status = {dialog = false}

    -- init of the timeline, loading game's file
    object.timeline = json.decode(io.open(filepath.."/data.json", "r"):read("*a"))
    object.timelineIndex = 1

    -- loads first dialog
    local firstDialog = object.timeline[1]

    -- dialogManager
    object.dialogManager = DialogManager:new()
    object.dialogManager:newDialogBox(firstDialog.text, firstDialog.textAnimationDuration)

    -- backgroundManager
    object.backgroundManager = BackgroundManager:new()
    object.backgroundManager:set(filepath.."/background/"..firstDialog.backgroundImg)

    return object
end

function GameManager:update(dt)
    if not self.status.dialog then
        -- gets dialog animation status, false = running, true = finished
        self.status.dialog = self.dialogManager:update(dt)
    end

    -- checks if animations are finished before letting the player pass the dialog
    if self.status.dialog then
        if love.keyboard.isDown("a") then
            -- timeline progression
            self.timelineIndex = self.timelineIndex + 1
            self.status.dialog = false
   
            local currentBox = self.timeline[self.timelineIndex]
            self.dialogManager:newDialogBox(currentBox.text, currentBox.textAnimationDuration)

            if currentBox.backgroundImg ~= nil then
                self.backgroundManager:set(self.filepath.."/background/"..currentBox.backgroundImg)
            end
        end
    end
end

function GameManager:draw()
    -- draws background first in order the set it behind all the elements
    self.backgroundManager:draw()
    self.dialogManager:draw()
end
