local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 220, 0, 50)
button.Position = UDim2.new(0.5, -110, 0.8, 0)
button.Text = "No-Death Swap (Safe)"
button.BackgroundColor3 = Color3.fromRGB(0, 150, 255) -- ڕەنگێ شین

button.MouseButton1Click:Connect(function()
    local head = char:FindFirstChild("Head")
    -- ل دویف قاچێ دگەڕێین چ R6 بیت یان R15
    local leg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightUpperLeg")

    if head and leg then
        -- ل ڤێرە تەنێ مە ب "CFrame" جهێ وان گوهۆڕی بێی بڕینا جۆینتان دا تو نەمری
        local tempCF = head.CFrame
        head.CFrame = leg.CFrame
        leg.CFrame = tempCF
        
        button.Text = "Swapped! (Still Alive)"
    end
end)
