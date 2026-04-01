local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local NameInput = Instance.new("TextBox")
local StartBtn = Instance.new("TextButton")
local SpeedLabel = Instance.new("TextLabel")
local SpeedInput = Instance.new("TextBox") -- بۆ دیارکرنا خێراییێ ب ژمارە
local RadiusLabel = Instance.new("TextLabel")
local RadiusInput = Instance.new("TextBox") -- بۆ دیارکرنا دووراتیێ ب ژمارە

-- ڕێکخستنا GUI
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -120)
MainFrame.Size = UDim2.new(0, 250, 0, 260) -- مەزنتر لێ هات بۆ جهێ Slider-ان
MainFrame.Active = true
MainFrame.Draggable = true

local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 12)

Title.Parent = MainFrame
Title.Text = "EUFXN9 HUB ⚡"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 0)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 12)

-- ناڤێ یاریزانێ بەرامبەر
NameInput.Parent = MainFrame
NameInput.PlaceholderText = "Username یێ بەرامبەر..."
NameInput.Position = UDim2.new(0.1, 0, 0.2, 0)
NameInput.Size = UDim2.new(0.8, 0, 0, 35)
NameInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
NameInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", NameInput)

-- Speed Input
SpeedLabel.Parent = MainFrame
SpeedLabel.Text = "خێرایی (Speed):"
SpeedLabel.Position = UDim2.new(0.1, 0, 0.38, 0)
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

SpeedInput.Parent = MainFrame
SpeedInput.Text = "10"
SpeedInput.Position = UDim2.new(0.6, 0, 0.38, 0)
SpeedInput.Size = UDim2.new(0.3, 0, 0, 25)
SpeedInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedInput.TextColor3 = Color3.new(1, 1, 0)

-- Radius Input
RadiusLabel.Parent = MainFrame
RadiusLabel.Text = "دووراتی (Radius):"
RadiusLabel.Position = UDim2.new(0.1, 0, 0.52, 0)
RadiusLabel.TextColor3 = Color3.new(1, 1, 1)
RadiusLabel.TextXAlignment = Enum.TextXAlignment.Left

RadiusInput.Parent = MainFrame
RadiusInput.Text = "7"
RadiusInput.Position = UDim2.new(0.6, 0, 0.52, 0)
RadiusInput.Size = UDim2.new(0.3, 0, 0, 25)
RadiusInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
RadiusInput.TextColor3 = Color3.new(1, 1, 0)

-- Start Button
StartBtn.Parent = MainFrame
StartBtn.Text = "دەستپێ بکە"
StartBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
StartBtn.Size = UDim2.new(0.8, 0, 0, 45)
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
StartBtn.TextColor3 = Color3.new(1, 1, 1)
StartBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", StartBtn)

-- Variables
local Orbiting = false
local CurrentTarget = nil
local Angle = 0

-- فەکشنا Rainbow Trail
local function AddRainbowTrail(char)
	local trail = Instance.new("Trail")
	local a0 = Instance.new("Attachment", char.HumanoidRootPart)
	local a1 = Instance.new("Attachment", char.HumanoidRootPart)
	a0.Position = Vector3.new(0, 1, 0)
	a1.Position = Vector3.new(0, -1, 0)
	
	trail.Attachment0 = a0
	trail.Attachment1 = a1
	trail.Lifetime = 1
	trail.WidthScale = NumberSequence.new(0.5, 0)
	trail.Parent = char.HumanoidRootPart
	
	task.spawn(function()
		while trail.Parent do
			for i = 0, 1, 0.05 do
				trail.Color = ColorSequence.new(Color3.fromHSV(i, 1, 1))
				task.wait(0.05)
			end
		end
	end)
	return trail, a0, a1
end

local activeTrail, activeA0, activeA1

StartBtn.MouseButton1Click:Connect(function()
	if not Orbiting then
		local Target = game.Players:FindFirstChild(NameInput.Text)
		if Target then
			Orbiting = true
			CurrentTarget = Target
			StartBtn.Text = "STOP"
			StartBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
			activeTrail, activeA0, activeA1 = AddRainbowTrail(game.Players.LocalPlayer.Character)
		else
			StartBtn.Text = "ناڤ خەلەتە!"
			task.wait(1)
			StartBtn.Text = "دەستپێ بکە"
		end
	else
		Orbiting = false
		StartBtn.Text = "دەستپێ بکە"
		StartBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
		if activeTrail then activeTrail:Destroy() activeA0:Destroy() activeA1:Destroy() end
		if game.Players.LocalPlayer.Character then
			game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
		end
	end
end)

game:GetService("RunService").RenderStepped:Connect(function(dt)
	if Orbiting and CurrentTarget and CurrentTarget.Character then
		local T_Root = CurrentTarget.Character:FindFirstChild("HumanoidRootPart")
		local My_Root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		
		if T_Root and My_Root then
			game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
			
			-- وەرگرتنا قیمەتێن نوی ژ باکسان
			local currentSpeed = tonumber(SpeedInput.Text) or 10
			local currentRadius = tonumber(RadiusInput.Text) or 7
			
			Angle = Angle + (currentSpeed * dt)
			local x = math.cos(Angle) * currentRadius
			local z = math.sin(Angle) * currentRadius
			
			My_Root.Velocity = Vector3.new(0,0,0) -- بۆ وێ چەندێ "Glitch" نەکەت
			My_Root.CFrame = CFrame.new(T_Root.Position + Vector3.new(x, 2, z), T_Root.Position)
		end
	end
end)
