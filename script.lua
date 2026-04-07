local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local NameInput = Instance.new("TextBox")
local StartBtn = Instance.new("TextButton")
local ModeBtn = Instance.new("TextButton") 
local SpeedInput = Instance.new("TextBox")
local RadiusInput = Instance.new("TextBox")
local ToggleBtn = Instance.new("TextButton")

ScreenGui.Name = "EUFXN9_V9_CameraFixed"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- [ Button ⚡ ]
ToggleBtn.Parent = ScreenGui
ToggleBtn.Text = "⚡"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 10, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
ToggleBtn.TextColor3 = Color3.new(0, 0, 0)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 25
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

-- [ Main Frame ]
MainFrame.Parent = ScreenGui
MainFrame.Visible = false 
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -135)
MainFrame.Size = UDim2.new(0, 250, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

Title.Parent = MainFrame
Title.Text = "EUFXN9 HUB ⚡ V9"
Title.Size = UDim2.new(1, 0, 0, 45)
Title.TextColor3 = Color3.fromRGB(255, 255, 0)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 15)

NameInput.Parent = MainFrame
NameInput.PlaceholderText = "2-3 پیتان لێدە..."
NameInput.Position = UDim2.new(0.1, 0, 0.18, 0)
NameInput.Size = UDim2.new(0.8, 0, 0, 35)
NameInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
NameInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", NameInput)

SpeedInput.Parent = MainFrame
SpeedInput.Text = "15"
SpeedInput.Position = UDim2.new(0.1, 0, 0.35, 0)
SpeedInput.Size = UDim2.new(0.35, 0, 0, 30)
SpeedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", SpeedInput)

RadiusInput.Parent = MainFrame
RadiusInput.Text = "2.5" 
RadiusInput.Position = UDim2.new(0.55, 0, 0.35, 0)
RadiusInput.Size = UDim2.new(0.35, 0, 0, 30)
RadiusInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RadiusInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", RadiusInput)

ModeBtn.Parent = MainFrame
ModeBtn.Text = "Mode: Horizontal"
ModeBtn.Position = UDim2.new(0.1, 0, 0.52, 0)
ModeBtn.Size = UDim2.new(0.8, 0, 0, 35)
ModeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ModeBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", ModeBtn)

StartBtn.Parent = MainFrame
StartBtn.Text = "دەستپێ بکە"
StartBtn.Position = UDim2.new(0.1, 0, 0.72, 0)
StartBtn.Size = UDim2.new(0.8, 0, 0, 50)
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
StartBtn.TextColor3 = Color3.new(1, 1, 1)
StartBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", StartBtn)

-- [ Variables ]
local Orbiting = false
local CurrentTarget = nil
local Angle = 0
local OrbitMode = 1 

ModeBtn.MouseButton1Click:Connect(function()
    OrbitMode = OrbitMode + 1
    if OrbitMode > 5 then OrbitMode = 1 end
    local modes = {"Horizontal", "Vertical", "Face Spin", "Side (Zhno Mer)", "Bag (Hand)"}
    ModeBtn.Text = "Mode: " .. modes[OrbitMode]
end)

StartBtn.MouseButton1Click:Connect(function()
    if not Orbiting then
        local InputText = NameInput.Text:lower()
        if InputText == "" then return end
        
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then
                if p.Name:lower():sub(1, #InputText) == InputText or (p.DisplayName and p.DisplayName:lower():sub(1, #InputText) == InputText) then
                    CurrentTarget = p
                    break
                end
            end
        end

        if CurrentTarget and CurrentTarget.Character and CurrentTarget.Character:FindFirstChild("HumanoidRootPart") then
            Orbiting = true
            NameInput.Text = CurrentTarget.Name
            StartBtn.Text = "STOP"
            StartBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        else
            StartBtn.Text = "ناڤ نەهاتە دیتن!"
            task.wait(1)
            StartBtn.Text = "دەستپێ بکە"
        end
    else
        Orbiting = false
        CurrentTarget = nil
        StartBtn.Text = "دەستپێ بکە"
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
            game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
        end
    end
end)

game:GetService("RunService").RenderStepped:Connect(function(dt)
    if Orbiting and CurrentTarget and CurrentTarget.Character then
        local My_Char = game.Players.LocalPlayer.Character
        local My_Root = My_Char and My_Char:FindFirstChild("HumanoidRootPart")
        local T_Char = CurrentTarget.Character
        local T_Root = T_Char:FindFirstChild("HumanoidRootPart")
        local T_Head = T_Char:FindFirstChild("Head")
        local T_Hand = T_Char:FindFirstChild("Right Arm") or T_Char:FindFirstChild("RightHand") or T_Char:FindFirstChild("UpperTorso")
        
        if My_Root and T_Root and T_Head then
            -- [ Camera Fix ]
            local Camera = game.Workspace.CurrentCamera
            if Camera.CameraSubject ~= My_Char.Humanoid then
                Camera.CameraSubject = My_Char.Humanoid
            end
            
            local s = tonumber(SpeedInput.Text) or 15
            local r = tonumber(RadiusInput.Text) or 2.5
            
            if OrbitMode == 4 then -- Side
                My_Char.Humanoid.PlatformStand = false
                My_Root.CFrame = T_Root.CFrame * CFrame.new(r, 0, 0)
            elseif OrbitMode == 5 then -- Bag
                My_Char.Humanoid.PlatformStand = true
                My_Root.Velocity = Vector3.new(0,0,0)
                My_Root.CFrame = T_Hand.CFrame * CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(90), 0, 0)
            else
                My_Char.Humanoid.PlatformStand = true
                My_Root.Velocity = Vector3.new(0,0,0)
                Angle = Angle + (s * dt)
                
                if OrbitMode == 1 then -- Horizontal
                    My_Root.CFrame = CFrame.new(T_Head.Position + Vector3.new(math.cos(Angle)*r, 1, math.sin(Angle)*r), T_Head.Position)
                elseif OrbitMode == 2 then -- Vertical
                    My_Root.CFrame = CFrame.new(T_Head.Position + Vector3.new(0, math.cos(Angle)*r, math.sin(Angle)*r), T_Head.Position)
                elseif OrbitMode == 3 then -- Face Spin
                    My_Root.CFrame = (T_Head.CFrame * CFrame.new(0, 0, -1.5)) * CFrame.Angles(0, 0, Angle)
                end
            end
        end
    else
        if Orbiting then
            Orbiting = false
            StartBtn.Text = "دەستپێ بکە"
            StartBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        end
    end
end)
