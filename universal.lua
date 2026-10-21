local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoomBoxGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 350, 0, 250)
Frame.Position = UDim2.new(0.5, -175, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Text = "made by stealslol"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.Parent = Frame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Text = "-"
MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
MinimizeButton.Position = UDim2.new(1, -40, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = Frame

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -80, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 20
CloseButton.Parent = Frame

local InputBox = Instance.new("TextBox")
InputBox.PlaceholderText = "Paste music code here..."
InputBox.Size = UDim2.new(0.9, 0, 0, 40)
InputBox.Position = UDim2.new(0.05, 0, 0.2, 0)
InputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InputBox.TextColor3 = Color3.fromRGB(0, 0, 0)
InputBox.Font = Enum.Font.SourceSans
InputBox.TextSize = 16
InputBox.Parent = Frame

local PlayButton = Instance.new("TextButton")
PlayButton.Text = "Play"
PlayButton.Size = UDim2.new(0.4, 0, 0, 40)
PlayButton.Position = UDim2.new(0.05, 0, 0.4, 0)
PlayButton.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
PlayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayButton.Font = Enum.Font.SourceSansBold
PlayButton.TextSize = 20
PlayButton.Parent = Frame

local StopButton = Instance.new("TextButton")
StopButton.Text = "Stop"
StopButton.Size = UDim2.new(0.4, 0, 0, 40)
StopButton.Position = UDim2.new(0.55, 0, 0.4, 0)
StopButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.Font = Enum.Font.SourceSansBold
StopButton.TextSize = 20
StopButton.Parent = Frame

local Slider = Instance.new("Frame")
Slider.Size = UDim2.new(0.9, 0, 0, 10)
Slider.Position = UDim2.new(0.05, 0, 0.7, 0)
Slider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
Slider.Parent = Frame

local SliderButton = Instance.new("TextButton")
SliderButton.Size = UDim2.new(0, 15, 0, 15)
SliderButton.Position = UDim2.new(0, 0, -0.5, 0)
SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderButton.BorderSizePixel = 0
SliderButton.Parent = Slider

local Sound = Instance.new("Sound")
Sound.Parent = workspace
Sound.Looped = true
Sound.Volume = 1

local Minimized = false

MinimizeButton.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        Frame.Size = UDim2.new(0, 350, 0, 40)
        MinimizeButton.Text = "+"
    else
        Frame.Size = UDim2.new(0, 350, 0, 250)
        MinimizeButton.Text = "-"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    Sound:Stop()
    ScreenGui:Destroy()
end)

PlayButton.MouseButton1Click:Connect(function()
    local soundId = tonumber(InputBox.Text)
    if soundId then
        Sound.SoundId = "rbxassetid://" .. soundId
        Sound:Play()
    end
end)

StopButton.MouseButton1Click:Connect(function()
    Sound:Stop()
end)

SliderButton.MouseButton1Down:Connect(function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local sliderSize = Slider.AbsoluteSize.X
    local sliderPos = Slider.AbsolutePosition.X
    
    while mouse.Button1Down do
        local x = math.clamp(mouse.X - sliderPos, 0, sliderSize)
        local percent = x / sliderSize
        SliderButton.Position = UDim2.new(0, x, -0.5, 0)
        Sound.TimePosition = Sound.TimeLength * percent
        wait()
    end
end)
