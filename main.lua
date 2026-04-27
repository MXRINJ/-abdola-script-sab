local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
   Name = "Abdola Script",
   LoadingTitle = "Abdola Script",
   LoadingSubtitle = "By: Abdola",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   KeySystem = false,
})

local Main = Window:CreateTab("Main", 4483362458)
local ESPTab = Window:CreateTab("ESC", 4483362458)

-- Infinite Jump
local infJump = false

Main:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(v)
      infJump = v
   end,
})

UIS.JumpRequest:Connect(function()
   if infJump then
      local char = LocalPlayer.Character
      if char then
         local hum = char:FindFirstChildOfClass("Humanoid")
         if hum then hum:ChangeState("Jumping") end
      end
   end
end)

-- WalkSpeed
local speed = 16

Main:CreateInput({
   Name = "Walk Speed Amount",
   PlaceholderText = "Number",
   Callback = function(txt)
      speed = tonumber(txt) or 16
   end,
})

Main:CreateButton({
   Name = "Enable Walk Speed",
   Callback = function()
      local char = LocalPlayer.Character
      if char then
         local hum = char:FindFirstChildOfClass("Humanoid")
         if hum then hum.WalkSpeed = speed end
      end
   end,
})

-- Fly (FIXED URL)
Main:CreateButton({
   Name = "Fly",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/RadeonScripts/Universal/refs/heads/main/FlyScript"))()
   end,
})

-- Invisible (better version)
local invisible = false

local function applyInvisible(char)
   for _,v in pairs(char:GetDescendants()) do
      if v:IsA("BasePart") or v:IsA("Decal") then
         v.Transparency = invisible and 1 or 0
      end
   end
end

Main:CreateButton({
   Name = "Become Invisible",
   Callback = function()
      invisible = not invisible
      local char = LocalPlayer.Character
      if char then
         applyInvisible(char)
      end
   end,
})

LocalPlayer.CharacterAdded:Connect(function(char)
   wait(1)
   if invisible then
      applyInvisible(char)
   end
end)

-- ESP SETTINGS
local espColor = Color3.fromRGB(255,0,0)
local espType = "Box"
local espEnabled = false

-- Color Picker
ESPTab:CreateColorPicker({
   Name = "Choose Color",
   Color = espColor,
   Callback = function(c)
      espColor = c
   end
})

-- Type Selector
ESPTab:CreateDropdown({
   Name = "Choose Type",
   Options = {"Box","Circle"},
   CurrentOption = "Box",
   Callback = function(opt)
      espType = opt
   end
})

-- Apply ESP
local function applyESP(char)
   if not espEnabled then return end
   if not char or char:FindFirstChild("ESP_Highlight") then return end

   local hl = Instance.new("Highlight")
   hl.Name = "ESP_Highlight"
   hl.FillColor = espColor
   hl.OutlineColor = espColor
   hl.Parent = char

   if espType == "Circle" then
      hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
   end
end

-- Start ESP
ESPTab:CreateButton({
   Name = "Start",
   Callback = function()
      espEnabled = true

      for _,plr in pairs(Players:GetPlayers()) do
         if plr ~= LocalPlayer then

            -- existing character
            if plr.Character then
               applyESP(plr.Character)
            end

            -- future spawns (no spam connections)
            if not plr:FindFirstChild("ESP_Connected") then
               local tag = Instance.new("BoolValue")
               tag.Name = "ESP_Connected"
               tag.Parent = plr

               plr.CharacterAdded:Connect(function(char)
                  wait(1)
                  applyESP(char)
               end)
            end
         end
      end
   end,
})
