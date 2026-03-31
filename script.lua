local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, 0)
button.Text = "Full Swap (Head & Leg)"
button.BackgroundColor3 = Color3.fromRGB(255, 100, 0)

button.MouseButton1Click:Connect(function()
    for _, v in pairs(char:GetDescendants()) do
        -- ل ڤێرە مە ناڤێن قاچی (Right Hip) زێدەتر لێ کرن دا ب چو ڕەنگان خەلاس نەبیت
        if v:IsA("Motor6D") and (v.Name == "Neck" or v.Name == "RightHip" or v.Name == "Right Hip" or v.Name == "RightUpperLeg") then
            v.C0 = v.C0 * CFrame.new(0, -2.5, 0) -- پارچە دچیتە خوار
            v.C1 = v.C1 * CFrame.new(0, 2.5, 0)  -- پارچە دچیتە سەر
        end
    end
    button.Text = "Full Swapped! ✅"
end)
