DialogManager = {}
DialogManager.__index = DialogManager

local width, height = love.graphics.getDimensions()

DialogManager.windowHeight = height
DialogManager.windowWidth = width
DialogManager.currentBox = nil
DialogManager.currentTime = 0

function DialogManager:new()
    local object = {}
    setmetatable(object, DialogManager)
    return object
end

function DialogManager:newDialogBox(text, textAnimationDuration)
    local dialogBox = {}

    dialogBox.boxHeight = math.floor(15*self.windowHeight/100)
    dialogBox.boxWidth = math.floor(95*self.windowWidth/100)
    dialogBox.boxPadding = math.floor(5*self.windowHeight/100)

    dialogBox.posX = self.windowWidth/2 - dialogBox.boxWidth/2
    dialogBox.posY = self.windowHeight - dialogBox.boxHeight - dialogBox.boxPadding

    dialogBox.textX = math.floor(dialogBox.posX + dialogBox.boxPadding/2)
    dialogBox.textY = math.floor(dialogBox.posY + dialogBox.boxPadding/2)

    dialogBox.font = love.graphics.getFont()
    dialogBox.text = text
    dialogBox.textAnimationDuration = textAnimationDuration
    self.currentBox = dialogBox
    self.currentTime = 0
end

function DialogManager:update(dt)
    self.currentTime = self.currentTime + dt
    if self.currentTime >= self.currentBox.textAnimationDuration then
        return true
    end
    return false
end

function DialogManager:draw()
    print("bonsoir")
    if self.currentBox ~= nil then
        local numChar = math.floor(self.currentTime / self.currentBox.textAnimationDuration * #self.currentBox.text) + 1
        local plainText = love.graphics.newText(self.currentBox.font, string.sub(self.currentBox.text, 1, numChar))

        love.graphics.rectangle('line', self.currentBox.posX, self.currentBox.posY, self.currentBox.boxWidth, self.currentBox.boxHeight)
        love.graphics.draw(plainText, self.currentBox.textX, self.currentBox.textY)
    end
end