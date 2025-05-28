-- Giao diện Auto Click đẹp mắt cho mobile
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "AutoClickGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 280, 0, 200)
frame.Position = UDim2.new(0, 20, 0, 120)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.BackgroundTransparency = 0.1
frame.AnchorPoint = Vector2.new(0, 0)

local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "💥 Auto Click Mobile"
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0.9, 0, 0, 40)
toggle.Position = UDim2.new(0.05, 0, 0, 40)
toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
toggle.Text = "🔘 BẬT AUTO CLICK"
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.TextScaled = true
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 12)

local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Position = UDim2.new(0.05, 0, 0, 90)
speedLabel.Size = UDim2.new(0.9, 0, 0, 25)
speedLabel.Text = "⏱️ Tốc độ: 0.10s (10 lần/giây)"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.BackgroundTransparency = 1
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextScaled = true

local slowerBtn = Instance.new("TextButton", frame)
slowerBtn.Position = UDim2.new(0.05, 0, 0, 125)
slowerBtn.Size = UDim2.new(0.4, 0, 0, 35)
slowerBtn.Text = "⬅ Giảm"
slowerBtn.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
slowerBtn.TextColor3 = Color3.new(1, 1, 1)
slowerBtn.Font = Enum.Font.GothamBold
slowerBtn.TextScaled = true
Instance.new("UICorner", slowerBtn).CornerRadius = UDim.new(0, 10)

local fasterBtn = Instance.new("TextButton", frame)
fasterBtn.Position = UDim2.new(0.55, 0, 0, 125)
fasterBtn.Size = UDim2.new(0.4, 0, 0, 35)
fasterBtn.Text = "Tăng ➡"
fasterBtn.BackgroundColor3 = Color3.fromRGB(80, 160, 255)
fasterBtn.TextColor3 = Color3.new(1, 1, 1)
fasterBtn.Font = Enum.Font.GothamBold
fasterBtn.TextScaled = true
Instance.new("UICorner", fasterBtn).CornerRadius = UDim.new(0, 10)

-- Logic
local auto = false
local delayTime = 0.10

local success, clickEvent = pcall(function()
    return game:GetService("ReplicatedStorage"):WaitForChild("ClickEvent")
end)

toggle.MouseButton1Click:Connect(function()
    auto = not auto
    toggle.Text = auto and "⛔ TẮT AUTO CLICK" or "🔘 BẬT AUTO CLICK"
    toggle.BackgroundColor3 = auto and Color3.fromRGB(200, 80, 80) or Color3.fromRGB(0, 170, 127)
end)

fasterBtn.MouseButton1Click:Connect(function()
    delayTime = math.max(0.01, delayTime - 0.01)
    local cps = math.floor(1 / delayTime)
    speedLabel.Text = string.format("⏱️ Tốc độ: %.2fs (%d lần/giây)", delayTime, cps)
end)

slowerBtn.MouseButton1Click:Connect(function()
    delayTime = math.min(0.5, delayTime + 0.01)
    local cps = math.floor(1 / delayTime)
    speedLabel.Text = string.format("⏱️ Tốc độ: %.2fs (%d lần/giây)", delayTime, cps)
end)

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
