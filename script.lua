local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- نڤێسینا ناڤێ تە (Creator: eufxn9) دا هەمی بزانن
local welcomeGui = Instance.new("ScreenGui", player.PlayerGui)
local welcomeLabel = Instance.new("TextLabel", welcomeGui)
welcomeLabel.Size = UDim2.new(0, 400, 0, 100)
welcomeLabel.Position = UDim2.new(0.5, -200, 0.3, 0)
welcomeLabel.Text = "Creator: eufxn9"
welcomeLabel.TextColor3 = Color3.fromRGB(255, 100, 0)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.TextSize = 60
welcomeLabel.Font = Enum.Font.SourceSansBold
task.delay(5, function() welcomeGui:Destroy() end)

-- دوگمەیا تێکدانێ
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, 0)
button.Text = "Swap (VISIBLE TO ALL)"
button.BackgroundColor3 = Color3.fromRGB(255, 69, 0)

button.MouseButton1Click:Connect(function()
    -- ئەڤە بەشێ گرنگە: دانانا Velocity دا سێرڤەر و خەڵک ببینن
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = Vector3.new(0, 30, 0) -- کێمەکێ بلند دکەت بۆ تێکدانێ
            bv.MaxForce = Vector3.new(0, 500, 0)
            bv.Parent = part
        end
    end

    -- تێکدانا جۆینتان
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("Motor6D") and (v.Name == "Neck" or v.Name == "RightHip") then
            v.C0 = v.C0 * CFrame.new(0, -2, 0) * CFrame.Angles(math.rad(90), 0, 0)
        end
    end
    button.Text = "VISIBLE NOW! ✅"
end)
