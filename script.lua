-- سکرێپتێ گوهۆڕینا جەستەی (بۆ هندێ خەلک ببینن)
local player = game.Players.LocalPlayer
local char = player.Character
if not char then return end

-- دروستکرنا دوگمەیێ
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, 0)
button.Text = "گوهۆڕینا جەستەی (Server Side)"
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

button.MouseButton1Click:Connect(function()
    -- ئەڤ بەشە هەوڵ ددەت Velocity و CFrame بکاربینیت دا خەلک ببینن
    local head = char:FindFirstChild("Head")
    local rLeg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightUpperLeg")

    if head and rLeg then
        -- ل ڤێرە مە گوهۆڕین یا کری، بەلێ هندەک یاری ڕێگریێ لێ دکەن
        head.CFrame = rLeg.CFrame * CFrame.new(0, 2, 0)
        rLeg.CFrame = char.Head.CFrame
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ئەنجام درا",
            Text = "هەوڵدەدەین خەڵکیش ببینن!",
            Duration = 3
        })
    end
end)
