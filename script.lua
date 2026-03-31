local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- دروستکرنا نڤێسینا Creator ل نیڤا شاشێ
local welcomeGui = Instance.new("ScreenGui", player.PlayerGui)
local welcomeLabel = Instance.new("TextLabel", welcomeGui)
welcomeLabel.Size = UDim2.new(0, 300, 0, 50)
welcomeLabel.Position = UDim2.new(0.5, -150, 0.4, 0) -- ل نیڤا شاشێ
welcomeLabel.Text = "Creator: eufxn9"
welcomeLabel.TextColor3 = Color3.new(1, 1, 1) -- سپی
welcomeLabel.BackgroundTransparency = 1 -- بێ پشتخانە
welcomeLabel.TextSize = 40
welcomeLabel.Font = Enum.Font.SourceSansBold

-- پشتی ٤ چرکەیا دێ ون بیت
task.delay(4, function()
    welcomeGui:Destroy()
end)

-- ئەڤە ژی دوگمەیا تە یا پڕتەقاڵی
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, 0)
button.Text = "Swap Body (Universal)"
button.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
button.TextColor3 = Color3.new(1, 1, 1)

button.MouseButton1Click:Connect(function()
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("Motor6D") and (v.Name == "Neck" or v.Name == "RightHip" or v.Name == "Right Hip") then
            v.C0 = v.C0 * CFrame.new(0, -1.5, 0)
            v.C1 = v.C1 * CFrame.new(0, 1.5, 0)
        end
    end
    button.Text = "Done! (Swapped)"
end)
