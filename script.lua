local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- نڤێسینا Creator
local welcomeGui = Instance.new("ScreenGui", player.PlayerGui)
local welcomeLabel = Instance.new("TextLabel", welcomeGui)
welcomeLabel.Size = UDim2.new(0, 400, 0, 100)
welcomeLabel.Position = UDim2.new(0.5, -200, 0.4, 0)
welcomeLabel.Text = "Creator: eufxn9"
welcomeLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.TextSize = 40
welcomeLabel.Font = Enum.Font.SourceSansBold
task.delay(4, function() welcomeGui:Destroy() end)

local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, 0)
button.Text = "Swap (Simple Sync)"
button.BackgroundColor3 = Color3.fromRGB(255, 140, 0)

button.MouseButton1Click:Connect(function()
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("Motor6D") and (v.Name == "Neck" or v.Name == "RightHip") then
            v.C0 = v.C0 * CFrame.new(0, -1.8, 0)
        end
        -- تەنێ کێمەکێ Velocity دا سێرڤەر "Update" ببیت
        if v:IsA("BasePart") then
            v.Velocity = Vector3.new(0, 0.05, 0)
        end
    end
    button.Text = "Applied! ✅"
end)
