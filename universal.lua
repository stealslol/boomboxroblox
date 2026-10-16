local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoomBoxUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Text = "BoomBox - made by stealslol"
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 18
TitleLabel.Parent = MainFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Text = "-"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -30, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = MainFrame

local CodeBox = Instance.new("TextBox")
CodeBox.Name = "CodeBox"
CodeBox.PlaceholderText = "Вставьте код музыки здесь"
CodeBox.Size = UDim2.new(0.9, 0, 0, 30)
CodeBox.Position = UDim2.new(0.05, 0, 0.2, 0)
CodeBox.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
CodeBox.TextColor3 = Color3.new(1, 1, 1)
CodeBox.Font = Enum.Font.SourceSans
CodeBox.TextSize = 14
CodeBox.Parent = MainFrame

local PlayButton = Instance.new("TextButton")
PlayButton.Name = "PlayButton"
PlayButton.Text = "Play"
PlayButton.Size = UDim2.new(0.4, 0, 0, 30)
PlayButton.Position = UDim2.new(0.05, 0, 0.5, 0)
PlayButton.BackgroundColor3 = Color3.new(0.1, 0.5, 0.1)
PlayButton.TextColor3 = Color3.new(1, 1, 1)
PlayButton.Font = Enum.Font.SourceSansBold
PlayButton.TextSize = 18
PlayButton.Parent = MainFrame

local StopButton = Instance.new("TextButton")
StopButton.Name = "StopButton"
StopButton.Text = "Stop"
StopButton.Size = UDim2.new(0.4, 0, 0, 30)
StopButton.Position = UDim2.new(0.55, 0, 0.5, 0)
StopButton.BackgroundColor3 = Color3.new(0.5, 0.1, 0.1)
StopButton.TextColor3 = Color3.new(1, 1, 1)
StopButton.Font = Enum.Font.SourceSansBold
StopButton.TextSize = 18
StopButton.Parent = MainFrame

local VolumeSlider = Instance.new("TextLabel")
VolumeSlider.Name = "VolumeSlider"
VolumeSlider.Text = "Volume: 50%"
VolumeSlider.Size = UDim2.new(0.9, 0, 0, 20)
VolumeSlider.Position = UDim2.new(0.05, 0, 0.8, 0)
VolumeSlider.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
VolumeSlider.TextColor3 = Color3.new(1, 1, 1)
VolumeSlider.Font = Enum.Font.SourceSans
VolumeSlider.TextSize = 14
VolumeSlider.Parent = MainFrame

local VolumeBar = Instance.new("Frame")
VolumeBar.Name = "VolumeBar"
VolumeBar.Size = UDim2.new(0.9, 0, 0, 5)
VolumeBar.Position = UDim2.new(0.05, 0, 0.9, 0)
VolumeBar.BackgroundColor3 = Color3.new(0.1, 0.5, 0.1)
VolumeBar.Parent = MainFrame

local Minimized = false

MinimizeButton.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        MainFrame.Size = UDim2.new(0, 300, 0, 30)
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 300, 0, 200)
        MinimizeButton.Text = "-"
    end
end)

local Sound = Instance.new("Sound")
Sound.Name = "BoomBoxSound"
Sound.Parent = ReplicatedStorage
Sound.Looped = true
Sound.Volume = 0.5

local function PlayMusic(code)
    if code ~= "" then
        Sound.SoundId = "rbxassetid://" .. code
        Sound:Play()
    end
end

local function StopMusic()
    Sound:Stop()
end

PlayButton.MouseButton1Click:Connect(function()
    PlayMusic(CodeBox.Text)
end)

StopButton.MouseButton1Click:Connect(function()
    StopMusic()
end)

local function UpdateVolume(volume)
    Sound.Volume = volume
    VolumeSlider.Text = "Volume: " .. math.floor(volume * 100) .. "%"
    VolumeBar.Size = UDim2.new(volume, 0, 0, 5)
end

local function HandleVolumeInput(input)
    local mousePos = input.Position.X
    local framePos = MainFrame.AbsolutePosition.X
    local frameSize = MainFrame.AbsoluteSize.X
    local volume = (mousePos - framePos) / frameSize
    volume = math.clamp(volume, 0, 1)
    UpdateVolume(volume)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        HandleVolumeInput(input)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        HandleVolumeInput(input)
    end
end)

UserInputService.TouchStarted:Connect(function(input)
    HandleVolumeInput(input)
end)

UserInputService.TouchMoved:Connect(function(input)
    HandleVolumeInput(input)
end)

local function CreateSoundForAll()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local soundClone = Sound:Clone()
            soundClone.Parent = player.Character or player.CharacterAdded:Wait()
            soundClone:Play()
        end
    end
end

Sound.Played:Connect(CreateSoundForAll)
