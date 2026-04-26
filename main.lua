-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Window
local Window = Rayfield:CreateWindow({
    Name = "Abdola Script",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Made by: Abdola",
    ConfigurationSaving = {
        Enabled = false
    }
})

-- Tab
local Tab = Window:CreateTab("Main", 4483362458)

-- Player
local Player = game.Players.LocalPlayer

---------------------------------------------------
-- INFINITE JUMP
---------------------------------------------------
local infJumpEnabled = false

local InfJumpDesc = Tab:CreateParagraph({
    Title = "Infinite Jump",
    Content = "Jump endlessly with no limit and reach any height."
})
InfJumpDesc:Set(false)

Tab:CreateToggle({
    Name = "Infinite Jump (OFF/ON)",
    CurrentValue = false,
    Callback = function(Value)
        infJumpEnabled = Value
        InfJumpDesc:Set(Value)
    end,
})

-- Infinite Jump Logic
game:GetService("UserInputService").JumpRequest:Connect(function()
    if infJumpEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character:FindFirstChild("Humanoid"):ChangeState("Jumping")
    end
end)

---------------------------------------------------
-- WALK SPEED
---------------------------------------------------
local WalkDesc = Tab:CreateParagraph({
    Title = "Walk Speed",
    Content = "Adjust your movement speed to go faster than normal."
})
WalkDesc:Set(false)

local SpeedBox = Tab:CreateInput({
    Name = "Set Speed",
    PlaceholderText = "Enter speed (e.g. 50)",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        if tonumber(Text) and Player.Character then
            Player.Character:FindFirstChild("Humanoid").WalkSpeed = tonumber(Text)
        end
    end,
})
SpeedBox:Set(false)

local walkEnabled = false

Tab:CreateToggle({
    Name = "Walk Speed (OFF/ON)",
    CurrentValue = false,
    Callback = function(Value)
        walkEnabled = Value
        WalkDesc:Set(Value)
        SpeedBox:Set(Value)

        if not Value and Player.Character then
            Player.Character:FindFirstChild("Humanoid").WalkSpeed = 16
        end
    end,
})

---------------------------------------------------
-- INVISIBILITY
---------------------------------------------------
local InvisDesc = Tab:CreateParagraph({
    Title = "Become Invisible",
    Content = "Become fully invisible to others, even while holding tools."
})
InvisDesc:Set(false)

local invisible = false

Tab:CreateToggle({
    Name = "Become Invisible (OFF/ON)",
    CurrentValue = false,
    Callback = function(Value)
        invisible = Value
        InvisDesc:Set(Value)

        if Player.Character then
            for _, v in pairs(Player.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Transparency = Value and 1 or 0
                elseif v:IsA("Decal") then
                    v.Transparency = Value and 1 or 0
                end
            end
        end
    end,
})

---------------------------------------------------
-- CHARACTER RESPAWN FIX (reapply effects)
---------------------------------------------------
Player.CharacterAdded:Connect(function(char)
    wait(1)

    if walkEnabled then
        char:FindFirstChild("Humanoid").WalkSpeed = 50
    end

    if invisible then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = 1
            end
        end
    end
end)

Rayfield:Notify({
    Title = "Abdola Script",
    Content = "Successfully Loaded!",
    Duration = 5
})
