local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- نڤێسینا ناڤێ تە (Creator)
local welcomeGui = Instance.new("ScreenGui", player.PlayerGui)
local welcomeLabel = Instance.new("TextLabel", welcomeGui)
welcomeLabel.Size = UDim2.new(0, 400, 0, 100)
welcomeLabel.Position = UDim2.new(0.5, -200, 0.3, 0)
welcomeLabel.Text = "Creator: eufxn9"
welcomeLabel.TextColor3 = Color3.new(1, 0.5, 0) -- پڕتەقاڵی
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.TextSize = 50
welcomeLabel.Font = Enum.Font.SourceSansBold

task.delay(4, function() welcomeGui:Destroy() end)

-- دوگمەیا تێکدانێ
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, 0)
button.Text = "Swap Body (Public)"
button.BackgroundColor3 = Color3.fromRGB(255, 100, 0)

button.MouseButton1Click:Connect(function()
    -- ئەڤە کارەکتەری دلەرزینیت دا هەمی ببینن (Glitch)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local velocity = Instance.new("BodyVelocity", hrp)
        velocity.Velocity = Vector3.new(0, 50, 0) -- کێمەکێ دای بلند کەت
        velocity.MaxForce = Vector3.new(0, 1000, 0)
        
        -- تێکدانا جۆینتان بۆ تە
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("Motor6D") and (v.Name == "Neck" or v.Name == "RightHip") then
                v.C0 = v.C0 * CFrame.new(0, -2, 0)
            end
        end
    end
    button.Text = "Swapped for ALL! ✅"
end)
