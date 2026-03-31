local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

local screenGui = Instance.new("ScreenGui", player.PlayerGui)

-- دوگمەیا تێکدانێ (Swap)
local swapBtn = Instance.new("TextButton", screenGui)
swapBtn.Size = UDim2.new(0, 180, 0, 50)
swapBtn.Position = UDim2.new(0.5, -190, 0.8, 0)
swapBtn.Text = "Swap Body"
swapBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)

-- دوگمەیا زڤڕاندنێ (Reset)
local resetBtn = Instance.new("TextButton", screenGui)
resetBtn.Size = UDim2.new(0, 180, 0, 50)
resetBtn.Position = UDim2.new(0.5, 10, 0.8, 0)
resetBtn.Text = "Back to Normal"
resetBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)

-- فەنکشنا تێکدانێ
swapBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("Motor6D") and (v.Name == "Neck" or v.Name == "RightHip" or v.Name == "Right Hip" or v.Name == "RightUpperLeg") then
            v.C0 = v.C0 * CFrame.new(0, -2.5, 0)
            v.C1 = v.C1 * CFrame.new(0, 2.5, 0)
        end
    end
end)

-- فەنکشنا زڤڕاندنێ (ئەڤە دێ تە زڤڕینیتە بارێ بەری)
resetBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("Motor6D") and (v.Name == "Neck" or v.Name == "RightHip" or v.Name == "Right Hip" or v.Name == "RightUpperLeg") then
            -- ل ڤێرە ئەم "C0" و "C1" دزڤڕینینە جهێ وان یێ ئەصلی
            v.C0 = v.Transform
            v.C1 = CFrame.new(0,0,0) -- جاران پێدڤییە ب ڤی ڕەنگی بیت
            -- ئەگەر کار نەکەت، ئەم دێ ب فەنکشنا "Refresh" چارەسەر کەین
            player:CharacterAppearanceLoaded():Wait()
        end
    end
    -- ڕێکا هەرە ب ساناهی بۆ زڤڕاندن ب بێ مرن:
    char.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
    swapBtn.Text = "Swap Again"
end)
