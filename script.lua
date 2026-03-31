local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- ئەڤە ئەو نامەیە کو ل خوارێ دیار دبیت دەما تو سکرێپتی ڤەدکەی
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Script Loaded!";
    Text = "Creator: eufxn9";
    Duration = 5;
})

local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, 0)
button.Text = "Swap Body (Universal)"
button.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20

button.MouseButton1Click:Connect(function()
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("Motor6D") and (v.Name == "Neck" or v.Name == "RightHip" or v.Name == "Right Hip") then
            v.C0 = v.C0 * CFrame.new(0, -1.5, 0)
            v.C1 = v.C1 * CFrame.new(0, 1.5, 0)
        end
    end
    button.Text = "Done! (Swapped)"
end)
