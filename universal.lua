local chatFrame = Instance.new("Frame")
chatFrame.Name = "ChatFrame"
chatFrame.Size = UDim2.new(0, 300, 0, 200)
chatFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
chatFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
chatFrame.BorderSizePixel = 0
chatFrame.Active = true
chatFrame.Draggable = true
chatFrame.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 20)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = chatFrame

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, -50, 1, 0)
titleText.Position = UDim2.new(0, 5, 0, 0)
titleText.Text = "made by stealslol"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.BackgroundTransparency = 1
titleText.Font = Enum.Font.SourceSans
titleText.TextSize = 14
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 20, 0, 20)
minimizeButton.Position = UDim2.new(1, -40, 0, 0)
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.BorderSizePixel = 0
minimizeButton.Font = Enum.Font.SourceSans
minimizeButton.TextSize = 14
minimizeButton.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -20, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Font = Enum.Font.SourceSans
closeButton.TextSize = 14
closeButton.Parent = titleBar

local chatLog = Instance.new("ScrollingFrame")
chatLog.Name = "ChatLog"
chatLog.Size = UDim2.new(1, -10, 1, -60)
chatLog.Position = UDim2.new(0, 5, 0, 25)
chatLog.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
chatLog.BorderSizePixel = 0
chatLog.ScrollBarThickness = 8
chatLog.CanvasSize = UDim2.new(0, 0, 0, 0)
chatLog.AutomaticCanvasSize = Enum.AutomaticSize.Y
chatLog.Parent = chatFrame

local chatEntry = Instance.new("TextBox")
chatEntry.Name = "ChatEntry"
chatEntry.Size = UDim2.new(1, -70, 0, 30)
chatEntry.Position = UDim2.new(0, 5, 1, -35)
chatEntry.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
chatEntry.BorderSizePixel = 0
chatEntry.TextColor3 = Color3.fromRGB(255, 255, 255)
chatEntry.Font = Enum.Font.SourceSans
chatEntry.TextSize = 14
chatEntry.PlaceholderText = "Type your message..."
chatEntry.Parent = chatFrame

local sendButton = Instance.new("TextButton")
sendButton.Name = "SendButton"
sendButton.Size = UDim2.new(0, 60, 0, 30)
sendButton.Position = UDim2.new(1, -65, 1, -35)
sendButton.Text = "Send"
sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sendButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
sendButton.BorderSizePixel = 0
sendButton.Font = Enum.Font.SourceSans
sendButton.TextSize = 14
sendButton.Parent = chatFrame

local function addMessage(message)
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Font = Enum.Font.SourceSans
    messageLabel.TextSize = 14
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.Size = UDim2.new(1, 0, 0, 20)
    messageLabel.Parent = chatLog
end

sendButton.MouseButton1Click:Connect(function()
    local message = chatEntry.Text
    if message ~= "" then
        addMessage(game.Players.LocalPlayer.Name .. ": " .. message)
        chatEntry.Text = ""
    end
end)

chatEntry.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local message = chatEntry.Text
        if message ~= "" then
            addMessage(game.Players.LocalPlayer.Name .. ": " .. message)
            chatEntry.Text = ""
        end
    end
end)

minimizeButton.MouseButton1Click:Connect(function()
    chatLog.Visible = not chatLog.Visible
    chatEntry.Visible = not chatEntry.Visible
    sendButton.Visible = not sendButton.Visible
end)

closeButton.MouseButton1Click:Connect(function()
    chatFrame:Destroy()
end)

local userInputService = game:GetService("UserInputService")
local function onInputBegan(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.Touch then
        chatFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    end
end
userInputService.InputBegan:Connect(onInputBegan)
