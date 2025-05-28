-- Auto Clicker GUI for Mobile - by ChatGPT
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "MobileAutoClickGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 180)
frame.Position = UDim2.new(0, 30, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Auto Click - Mobile"
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Toggle Button
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0.9, 0, 0, 40)
toggle.Position = UDim2.new(0.05, 0, 0, 40)
toggle.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
toggle.Text = "BẬT AUTO CLICK"
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.GothamBold
toggle.TextScaled = true

-- Speed Label
local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Position = UDim2.new(0.05, 0, 0, 90)
speedLabel.Size = UDim2.new(0.9, 0, 0, 20)
speedLabel.Text = "Tốc độ: 0.1s (10 click/s)"
speedLabel.TextColor3 = Color3.new(1,1,1)
speedLabel.BackgroundTransparency = 1
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextScaled = true

-- Slider
local slider = Instance.new("TextButton", frame)
slider.Size = UDim2.new(0.9, 0, 0, 30)
slider.Position = UDim2.new(0.05, 0, 0, 115)
slider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
slider.TextColor3 = Color3.new(1,1,1)
slider.Font = Enum.Font.GothamBold
slider.TextScaled = true
slider.Text = "⬅ Giảm | Tăng ➡"

-- Variables
local auto = false
local delayTime = 0.1

local success, clickEvent = pcall(function()
    return game:GetService("ReplicatedStorage"):WaitForChild("ClickEvent")
end)

-- Toggle Auto Click
toggle.MouseButton1Click:Connect(function()
    auto = not auto
    toggle.Text = auto and "TẮT AUTO CLICK" or "BẬT AUTO CLICK"
    toggle.BackgroundColor3 = auto and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(100, 200, 100)
end)

-- Slider Control
slider.MouseButton1Click:Connect(function()
    -- Mỗi lần bấm, tăng giảm delayTime luân phiên
    delayTime = delayTime - 0.02
    if delayTime < 0.01 then delayTime = 0.3 end
    local cps = math.floor(1 / delayTime)
    speedLabel.Text = string.format("Tốc độ: %.2fs (%d click/s)", delayTime, cps)
end)

-- Auto Click Loop
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
