local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, 0)
button.Text = "Swap Body (Universal)"
button.BackgroundColor3 = Color3.fromRGB(255, 165, 0) -- ڕەنگێ پڕتەقاڵی

button.MouseButton1Click:Connect(function()
    local head = char:FindFirstChild("Head")
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("LowerTorso")
    
    if head and torso then
        -- ئەڤە ڕێکا هەرە ب هێزە: گوهۆڕینا CFrame ب لێزانی
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("Motor6D") and (v.Name == "Neck" or v.Name == "RightHip" or v.Name == "Right Hip") then
                -- ل ڤێرە ئەم جهێ پارچان دگوهۆڕین بێی بڕینا جۆینتان
                v.C0 = v.C0 * CFrame.new(0, -1.5, 0) -- پارچە دچیتە خوار
                v.C1 = v.C1 * CFrame.new(0, 1.5, 0) -- پارچە دچیتە سەر
            end
        end
        button.Text = "Done! (Swapped)"
    else
        warn("Body parts not found!")
    end
end)
