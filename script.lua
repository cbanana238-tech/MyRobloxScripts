local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

-- دروستکرنا دوگمەیێ
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 220, 0, 50)
button.Position = UDim2.new(0.5, -110, 0.8, 0)
button.Text = "Swap Body (R6/R15)"
button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20

-- پاراستنا دوگمەیێ پشتی مرنێ
screenGui.ResetOnSpawn = false

button.MouseButton1Click:Connect(function()
    local head = char:FindFirstChild("Head")
    
    if hum.RigType == Enum.HumanoidRigType.R6 then
        -- ئەگەر R6 بوو
        local torso = char:FindFirstChild("Torso")
        local rLeg = char:FindFirstChild("Right Leg")
        if head and torso and rLeg then
            if torso:FindFirstChild("Neck") then torso.Neck.Part1 = rLeg end
            if torso:FindFirstChild("Right Hip") then torso["Right Hip"].Part1 = head end
            button.Text = "R6 Swapped!"
        end
        
    elseif hum.RigType == Enum.HumanoidRigType.R15 then
        -- ئەگەر R15 بوو
        local rUpperLeg = char:FindFirstChild("RightUpperLeg")
        if head and rUpperLeg then
            -- ل R15 باشترین ڕێکا "Server Side" گوهۆڕینا Attachment-انە
            local neck = head:FindFirstChild("Neck")
            local hip = rUpperLeg:FindFirstChild("RightHip")
            if neck and hip then
                neck.Part1 = rUpperLeg
                hip.Part1 = head
                button.Text = "R15 Swapped!"
            end
        end
    end
end)
