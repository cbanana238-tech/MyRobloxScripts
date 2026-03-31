local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 220, 0, 50)
button.Position = UDim2.new(0.5, -110, 0.8, 0)
button.Text = "Swap Body (No Reset)"
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- ڕەنگێ سۆر

button.MouseButton1Click:Connect(function()
    local head = char:FindFirstChild("Head")
    local rLeg = char:FindFirstChild("RightUpperLeg")

    if head and rLeg then
        -- ل ڤێرە ئەم "Motor6D" نادەینە دەست دا تو نەمری
        -- تەنێ مە ب لێزانین جهێ وان گوهۆڕی ب رێکا Attachment
        local neck = head:FindFirstChild("Neck")
        local hip = rLeg:FindFirstChild("RightHip")

        if neck and hip then
            neck.CFrame = CFrame.new(0, -1, 0) -- سەر دچیتە خوار
            hip.CFrame = CFrame.new(0, 1.5, 0) -- قاچ دچیتە سەر
            button.Text = "R15 Fixed! ✅"
        end
    end
end)
