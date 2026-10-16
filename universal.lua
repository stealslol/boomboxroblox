local screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
mainFrame.Active = true
mainFrame.Draggable = true

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Text = "made by stealslol"
titleLabel.Size = UDim2.new(1, 0, 0, 20)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 14

local minimizeButton = Instance.new("TextButton", mainFrame)
minimizeButton.Size = UDim2.new(0, 20, 0, 20)
minimizeButton.Position = UDim2.new(1, -25, 0, 5)
minimizeButton.Text = "_"
minimizeButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

local musicIdBox = Instance.new("TextBox", mainFrame)
musicIdBox.Size = UDim2.new(0.8, 0, 0, 30)
musicIdBox.Position = UDim2.new(0.1, 0, 0.2, 0)
musicIdBox.PlaceholderText = "Введите ID музыки"
musicIdBox.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
musicIdBox.TextColor3 = Color3.new(1, 1, 1)

local volumeSlider = Instance.new("TextButton", mainFrame)
volumeSlider.Size = UDim2.new(0.8, 0, 0, 20)
volumeSlider.Position = UDim2.new(0.1, 0, 0.4, 0)
volumeSlider.Text = "Громкость: 50%"
volumeSlider.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
volumeSlider.TextColor3 = Color3.new(1, 1, 1)

local volumeValue = 0.5

volumeSlider.MouseButton1Down:Connect(function(x)
    local startX = volumeSlider.AbsolutePosition.X
    local endX = startX + volumeSlider.AbsoluteSize.X
    local function updateVolume(x)
        volumeValue = math.clamp((x - startX) / (endX - startX), 0, 1)
        volumeSlider.Text = "Громкость: " .. math.floor(volumeValue * 100) .. "%"
        if sound then
            sound.Volume = volumeValue
        end
    end
    updateVolume(x)
    local connection
    connection = game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            updateVolume(input.Position.X)
        else
            connection:Disconnect()
        end
    end)
end)

local playButton = Instance.new("TextButton", mainFrame)
playButton.Size = UDim2.new(0.35, 0, 0, 30)
playButton.Position = UDim2.new(0.1, 0, 0.6, 0)
playButton.Text = "Play"
playButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
playButton.TextColor3 = Color3.new(1, 1, 1)

local stopButton = Instance.new("TextButton", mainFrame)
stopButton.Size = UDim2.new(0.35, 0, 0, 30)
stopButton.Position = UDim2.new(0.55, 0, 0.6, 0)
stopButton.Text = "Stop"
stopButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
stopButton.TextColor3 = Color3.new(1, 1, 1)

local sound

playButton.MouseButton1Click:Connect(function()
    if sound then
        sound:Stop()
        sound:Destroy()
    end
    local musicId = tonumber(musicIdBox.Text)
    if musicId then
        sound = Instance.new("Sound", workspace)
        sound.SoundId = "rbxassetid://" .. musicId
        sound.Volume = volumeValue
        sound:Play()
        sound.Looped = true
    end
end)

stopButton.MouseButton1Click:Connect(function()
    if sound then
        sound:Stop()
    end
end)
