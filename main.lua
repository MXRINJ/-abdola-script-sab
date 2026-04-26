local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Abdola Script",
   LoadingTitle = "Abdola Script",
   LoadingSubtitle = "By: Abdola",
   ConfigurationSaving = {
      Enabled = false,
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

local Tab = Window:CreateTab("Main", 4483362458)

-- Infinite Jump
local infJumpEnabled = false

Tab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(Value)
      infJumpEnabled = Value
   end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
   if infJumpEnabled then
      game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

-- WalkSpeed
local walkSpeedAmount = 16

Tab:CreateInput({
   Name = "Walk Speed Amount",
   PlaceholderText = "Enter number",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      walkSpeedAmount = tonumber(Text) or 16
   end,
})

Tab:CreateButton({
   Name = "Enable Walk Speed",
   Callback = function()
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChildOfClass("Humanoid") then
         char:FindFirstChildOfClass("Humanoid").WalkSpeed = walkSpeedAmount
      end
   end,
})

-- Fly
local flying = false
local flySpeed = 50

Tab:CreateButton({
   Name = "Fly",
   Callback = function()
      flying = not flying

      local player = game.Players.LocalPlayer
      local char = player.Character
      local hrp = char:WaitForChild("HumanoidRootPart")

      if flying then
         local bv = Instance.new("BodyVelocity")
         bv.Name = "FlyVelocity"
         bv.MaxForce = Vector3.new(1e5,1e5,1e5)
         bv.Velocity = Vector3.new(0,0,0)
         bv.Parent = hrp

         game:GetService("RunService").RenderStepped:Connect(function()
            if flying and bv then
               local cam = workspace.CurrentCamera
               local moveDir = Vector3.new(0,0,0)

               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                  moveDir = moveDir + cam.CFrame.LookVector
               end
               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                  moveDir = moveDir - cam.CFrame.LookVector
               end
               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                  moveDir = moveDir - cam.CFrame.RightVector
               end
               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                  moveDir = moveDir + cam.CFrame.RightVector
               end

               bv.Velocity = moveDir * flySpeed
            end
         end)
      else
         if hrp:FindFirstChild("FlyVelocity") then
            hrp.FlyVelocity:Destroy()
         end
      end
   end,
})

Tab:CreateInput({
   Name = "Fly Speed Amount",
   PlaceholderText = "Enter number",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      flySpeed = tonumber(Text) or 50
   end,
})

Tab:CreateButton({
   Name = "Enable Fly Speed",
   Callback = function()
      -- Fly is already active, this just updates speed
      print("Fly speed set to:", flySpeed)
   end,
})
