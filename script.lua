local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local NameInput = Instance.new("TextBox")
local StartBtn = Instance.new("TextButton")
local IntroText = Instance.new("TextLabel") -- نڤیسینا مەزن یا ناڤێ تە

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Size = UDim2.new(0, 220, 0, 160)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Text = "EUFXN9 HUB ⚡"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 0)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

NameInput.Parent = MainFrame
NameInput.PlaceholderText = "Username یێ بەرامبەر..."
NameInput.Position = UDim2.new(0.1, 0, 0.3, 0)
NameInput.Size = UDim2.new(0.8, 0, 0, 30)

StartBtn.Parent = MainFrame
StartBtn.Text = "دەستپێ بکە"
StartBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
StartBtn.Size = UDim2.new(0.8, 0, 0, 45)
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)

-- دروستکرنا نڤیسینا مەزن (Intro)
IntroText.Parent = ScreenGui
IntroText.Size = UDim2.new(1, 0, 0.2, 0)
IntroText.Position = UDim2.new(0, 0, 0.4, 0)
IntroText.BackgroundTransparency = 1
IntroText.Text = "MADE BY EUFXN9"
IntroText.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroText.TextSize = 80 -- قەبارێ مەزن
IntroText.Font = Enum.Font.SourceSansBold
IntroText.TextStrokeTransparency = 0
IntroText.Visible = false -- ل دەستپێکێ یا بەرزەیە

local Orbiting = false
local CurrentTarget = nil
local Speed = 85
local Radius = 5
local Angle = 0

StartBtn.MouseButton1Click:Connect(function()
    if not Orbiting then
        -- نیشاندانا ناڤێ تە ب شێوەیەکێ مەزن
        IntroText.Visible = true
        StartBtn.Visible = false -- دوگمە بەرزە دبیت تا ناڤ دچیت
        
        task.wait(2) -- بۆ ٢ چرکە دمینیت
        
        IntroText.Visible = false
        StartBtn.Visible = true
        Orbiting = true
        
        StartBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        CurrentTarget = game.Players.LocalPlayer
        StartBtn.Text = "Owner Mode..."
        
        task.delay(2, function()
            if Orbiting then
                local Target = game.Players:FindFirstChild(NameInput.Text)
                if Target then
                    CurrentTarget = Target
                    StartBtn.Text = "Target: " .. Target.DisplayName
                else
                    Orbiting = false
                    StartBtn.Text = "ناڤ نەهاتە دیتن!"
                    wait(1)
                    StartBtn.Text = "دەستپێ بکە"
                end
            end
        end)
    else
        Orbiting = false
        StartBtn.Text = "دەستپێ بکە"
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if Orbiting and CurrentTarget and CurrentTarget.Character then
        local LP = game.Players.LocalPlayer
        local T_Root = CurrentTarget.Character:FindFirstChild("HumanoidRootPart")
        local My_Root = LP.Character:FindFirstChild("HumanoidRootPart")
        
        if T_Root and My_Root then
            LP.Character.Humanoid.PlatformStand = true
            My_Root.Velocity = Vector3.new(0, 0, 0)
            
            Angle = Angle + (Speed / 100)
            local x = math.cos(Angle) * Radius
            local z = math.sin(Angle) * Radius
            
            My_Root.CFrame = CFrame.new(T_Root.Position + Vector3.new(x, 1.5, z), T_Root.Position)
        end
    end
end)
