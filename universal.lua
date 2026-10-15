local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BoomBoxGUI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local madeByLabel = Instance.new("TextLabel")
madeByLabel.Text = "made by stealslol"
madeByLabel.Size = UDim2.new(1, 0, 0, 20)
madeByLabel.Position = UDim2.new(0, 0, 0, 0)
madeByLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
madeByLabel.TextColor3 = Color3.new(1, 1, 1)
madeByLabel.Font = Enum.Font.SourceSansBold
madeByLabel.TextSize = 14
madeByLabel.Parent = screenGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.5, 0, 0.2, 0)
frame.Position = UDim2.new(0.25, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
frame.Parent = screenGui

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0.4, 0)
textBox.Position = UDim2.new(0.1, 0, 0.1, 0)
textBox.PlaceholderText = "Введите ID музыки"
textBox.BackgroundColor3 = Color3.new(1, 1, 1)
textBox.TextColor3 = Color3.new(0, 0, 0)
textBox.Font = Enum.Font.SourceSans
textBox.TextSize = 14
textBox.Parent = frame

local playButton = Instance.new("TextButton")
playButton.Size = UDim2.new(0.8, 0, 0.4, 0)
playButton.Position = UDim2.new(0.1, 0, 0.55, 0)
playButton.Text = "Play Music"
playButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.8)
playButton.TextColor3 = Color3.new(1, 1, 1)
playButton.Font = Enum.Font.SourceSansBold
playButton.TextSize = 14
playButton.Parent = frame

local sound = Instance.new("Sound")
sound.Parent = game.Workspace
sound.Volume = 1

playButton.MouseButton1Click:Connect(function()
    local musicId = textBox.Text
    if musicId ~= "" then
        sound.SoundId = "rbxassetid://" .. musicId
        sound:Play()
    end
end)

if game:GetService("UserInputService").TouchEnabled then
    frame.Size = UDim2.new(0.8, 0, 0.3, 0)
    frame.Position = UDim2.new(0.1, 0, 0.35, 0)
    textBox.TextSize = 18
    playButton.TextSize = 18
end
