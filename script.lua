local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local NameInput = Instance.new("TextBox")
local StartBtn = Instance.new("TextButton")
local ModeBtn = Instance.new("TextButton") 
local SpeedInput = Instance.new("TextBox")
local RadiusInput = Instance.new("TextBox")

-- [ GUI Setup ]
ScreenGui.Name = "EUFXN9_v3"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -135)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

Title.Parent = MainFrame
Title.Text = "EUFXN9 HUB ⚡ V3"
Title.Size = UDim2.new(1, 0, 0, 45)
Title.TextColor3 = Color3.fromRGB(255, 255, 0)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 15)

NameInput.Parent = MainFrame
NameInput.PlaceholderText = "Username یێ بەرامبەر..."
NameInput.Position = UDim2.new(0.1, 0, 0.2, 0)
NameInput.Size = UDim2.new(0.8, 0, 0, 35)
NameInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
NameInput.TextColor3 = Color3.new(1, 1, 1)
NameInput.Text = ""
Instance.new("UICorner", NameInput)

SpeedInput.Parent = MainFrame
SpeedInput.Text = "15"
SpeedInput.Position = UDim2.new(0.1, 0, 0.38, 0)
SpeedInput.Size = UDim2.new(0.35, 0, 0, 30)
SpeedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", SpeedInput)

RadiusInput.Parent = MainFrame
RadiusInput.Text = "5"
RadiusInput.Position = UDim2.new(0.55, 0, 0.38, 0)
RadiusInput.Size = UDim2.new(0.35, 0, 0, 30)
RadiusInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RadiusInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", RadiusInput)

ModeBtn.Parent = MainFrame
ModeBtn.Text = "Mode: Horizontal"
ModeBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
ModeBtn.Size = UDim2.new(0.8, 0, 0, 35)
ModeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ModeBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", ModeBtn)

StartBtn.Parent = MainFrame
StartBtn.Text = "دەستپێ بکە"
StartBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
StartBtn.Size = UDim2.new(0.8, 0, 0, 50)
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
StartBtn.TextColor3 = Color3.new(1, 1, 1)
StartBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", StartBtn)

-- Variables
local Orbiting = false
local CurrentTarget = nil
local Angle = 0
local OrbitMode = 1 -- 1: Horizontal, 2: Vertical, 3: Face Spin

ModeBtn.MouseButton1Click:Connect(function()
    OrbitMode = OrbitMode + 1
    if OrbitMode > 3 then OrbitMode = 1 end
    
    if OrbitMode == 1 then
        ModeBtn.Text = "Mode: Horizontal"
    elseif OrbitMode == 2 then
        ModeBtn.Text = "Mode: Vertical"
    elseif OrbitMode == 3 then
        ModeBtn.Text = "Mode: Face Spin (بەر چاڤێن وی)"
    end
end)

StartBtn.MouseButton1Click:Connect(function()
    if not Orbiting then
        local Target = game.Players:FindFirstChild(NameInput.Text)
        if Target and Target.Character then
            Orbiting = true
            CurrentTarget = Target
            StartBtn.Text = "STOP"
            StartBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        else
            StartBtn.Text = "ناڤ خەلەتە!"
            task.wait(1)
            StartBtn.Text = "دەستپێ بکە"
        end
    else
        Orbiting = false
        StartBtn.Text = "دەستپێ بکە"
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
        end
    end
end)

game:GetService("RunService").RenderStepped:Connect(function(dt)
    if Orbiting and CurrentTarget and CurrentTarget.Character then
        local T_Head = CurrentTarget.Character:FindFirstChild("Head")
        local My_Char = game.Players.LocalPlayer.Character
        local My_Root = My_Char:FindFirstChild("HumanoidRootPart")
        
        if T_Head and My_Root then
            My_Char.Humanoid.PlatformStand = true
            My_Root.Velocity = Vector3.new(0,0,0)
            
            local s = tonumber(SpeedInput.Text) or 15
            local r = tonumber(RadiusInput.Text) or 5
            Angle = Angle + (s * dt)
            
            if OrbitMode == 1 then -- Horizontal
                My_Root.CFrame = CFrame.new(T_Head.Position + Vector3.new(math.cos(Angle)*r, 1, math.sin(Angle)*r), T_Head.Position)
            elseif OrbitMode == 2 then -- Vertical
                My_Root.CFrame = CFrame.new(T_Head.Position + Vector3.new(0, math.cos(Angle)*r, math.sin(Angle)*r), T_Head.Position)
            elseif OrbitMode == 3 then -- Face Spin (ئەو عەلەکێ تە دڤیا)
                -- 1.5 مەتر ل پێش چاڤێن وی
                local FacePos = T_Head.CFrame * CFrame.new(0, 0, -1.5)
                -- سۆڕان ل سەر تەوەرا Z دا وەک پەنکەکێ بسۆریت
                My_Root.CFrame = FacePos * CFrame.Angles(0, 0, Angle)
            end
        end
    end
end)
