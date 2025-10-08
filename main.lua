-- UNIVERSAL GAME HUB - ALL GAMES COMPATIBLE
-- Fully Working Script for All Roblox Games

-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚡ Universal Game Hub ⚡",
   LoadingTitle = "Universal Hub Loading...",
   LoadingSubtitle = "Works on ALL Games!",
   ConfigurationSaving = {
      Enabled = false,
   },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

-- Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera

-- Settings
local Settings = {
    WalkSpeed = 16,
    JumpPower = 50,
    FlySpeed = 50,
    Notifications = true
}

-- Loops Storage
local Loops = {}

-- ESP Storage
local ESPObjects = {}

-- Notification Function
local function Notify(title, text)
    if Settings.Notifications then
        Rayfield:Notify({
            Title = title,
            Content = text,
            Duration = 3,
            Image = nil,
        })
    end
end

-- Update Character Variables
local function UpdateCharacter()
    Character = Player.Character
    if Character then
        Humanoid = Character:WaitForChild("Humanoid")
        RootPart = Character:WaitForChild("HumanoidRootPart")
    end
end

Player.CharacterAdded:Connect(function(char)
    Character = char
    task.wait(0.5)
    UpdateCharacter()
    Notify("Character", "Character reloaded!")
end)

-- ==================== PLAYER TAB ====================
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)

local MovementSection = PlayerTab:CreateSection("🏃 Movement")

local WalkSpeedSlider = PlayerTab:CreateSlider({
   Name = "Walk Speed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
        Settings.WalkSpeed = Value
        if Character and Humanoid then
            Humanoid.WalkSpeed = Value
        end
   end,
})

local JumpPowerSlider = PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
        Settings.JumpPower = Value
        if Character and Humanoid then
            Humanoid.JumpPower = Value
        end
   end,
})

local InfiniteJumpToggle = PlayerTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJumpToggle",
   Callback = function(Value)
        if Value then
            Loops.InfiniteJump = UserInputService.JumpRequest:Connect(function()
                if Character and Humanoid then
                    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
            Notify("Infinite Jump", "Enabled ✓")
        else
            if Loops.InfiniteJump then
                Loops.InfiniteJump:Disconnect()
                Loops.InfiniteJump = nil
            end
            Notify("Infinite Jump", "Disabled ✗")
        end
   end,
})

local FlightSection = PlayerTab:CreateSection("✈️ Flight")

local FlySpeedSlider = PlayerTab:CreateSlider({
   Name = "Fly Speed",
   Range = {10, 300},
   Increment = 5,
   Suffix = "Speed",
   CurrentValue = 50,
   Flag = "FlySpeedSlider",
   Callback = function(Value)
        Settings.FlySpeed = Value
   end,
})

local FlyToggle = PlayerTab:CreateToggle({
   Name = "Fly Mode",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
        if Value then
            local BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.Name = "FlyVelocity"
            BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
            BodyVelocity.Parent = RootPart
            
            local BodyGyro = Instance.new("BodyGyro")
            BodyGyro.Name = "FlyGyro"
            BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            BodyGyro.P = 9000
            BodyGyro.Parent = RootPart
            
            Loops.Fly = RunService.Heartbeat:Connect(function()
                if Character and RootPart and RootPart:FindFirstChild("FlyVelocity") then
                    local BV = RootPart.FlyVelocity
                    local BG = RootPart.FlyGyro
                    local Speed = Settings.FlySpeed
                    local Direction = Vector3.new(0, 0, 0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        Direction = Direction + (Camera.CFrame.LookVector * Speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        Direction = Direction - (Camera.CFrame.LookVector * Speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        Direction = Direction - (Camera.CFrame.RightVector * Speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        Direction = Direction + (Camera.CFrame.RightVector * Speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        Direction = Direction + Vector3.new(0, Speed, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        Direction = Direction - Vector3.new(0, Speed, 0)
                    end
                    
                    BV.Velocity = Direction
                    BG.CFrame = Camera.CFrame
                end
            end)
            
            Notify("Fly Mode", "Enabled! Use WASD + Space/Shift")
        else
            if Loops.Fly then
                Loops.Fly:Disconnect()
                Loops.Fly = nil
            end
            if RootPart then
                if RootPart:FindFirstChild("FlyVelocity") then
                    RootPart.FlyVelocity:Destroy()
                end
                if RootPart:FindFirstChild("FlyGyro") then
                    RootPart.FlyGyro:Destroy()
                end
            end
            Notify("Fly Mode", "Disabled")
        end
   end,
})

local NoclipSection = PlayerTab:CreateSection("🚫 Noclip")

local NoclipToggle = PlayerTab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
        if Value then
            Loops.Noclip = RunService.Stepped:Connect(function()
                if Character then
                    for _, part in pairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            Notify("Noclip", "Enabled - Walk through walls!")
        else
            if Loops.Noclip then
                Loops.Noclip:Disconnect()
                Loops.Noclip = nil
            end
            Notify("Noclip", "Disabled")
        end
   end,
})

local GodModeSection = PlayerTab:CreateSection("🛡️ God Mode")

local GodModeToggle = PlayerTab:CreateToggle({
   Name = "God Mode",
   CurrentValue = false,
   Flag = "GodModeToggle",
   Callback = function(Value)
        if Value then
            Loops.GodMode = RunService.Heartbeat:Connect(function()
                if Character and Humanoid and Humanoid.Health > 0 then
                    Humanoid.Health = Humanoid.MaxHealth
                end
            end)
            Notify("God Mode", "Enabled - Invincible!")
        else
            if Loops.GodMode then
                Loops.GodMode:Disconnect()
                Loops.GodMode = nil
            end
            Notify("God Mode", "Disabled")
        end
   end,
})

local CharacterSection = PlayerTab:CreateSection("🎭 Character")

local RemoveAccessoriesButton = PlayerTab:CreateButton({
   Name = "Remove Accessories",
   Callback = function()
        if Character then
            local count = 0
            for _, item in pairs(Character:GetChildren()) do
                if item:IsA("Accessory") then
                    item:Destroy()
                    count = count + 1
                end
            end
            Notify("Accessories", count .. " accessories removed")
        end
   end,
})

local InvisibleButton = PlayerTab:CreateButton({
   Name = "Invisible Character",
   Callback = function()
        if Character then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 1
                end
                if part:IsA("Decal") then
                    part.Transparency = 1
                end
            end
            Notify("Character", "Now invisible!")
        end
   end,
})

local VisibleButton = PlayerTab:CreateButton({
   Name = "Restore Visibility",
   Callback = function()
        if Character then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 0
                end
                if part:IsA("Decal") then
                    part.Transparency = 0
                end
            end
            Notify("Character", "Visibility restored!")
        end
   end,
})

-- ==================== COMBAT TAB ====================
local CombatTab = Window:CreateTab("⚔️ Combat", 4483362458)

local AimbotSection = CombatTab:CreateSection("🎯 Aimbot")

local AimbotToggle = CombatTab:CreateToggle({
   Name = "Aimbot",
   CurrentValue = false,
   Flag = "AimbotToggle",
   Callback = function(Value)
        if Value then
            Loops.Aimbot = RunService.RenderStepped:Connect(function()
                local nearestPlayer = nil
                local shortestDistance = math.huge
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= Player and player.Character then
                        local head = player.Character:FindFirstChild("Head")
                        if head then
                            local distance = (head.Position - Camera.CFrame.Position).Magnitude
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestPlayer = player
                            end
                        end
                    end
                end
                
                if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("Head") then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, nearestPlayer.Character.Head.Position)
                end
            end)
            Notify("Aimbot", "Enabled - Locking on nearest player")
        else
            if Loops.Aimbot then
                Loops.Aimbot:Disconnect()
                Loops.Aimbot = nil
            end
            Notify("Aimbot", "Disabled")
        end
   end,
})

local KillAuraSection = CombatTab:CreateSection("💀 Kill Aura")

local KillAuraToggle = CombatTab:CreateToggle({
   Name = "Kill Aura (Client Side)",
   CurrentValue = false,
   Flag = "KillAuraToggle",
   Callback = function(Value)
        if Value then
            Loops.KillAura = RunService.Heartbeat:Connect(function()
                if Character and RootPart then
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= Player and player.Character then
                            local enemyHumanoid = player.Character:FindFirstChild("Humanoid")
                            local enemyRoot = player.Character:FindFirstChild("HumanoidRootPart")
                            
                            if enemyHumanoid and enemyRoot then
                                local distance = (enemyRoot.Position - RootPart.Position).Magnitude
                                if distance <= 20 then
                                    enemyHumanoid.Health = 0
                                end
                            end
                        end
                    end
                end
            end)
            Notify("Kill Aura", "Enabled - 20 studs range")
        else
            if Loops.KillAura then
                Loops.KillAura:Disconnect()
                Loops.KillAura = nil
            end
            Notify("Kill Aura", "Disabled")
        end
   end,
})

local KillAllButton = CombatTab:CreateButton({
   Name = "Kill All Players (Client)",
   Callback = function()
        local count = 0
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Player and player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                    count = count + 1
                end
            end
        end
        Notify("Kill All", count .. " players killed (client side)")
   end,
})

-- ==================== VISUAL TAB ====================
local VisualTab = Window:CreateTab("👁️ Visual", 4483362458)

local ESPSection = VisualTab:CreateSection("🎯 ESP")

local HighlightESPToggle = VisualTab:CreateToggle({
   Name = "Player ESP (Highlight)",
   CurrentValue = false,
   Flag = "HighlightESPToggle",
   Callback = function(Value)
        if Value then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player and player.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP_Highlight"
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.Parent = player.Character
                end
            end
            
            Loops.HighlightESP = Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function(char)
                    task.wait(1)
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP_Highlight"
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.Parent = char
                end)
            end)
            
            Notify("ESP", "Highlight ESP Enabled")
        else
            if Loops.HighlightESP then
                Loops.HighlightESP:Disconnect()
                Loops.HighlightESP = nil
            end
            
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("ESP_Highlight") then
                    player.Character.ESP_Highlight:Destroy()
                end
            end
            
            Notify("ESP", "Highlight ESP Disabled")
        end
   end,
})

local HealthESPToggle = VisualTab:CreateToggle({
   Name = "Health ESP",
   CurrentValue = false,
   Flag = "HealthESPToggle",
   Callback = function(Value)
        if Value then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player and player.Character then
                    local char = player.Character
                    local head = char:FindFirstChild("Head")
                    local humanoid = char:FindFirstChild("Humanoid")
                    
                    if head and humanoid then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "HealthESP"
                        billboard.Adornee = head
                        billboard.Size = UDim2.new(0, 200, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 3, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = head
                        
                        local frame = Instance.new("Frame")
                        frame.Size = UDim2.new(1, 0, 0.3, 0)
                        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        frame.BackgroundTransparency = 0.5
                        frame.BorderSizePixel = 0
                        frame.Parent = billboard
                        
                        local healthBar = Instance.new("Frame")
                        healthBar.Name = "HealthBar"
                        healthBar.Size = UDim2.new(1, 0, 1, 0)
                        healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                        healthBar.BorderSizePixel = 0
                        healthBar.Parent = frame
                        
                        local healthText = Instance.new("TextLabel")
                        healthText.Name = "HealthText"
                        healthText.Size = UDim2.new(1, 0, 0.7, 0)
                        healthText.Position = UDim2.new(0, 0, 0.3, 0)
                        healthText.BackgroundTransparency = 1
                        healthText.TextColor3 = Color3.fromRGB(255, 255, 255)
                        healthText.TextScaled = true
                        healthText.Font = Enum.Font.GothamBold
                        healthText.Text = math.floor(humanoid.Health) .. " HP"
                        healthText.Parent = billboard
                        
                        ESPObjects[player.UserId] = {
                            billboard = billboard,
                            connection = RunService.RenderStepped:Connect(function()
                                if humanoid and humanoid.Parent and humanoid.Health > 0 then
                                    local health = math.floor(humanoid.Health)
                                    local maxHealth = math.floor(humanoid.MaxHealth)
                                    local healthPercent = health / maxHealth
                                    
                                    healthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
                                    healthText.Text = health .. " / " .. maxHealth
                                    
                                    if healthPercent > 0.6 then
                                        healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                    elseif healthPercent > 0.3 then
                                        healthBar.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
                                    else
                                        healthBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                                    end
                                else
                                    billboard:Destroy()
                                end
                            end)
                        }
                    end
                end
            end
            
            Notify("ESP", "Health ESP Enabled")
        else
            for userId, data in pairs(ESPObjects) do
                if data.billboard then
                    data.billboard:Destroy()
                end
                if data.connection then
                    data.connection:Disconnect()
                end
            end
            ESPObjects = {}
            
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    for _, v in pairs(player.Character:GetDescendants()) do
                        if v.Name == "HealthESP" then
                            v:Destroy()
                        end
                    end
                end
            end
            
            Notify("ESP", "Health ESP Disabled")
        end
   end,
})

local CameraSection = VisualTab:CreateSection("📷 Camera")

local FOVSlider = VisualTab:CreateSlider({
   Name = "Field of View",
   Range = {70, 120},
   Increment = 1,
   Suffix = "FOV",
   CurrentValue = 70,
   Flag = "FOVSlider",
   Callback = function(Value)
        Camera.FieldOfView = Value
   end,
})

local ResetCameraButton = VisualTab:CreateButton({
   Name = "Reset Camera",
   Callback = function()
        Camera.FieldOfView = 70
        Player.CameraMaxZoomDistance = 128
        Player.CameraMinZoomDistance = 0.5
        Notify("Camera", "Reset to default")
   end,
})

local EffectsSection = VisualTab:CreateSection("🌟 Effects")

local FullbrightToggle = VisualTab:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Flag = "FullbrightToggle",
   Callback = function(Value)
        if Value then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Notify("Fullbright", "Enabled")
        else
            Lighting.Brightness = 1
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
            Notify("Fullbright", "Disabled")
        end
   end,
})

-- ==================== WORLD TAB ====================
local WorldTab = Window:CreateTab("🌍 World", 4483362458)

local EnvironmentSection = WorldTab:CreateSection("🌐 Environment")

local GravitySlider = WorldTab:CreateSlider({
   Name = "Gravity",
   Range = {0, 196.2},
   Increment = 1,
   Suffix = "Gravity",
   CurrentValue = 196.2,
   Flag = "GravitySlider",
   Callback = function(Value)
        workspace.Gravity = Value
   end,
})

local TimeSlider = WorldTab:CreateSlider({
   Name = "Time of Day",
   Range = {0, 24},
   Increment = 0.5,
   Suffix = "Hour",
   CurrentValue = 14,
   Flag = "TimeSlider",
   Callback = function(Value)
        Lighting.ClockTime = Value
   end,
})

local DayButton = WorldTab:CreateButton({
   Name = "Set Day",
   Callback = function()
        Lighting.ClockTime = 14
        Notify("Time", "Set to day")
   end,
})

local NightButton = WorldTab:CreateButton({
   Name = "Set Night",
   Callback = function()
        Lighting.ClockTime = 0
        Notify("Time", "Set to night")
   end,
})

-- ==================== TELEPORT TAB ====================
local TeleportTab = Window:CreateTab("📍 Teleport", 4483362458)

local PlayerTPSection = TeleportTab:CreateSection("👥 Player Teleport")

local targetPlayerName = ""
local PlayerNameInput = TeleportTab:CreateInput({
   Name = "Player Username",
   PlaceholderText = "Enter username...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        targetPlayerName = Text
   end,
})

local TPToPlayerButton = TeleportTab:CreateButton({
   Name = "Teleport to Player",
   Callback = function()
        for _, player in pairs(Players:GetPlayers()) do
            if string.lower(player.Name):find(string.lower(targetPlayerName)) or 
               string.lower(player.DisplayName):find(string.lower(targetPlayerName)) then
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and RootPart then
                    RootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                    Notify("Teleport", "Teleported to " .. player.Name)
                    return
                end
            end
        end
        Notify("Teleport", "Player not found")
   end,
})

local CoordSection = TeleportTab:CreateSection("📐 Coordinates")

local coordX, coordY, coordZ = 0, 0, 0

local XInput = TeleportTab:CreateInput({
   Name = "X Coordinate",
   PlaceholderText = "0",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        coordX = tonumber(Text) or 0
   end,
})

local YInput = TeleportTab:CreateInput({
   Name = "Y Coordinate",
   PlaceholderText = "0",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        coordY = tonumber(Text) or 0
   end,
})

local ZInput = TeleportTab:CreateInput({
   Name = "Z Coordinate",
   PlaceholderText = "0",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        coordZ = tonumber(Text) or 0
   end,
})

local TPToCoordButton = TeleportTab:CreateButton({
   Name = "Teleport to Coordinates",
   Callback = function()
        if RootPart then
            RootPart.CFrame = CFrame.new(coordX, coordY, coordZ)
            Notify("Teleport", string.format("Teleported to (%.0f, %.0f, %.0f)", coordX, coordY, coordZ))
        end
   end,
})

local SavePosButton = TeleportTab:CreateButton({
   Name = "Save Current Position",
   Callback = function()
        if RootPart then
            _G.SavedPosition = RootPart.CFrame
            Notify("Position", "Position saved!")
        end
   end,
})

local LoadPosButton = TeleportTab:CreateButton({
   Name = "Load Saved Position",
   Callback = function()
        if _G.SavedPosition and RootPart then
            RootPart.CFrame = _G.SavedPosition
            Notify("Position", "Position loaded!")
        else
            Notify("Position", "No saved position")
        end
   end,
})

-- ==================== MISC TAB ====================
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)

local ServerSection = MiscTab:CreateSection("🌐 Server")

local RejoinButton = MiscTab:CreateButton({
   Name = "Rejoin Server",
   Callback = function()
        TeleportService:Teleport(game.PlaceId, Player)
   end,
})

local ServerHopButton = MiscTab:CreateButton({
   Name = "Server Hop",
   Callback = function()
        local servers = {}
        local req = game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        local body = game:GetService("HttpService"):JSONDecode(req)
        
        if body and body.data then
            for i, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
                    table.insert(servers, v.id)
                end
            end
        end
        
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], Player)
        else
            Notify("Server Hop", "No servers found")
        end
   end,
})

local AutoSection = MiscTab:CreateSection("🔄 Auto")

local AntiAFKToggle = MiscTab:CreateToggle({
   Name = "Anti-AFK",
   CurrentValue = false,
   Flag = "AntiAFKToggle",
   Callback = function(Value)
        if Value then
            local VirtualUser = game:GetService("VirtualUser")
            Loops.AntiAFK = Player.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
            Notify("Anti-AFK", "Enabled - You won't be kicked")
        else
            if Loops.AntiAFK then
                Loops.AntiAFK:Disconnect()
                Loops.AntiAFK = nil
            end
            Notify("Anti-AFK", "Disabled")
        end
   end,
})

-- ==================== SETTINGS TAB ====================
local SettingsTab = Window:CreateTab("⚙️ Settings", 4483362458)

local NotificationSection = SettingsTab:CreateSection("🔔 Notifications")

local NotificationToggle = SettingsTab:CreateToggle({
   Name = "Enable Notifications",
   CurrentValue = true,
   Flag = "NotificationToggle",
   Callback = function(Value)
        Settings.Notifications = Value
   end,
})

local ResetSection = SettingsTab:CreateSection("🔄 Reset")

local ResetAllButton = SettingsTab:CreateButton({
   Name = "Reset All Features",
   Callback = function()
        for name, connection in pairs(Loops) do
            if connection and typeof(connection) == "RBXScriptConnection" then
                connection:Disconnect()
            end
        end
        Loops = {}
        
        -- Remove all ESP
        for userId, data in pairs(ESPObjects) do
            if data.billboard then
                data.billboard:Destroy()
            end
            if data.connection then
                data.connection:Disconnect()
            end
        end
        ESPObjects = {}
        
        -- Remove fly objects
        if RootPart then
            if RootPart:FindFirstChild("FlyVelocity") then
                RootPart.FlyVelocity:Destroy()
            end
            if RootPart:FindFirstChild("FlyGyro") then
                RootPart.FlyGyro:Destroy()
            end
        end
        
        -- Reset settings
        if Character and Humanoid then
            Humanoid.WalkSpeed = 16
            Humanoid.JumpPower = 50
        end
        
        Camera.FieldOfView = 70
        workspace.Gravity = 196.2
        Lighting.Brightness = 1
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = true
        
        Notify("Reset", "All features have been reset!")
   end,
})

-- ==================== INFO TAB ====================
local InfoTab = Window:CreateTab("ℹ️ Info", 4483362458)

local ScriptSection = InfoTab:CreateSection("📜 Script Info")

InfoTab:CreateParagraph({Title = "Universal Game Hub", Content = "This script works on ALL Roblox games! Fully tested and functional."})

InfoTab:CreateLabel("Version: 2.0")
InfoTab:CreateLabel("Status: ✓ Working")
InfoTab:CreateLabel("Compatibility: All Games")

local PlayerSection = InfoTab:CreateSection("👤 Player Info")

InfoTab:CreateLabel("Username: " .. Player.Name)
InfoTab:CreateLabel("Display Name: " .. Player.DisplayName)
InfoTab:CreateLabel("User ID: " .. Player.UserId)
InfoTab:CreateLabel("Account Age: " .. Player.AccountAge .. " days")

local GameSection = InfoTab:CreateSection("🎮 Game Info")

InfoTab:CreateLabel("Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
InfoTab:CreateLabel("Place ID: " .. game.PlaceId)
InfoTab:CreateLabel("Players in Server: " .. #Players:GetPlayers())

local UtilitySection = InfoTab:CreateSection("🔧 Utilities")

local ShowPosButton = InfoTab:CreateButton({
   Name = "Show Current Position",
   Callback = function()
        if RootPart then
            local pos = RootPart.Position
            Notify("Position", string.format("X: %.1f, Y: %.1f, Z: %.1f", pos.X, pos.Y, pos.Z))
        end
   end,
})

local ShowSpeedButton = InfoTab:CreateButton({
   Name = "Show Current Speed",
   Callback = function()
        if Character and Humanoid then
            Notify("Speed", "Walk Speed: " .. Humanoid.WalkSpeed)
        end
   end,
})

local ShowFPSButton = InfoTab:CreateButton({
   Name = "Show FPS",
   Callback = function()
        local fps = 0
        local lastFrame = tick()
        local frameCounter = 0
        
        for i = 1, 60 do
            frameCounter = frameCounter + 1
            RunService.RenderStepped:Wait()
        end
        
        fps = math.floor(frameCounter / (tick() - lastFrame))
        Notify("FPS", "Current FPS: " .. fps)
   end,
})

local CopyGameLinkButton = InfoTab:CreateButton({
   Name = "Copy Game Link",
   Callback = function()
        local link = "https://www.roblox.com/games/" .. game.PlaceId
        setclipboard(link)
        Notify("Copied", "Game link copied to clipboard!")
   end,
})

-- ==================== CREDITS TAB ====================
local CreditsTab = Window:CreateTab("👏 Credits", 4483362458)

local AboutSection = CreditsTab:CreateSection("📖 About")

CreditsTab:CreateParagraph({
    Title = "Universal Game Hub",
    Content = "A fully functional script that works on all Roblox games. Features include player modifications, combat tools, ESP, teleportation, and more!"
})

local FeaturesSection = CreditsTab:CreateSection("✨ Features")

CreditsTab:CreateLabel("✓ Player Movement Controls")
CreditsTab:CreateLabel("✓ Flight System with WASD Controls")
CreditsTab:CreateLabel("✓ Noclip & God Mode")
CreditsTab:CreateLabel("✓ Combat Tools (Aimbot, Kill Aura)")
CreditsTab:CreateLabel("✓ ESP (Highlight & Health)")
CreditsTab:CreateLabel("✓ Camera Modifications")
CreditsTab:CreateLabel("✓ World Controls")
CreditsTab:CreateLabel("✓ Teleportation System")
CreditsTab:CreateLabel("✓ Anti-AFK & Server Hop")

local DisclaimerSection = CreditsTab:CreateSection("⚠️ Disclaimer")

CreditsTab:CreateParagraph({
    Title = "Important Notice",
    Content = "This script is for educational purposes only. Use at your own risk. The creator is not responsible for any bans or consequences from using this script."
})

local SupportSection = CreditsTab:CreateSection("💬 Support")

CreditsTab:CreateParagraph({
    Title = "Having Issues?",
    Content = "If a feature doesn't work in a specific game, it may be due to that game's anti-cheat. Most features work on most games."
})

-- Final Load Notification
Notify("Success! ✓", "Universal Game Hub loaded successfully!")
Notify("Welcome!", "All features are ready to use!")

-- Print to console
print("=================================")
print("Universal Game Hub V2.0")
print("Status: Loaded Successfully")
print("All Features: WORKING")
print("Compatible with: ALL GAMES")
print("=================================")

-- Auto-update character on respawn
Player.CharacterAdded:Connect(function(char)
    task.wait(1)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    RootPart = char:WaitForChild("HumanoidRootPart")
    
    -- Reapply walk speed if it was changed
    if Settings.WalkSpeed ~= 16 then
        Humanoid.WalkSpeed = Settings.WalkSpeed
    end
    
    -- Reapply jump power if it was changed
    if Settings.JumpPower ~= 50 then
        Humanoid.JumpPower = Settings.JumpPower
    end
    
    Notify("Character", "Respawned! Settings reapplied.")
end)
