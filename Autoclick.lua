-- GUI: Auto Clicker cho Roblox
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "AutoClickerGUI"

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 140)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Auto Click Gym"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Toggle Button
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0.9, 0, 0, 35)
toggle.Position = UDim2.new(0.05, 0, 0, 40)
toggle.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
toggle.Text = "BẬT AUTO CLICK"
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.TextScaled = true
toggle.Font = Enum.Font.GothamBold

-- Speed Slider
local slider = Instance.new("TextLabel", frame)
slider.Size = UDim2.new(0.9, 0, 0, 30)
slider.Position = UDim2.new(0.05, 0, 0, 85)
slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
slider.TextColor3 = Color3.new(1, 1, 1)
slider.Text = "Tốc độ: 0.1s (10 clicks/s)"
slider.TextScaled = true
slider.Font = Enum.Font.Gotham

-- Variables
local auto = false
local delayTime = 0.1

-- FireServer target
local success, clickEvent = pcall(function()
    return game:GetService("ReplicatedStorage"):WaitForChild("ClickEvent")
end)

-- Toggle logic
toggle.MouseButton1Click:Connect(function()
    auto = not auto
    if auto then
        toggle.Text = "TẮT AUTO CLICK"
        toggle.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    else
        toggle.Text = "BẬT AUTO CLICK"
        toggle.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    end
end)

-- Speed adjust using keyboard (Left/Right Arrow)
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Right then
        delayTime = math.max(0.01, delayTime - 0.01)
    elseif input.KeyCode == Enum.KeyCode.Left then
        delayTime = math.min(1, delayTime + 0.01)
    end
    slider.Text = string.format("Tốc độ: %.2fs (%.0f clicks/s)", delayTime, 1/delayTime)
end)

-- Auto click loop
task.spawn(function()
    while true do
        if auto and success and clickEvent then
            pcall(function()
                clickEvent:FireServer()
            end)
        end
        task.wait(delayTime)
    end
end)
