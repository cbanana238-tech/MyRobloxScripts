-- Creator: eufxn9 (Re-animate & Public Swap)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- ١. نڤێسینا Creator ل نیڤا شاشێ
local welcomeGui = Instance.new("ScreenGui", player.PlayerGui)
local welcomeLabel = Instance.new("TextLabel", welcomeGui)
welcomeLabel.Size = UDim2.new(0, 400, 0, 100)
welcomeLabel.Position = UDim2.new(0.5, -200, 0.35, 0)
welcomeLabel.Text = "Creator: eufxn9\n(Re-animate Active)"
welcomeLabel.TextColor3 = Color3.fromRGB(255, 140, 0)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.TextSize = 45
welcomeLabel.Font = Enum.Font.SourceSansBold
task.delay(5, function() welcomeGui:Destroy() end)

-- ٢. سیستەمێ Netless (دا سێرڤەر ڕێ بدەت خەڵک ببینن)
local function MakeNetless(part)
    local velocity = Instance.new("BodyVelocity")
    velocity.Velocity = Vector3.new(0, 25.1, 0) -- ئەڤە هێزا Physics بلند دکەت
    velocity.MaxForce = Vector3.new(0, 9e9, 0)
    velocity.Parent = part
    
    game:GetService("RunService").Heartbeat:Connect(function()
        part.Velocity = Vector3.new(0, 25.1, 0)
    end)
end

-- ٣. دروستکرنا دوگمەیا تێکدانێ
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 220, 0, 55)
button.Position = UDim2.new(0.5, -110, 0.8, 0)
button.Text = "Public Swap (Visible)"
button.BackgroundColor3 = Color3.fromRGB(255, 69, 0)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20

button.MouseButton1Click:Connect(function()
    -- چالاککرنا Netless بۆ هەمی پارچان
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") then
            MakeNetless(v)
        end
    end

    -- تێکدانا جۆینتان (Swap)
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("Motor6D") and (v.Name == "Neck" or v.Name == "RightHip" or v.Name == "Right Hip") then
            v.C0 = v.C0 * CFrame.new(0, -2, 0) * CFrame.Angles(math.rad(180), 0, 0)
        end
    end
    
    button.Text = "Swapped for Everyone! ✅"
    button.BackgroundColor3 = Color3.fromRGB(0, 180, 50)
end)
