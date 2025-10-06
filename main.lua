-- Ultimate Multi-Feature Script with Rayfield UI
-- Completely Original & Packed with Features
-- Created for Educational Purposes

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🚀 Ultimate Multi-Tool",
   LoadingTitle = "Loading Ultimate Script...",
   LoadingSubtitle = "by Original Developer",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "UltimateConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Variables
local originalWalkSpeed = 16
local originalJumpPower = 50
local originalGravity = 196.2
local flyEnabled = false
local noclipEnabled = false
local espEnabled = false
local fullbrightEnabled = false
local infiniteJumpEnabled = false
local loopConnections = {}

-- Player Tab
local PlayerTab = Window:CreateTab("👤 Player", nil)
local PlayerSection = PlayerTab:CreateSection("Movement")

local WalkSpeedSlider = PlayerTab:CreateSlider({
   Name = "Walk Speed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
      if Character and Character:FindFirstChild("Humanoid") then
         Character.Humanoid.WalkSpeed = Value
      end
   end,
})

local JumpPowerSlider = PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      if Character and Character:FindFirstChild("Humanoid") then
         Character.Humanoid.JumpPower = Value
      end
   end,
})

local InfiniteJumpToggle = PlayerTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJump",
   Callback = function(Value)
      infiniteJumpEnabled = Value
      if Value then
         loopConnections.InfiniteJump = UserInputService.JumpRequest:Connect(function()
            if Character and Character:FindFirstChild("Humanoid") then
               Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
         end)
      else
         if loopConnections.InfiniteJump then
            loopConnections.InfiniteJump:Disconnect()
         end
      end
   end,
})

local FlyToggle = PlayerTab:CreateToggle({
   Name = "Fly (E to toggle)",
   CurrentValue = false,
   Flag = "Fly",
   Callback = function(Value)
      flyEnabled = Value
      if not Value then
         if loopConnections.Fly then
            loopConnections.Fly:Disconnect()
         end
         if Character:FindFirstChild("HumanoidRootPart") then
            Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
         end
      else
         local flySpeed = 50
         loopConnections.Fly = RunService.Heartbeat:Connect(function()
            if flyEnabled and Character and Character:FindFirstChild("HumanoidRootPart") then
               local hrp = Character.HumanoidRootPart
               local cam = workspace.CurrentCamera
               local moveDirection = Vector3.new(0, 0, 0)
               
               if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                  moveDirection = moveDirection + (cam.CFrame.LookVector * flySpeed)
               end
               if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                  moveDirection = moveDirection - (cam.CFrame.LookVector * flySpeed)
               end
               if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                  moveDirection = moveDirection - (cam.CFrame.RightVector * flySpeed)
               end
               if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                  moveDirection = moveDirection + (cam.CFrame.RightVector * flySpeed)
               end
               if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                  moveDirection = moveDirection + Vector3.new(0, flySpeed, 0)
               end
               if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                  moveDirection = moveDirection - Vector3.new(0, flySpeed, 0)
               end
               
               hrp.Velocity = moveDirection
            end
         end)
      end
   end,
})

local NoclipToggle = PlayerTab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Flag = "Noclip",
   Callback = function(Value)
      noclipEnabled = Value
      if Value then
         loopConnections.Noclip = RunService.Stepped:Connect(function()
            if noclipEnabled and Character then
               for _, part in pairs(Character:GetDescendants()) do
                  if part:IsA("BasePart") then
                     part.CanCollide = false
                  end
               end
            end
         end)
      else
         if loopConnections.Noclip then
            loopConnections.Noclip:Disconnect()
         end
         if Character then
            for _, part in pairs(Character:GetDescendants()) do
               if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                  part.CanCollide = true
               end
            end
         end
      end
   end,
})

PlayerTab:CreateButton({
   Name = "Reset Character",
   Callback = function()
      if Character and Character:FindFirstChild("Humanoid") then
         Character.Humanoid.Health = 0
      end
   end,
})

-- World Tab
local WorldTab = Window:CreateTab("🌍 World", nil)
local WorldSection = WorldTab:CreateSection("Environment")

local GravitySlider = WorldTab:CreateSlider({
   Name = "Gravity",
   Range = {0, 500},
   Increment = 1,
   Suffix = "Force",
   CurrentValue = 196.2,
   Flag = "Gravity",
   Callback = function(Value)
      workspace.Gravity = Value
   end,
})

local TimeSlider = WorldTab:CreateSlider({
   Name = "Time of Day",
   Range = {0, 24},
   Increment = 0.1,
   Suffix = "Hour",
   CurrentValue = 14,
   Flag = "TimeOfDay",
   Callback = function(Value)
      Lighting.ClockTime = Value
   end,
})

local FullbrightToggle = WorldTab:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Flag = "Fullbright",
   Callback = function(Value)
      fullbrightEnabled = Value
      if Value then
         Lighting.Brightness = 2
         Lighting.ClockTime = 14
         Lighting.FogEnd = 100000
         Lighting.GlobalShadows = false
         Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
      else
         Lighting.Brightness = 1
         Lighting.FogEnd = 100000
         Lighting.GlobalShadows = true
         Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
      end
   end,
})

WorldTab:CreateButton({
   Name = "Remove Fog",
   Callback = function()
      Lighting.FogEnd = 999999
   end,
})

WorldTab:CreateButton({
   Name = "Day Time",
   Callback = function()
      Lighting.ClockTime = 14
   end,
})

WorldTab:CreateButton({
   Name = "Night Time",
   Callback = function()
      Lighting.ClockTime = 0
   end,
})

-- Visual Tab
local VisualTab = Window:CreateTab("👁️ Visual", nil)
local VisualSection = VisualTab:CreateSection("ESP & Visuals")

local function createESP(player)
   if player == Player then return end
   
   local character = player.Character
   if not character then return end
   
   local highlight = Instance.new("Highlight")
   highlight.Name = "ESP_Highlight"
   highlight.Adornee = character
   highlight.FillColor = Color3.fromRGB(255, 0, 0)
   highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
   highlight.FillTransparency = 0.5
   highlight.OutlineTransparency = 0
   highlight.Parent = character
end

local function removeESP(player)
   if player.Character then
      local highlight = player.Character:FindFirstChild("ESP_Highlight")
      if highlight then
         highlight:Destroy()
      end
   end
end

local ESPToggle = VisualTab:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Flag = "ESP",
   Callback = function(Value)
      espEnabled = Value
      if Value then
         for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
               createESP(player)
            end
         end
         loopConnections.ESPAdded = Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
               if espEnabled then
                  wait(0.5)
                  createESP(player)
               end
            end)
         end)
      else
         for _, player in pairs(Players:GetPlayers()) do
            removeESP(player)
         end
         if loopConnections.ESPAdded then
            loopConnections.ESPAdded:Disconnect()
         end
      end
   end,
})

VisualTab:CreateButton({
   Name = "Remove Textures (Low Graphics)",
   Callback = function()
      for _, v in pairs(workspace:GetDescendants()) do
         if v:IsA("Texture") or v:IsA("Decal") then
            v.Transparency = 1
         end
      end
   end,
})

-- Teleport Tab
local TeleportTab = Window:CreateTab("📍 Teleport", nil)
local TeleportSection = TeleportTab:CreateSection("Quick Teleports")

TeleportTab:CreateButton({
   Name = "Teleport to Random Player",
   Callback = function()
      local players = Players:GetPlayers()
      local randomPlayer = players[math.random(1, #players)]
      if randomPlayer ~= Player and randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") then
         Player.Character.HumanoidRootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame
      end
   end,
})

TeleportTab:CreateButton({
   Name = "Teleport to Spawn",
   Callback = function()
      local spawnLocation = workspace:FindFirstChild("SpawnLocation")
      if spawnLocation and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
         Player.Character.HumanoidRootPart.CFrame = spawnLocation.CFrame + Vector3.new(0, 3, 0)
      end
   end,
})

local TeleportInput = TeleportTab:CreateInput({
   Name = "Teleport to Player",
   PlaceholderText = "Enter player name",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      for _, player in pairs(Players:GetPlayers()) do
         if string.lower(player.Name):find(string.lower(Text)) or string.lower(player.DisplayName):find(string.lower(Text)) then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
               Player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
               break
            end
         end
      end
   end,
})

-- Misc Tab
local MiscTab = Window:CreateTab("⚙️ Misc", nil)
local MiscSection = MiscTab:CreateSection("Utilities")

MiscTab:CreateButton({
   Name = "Rejoin Server",
   Callback = function()
      game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
   end,
})

MiscTab:CreateButton({
   Name = "Server Hop",
   Callback = function()
      local servers = {}
      local req = game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
      local body = game:GetService("HttpService"):JSONDecode(req)
      
      if body and body.data then
         for i, v in next, body.data do
            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
               table.insert(servers, v.id)
            end
         end
      end
      
      if #servers > 0 then
         game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], Player)
      end
   end,
})

MiscTab:CreateButton({
   Name = "Copy Game Link",
   Callback = function()
      setclipboard("https://www.roblox.com/games/"..game.PlaceId)
      Rayfield:Notify({
         Title = "Copied!",
         Content = "Game link copied to clipboard",
         Duration = 3,
         Image = nil,
      })
   end,
})

local AntiAFKToggle = MiscTab:CreateToggle({
   Name = "Anti-AFK",
   CurrentValue = false,
   Flag = "AntiAFK",
   Callback = function(Value)
      if Value then
         local vu = game:GetService("VirtualUser")
         loopConnections.AntiAFK = Player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
         end)
      else
         if loopConnections.AntiAFK then
            loopConnections.AntiAFK:Disconnect()
         end
      end
   end,
})

-- Credits Tab
local CreditsTab = Window:CreateTab("ℹ️ Info", nil)
CreditsTab:CreateSection("About This Script")

CreditsTab:CreateParagraph({
   Title = "Ultimate Multi-Tool",
   Content = "A completely original multi-feature script with Rayfield UI. Created for educational purposes and personal game development."
})

CreditsTab:CreateLabel("Version: 1.0.0")
CreditsTab:CreateLabel("Made with ❤️")

-- Notification
Rayfield:Notify({
   Title = "Script Loaded!",
   Content = "Ultimate Multi-Tool is ready to use",
   Duration = 5,
   Image = nil,
})

-- Cleanup on character respawn
Player.CharacterAdded:Connect(function(char)
   Character = char
   Humanoid = char:WaitForChild("Humanoid")
   RootPart = char:WaitForChild("HumanoidRootPart")
   
   -- Reapply settings
   wait(0.5)
   if Rayfield.Flags.WalkSpeed then
      Humanoid.WalkSpeed = Rayfield.Flags.WalkSpeed.CurrentValue
   end
   if Rayfield.Flags.JumpPower then
      Humanoid.JumpPower = Rayfield.Flags.JumpPower.CurrentValue
   end
end)
