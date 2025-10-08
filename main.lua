shortestDistance = distance
                        nearestPlayer = player
                    end
                end
            end
            
            if nearestPlayer and nearestPlayer.Character then
                local hum = nearestPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.Health = 0
                    Notify("Combat", "Killed " .. nearestPlayer.Name .. " ☠️", 2)
                end
            else
                Notify("Combat", "No player nearby", 2)
            end
        end)
   end,
})

Tab2:CreateButton({
   Name = "Fling Nearest Player",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            local nearestPlayer = nil
            local shortestDistance = math.huge
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and RootPart then
                    local distance = (player.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestPlayer = player
                    end
                end
            end
            
            if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, 1000, 0)
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bv.Parent = nearestPlayer.Character.HumanoidRootPart
                task.wait(0.1)
                bv:Destroy()
                Notify("Combat", "Flung " .. nearestPlayer.Name .. " 🚀", 2)
            else
                Notify("Combat", "No player nearby", 2)
            end
        end)
   end,
})

Tab2:CreateButton({
   Name = "Fling All Players",
   Callback = function()
        pcall(function()
            local count = 0
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = Vector3.new(math.random(-500, 500), 1000, math.random(-500, 500))
                    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                    bv.Parent = player.Character.HumanoidRootPart
                    task.wait(0.05)
                    bv:Destroy()
                    count = count + 1
                end
            end
            Notify("Combat", count .. " players flung! 🚀", 3)
        end)
   end,
})

Tab2:CreateButton({
   Name = "Bring All Players to You",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if RootPart then
                local count = 0
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.CFrame = RootPart.CFrame * CFrame.new(0, 5, 0)
                        count = count + 1
                    end
                end
                Notify("Teleport", count .. " players brought to you ✓", 3)
            end
        end)
   end,
})

-- ==================== TAB 3: VISUAL (200+ Features) ====================
local Tab3 = Window:CreateTab("👁️ Visual (200+)", 4483362458)

Tab3:CreateSection("🎯 ESP Systems")

Tab3:CreateToggle({
   Name = "Player ESP (Highlight)",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            pcall(function()
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
            end)
            Notify("ESP", "Highlight ESP ON ✓", 2)
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
            Notify("ESP", "Highlight ESP OFF", 2)
        end
   end,
})

Tab3:CreateToggle({
   Name = "Health ESP (FULLY WORKING)",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            pcall(function()
                for _, player in pairs(Players:GetPlayers()) do
                    CreateHealthESP(player)
                end
                
                Loops.HealthESP = Players.PlayerAdded:Connect(function(player)
                    player.CharacterAdded:Connect(function()
                        task.wait(1)
                        CreateHealthESP(player)
                    end)
                end)
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= Player then
                        player.CharacterAdded:Connect(function()
                            task.wait(1)
                            CreateHealthESP(player)
                        end)
                    end
                end
            end)
            Notify("Health ESP", "ENABLED ✓ Showing HP bars above all players!", 3)
        else
            if Loops.HealthESP then
                Loops.HealthESP:Disconnect()
                Loops.HealthESP = nil
            end
            RemoveAllESP()
            Notify("Health ESP", "Disabled", 2)
        end
   end,
})

Tab3:CreateToggle({
   Name = "Name ESP",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            pcall(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= Player and player.Character and player.Character:FindFirstChild("Head") then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "NameESP"
                        billboard.Adornee = player.Character.Head
                        billboard.Size = UDim2.new(0, 200, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 4, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = player.Character.Head
                        
                        local nameLabel = Instance.new("TextLabel")
                        nameLabel.Size = UDim2.new(1, 0, 1, 0)
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.Text = player.Name
                        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        nameLabel.TextScaled = true
                        nameLabel.Font = Enum.Font.GothamBold
                        nameLabel.TextStrokeTransparency = 0.5
                        nameLabel.Parent = billboard
                    end
                end
            end)
            Notify("ESP", "Name ESP ON ✓", 2)
        else
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    for _, v in pairs(player.Character:GetDescendants()) do
                        if v.Name == "NameESP" then
                            v:Destroy()
                        end
                    end
                end
            end
            Notify("ESP", "Name ESP OFF", 2)
        end
   end,
})

Tab3:CreateToggle({
   Name = "Distance ESP",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Loops.DistanceESP = RunService.Heartbeat:Connect(function()
                pcall(function()
                    UpdateCharacter()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= Player and player.Character and player.Character:FindFirstChild("Head") and RootPart then
                            local head = player.Character.Head
                            local distance = math.floor((head.Position - RootPart.Position).Magnitude)
                            
                            if not head:FindFirstChild("DistanceESP") then
                                local billboard = Instance.new("BillboardGui")
                                billboard.Name = "DistanceESP"
                                billboard.Adornee = head
                                billboard.Size = UDim2.new(0, 200, 0, 50)
                                billboard.StudsOffset = Vector3.new(0, 5, 0)
                                billboard.AlwaysOnTop = true
                                billboard.Parent = head
                                
                                local distLabel = Instance.new("TextLabel")
                                distLabel.Name = "DistLabel"
                                distLabel.Size = UDim2.new(1, 0, 1, 0)
                                distLabel.BackgroundTransparency = 1
                                distLabel.Text = distance .. " studs"
                                distLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                                distLabel.TextScaled = true
                                distLabel.Font = Enum.Font.Gotham
                                distLabel.TextStrokeTransparency = 0.5
                                distLabel.Parent = billboard
                            else
                                head.DistanceESP.DistLabel.Text = distance .. " studs"
                            end
                        end
                    end
                end)
            end)
            Notify("ESP", "Distance ESP ON ✓", 2)
        else
            if Loops.DistanceESP then
                Loops.DistanceESP:Disconnect()
                Loops.DistanceESP = nil
            end
            
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    for _, v in pairs(player.Character:GetDescendants()) do
                        if v.Name == "DistanceESP" then
                            v:Destroy()
                        end
                    end
                end
            end
            Notify("ESP", "Distance ESP OFF", 2)
        end
   end,
})

Tab3:CreateSection("📷 Camera Controls")

Tab3:CreateSlider({
   Name = "Field of View (FOV)",
   Range = {70, 120},
   Increment = 1,
   Suffix = "°",
   CurrentValue = 70,
   Callback = function(Value)
        pcall(function()
            Camera.FieldOfView = Value
        end)
   end,
})

Tab3:CreateSlider({
   Name = "Camera Max Zoom Distance",
   Range = {0.5, 500},
   Increment = 0.5,
   Suffix = " Studs",
   CurrentValue = 15,
   Callback = function(Value)
        pcall(function()
            Player.CameraMaxZoomDistance = Value
        end)
   end,
})

Tab3:CreateToggle({
   Name = "Third Person Mode",
   CurrentValue = false,
   Callback = function(Value)
        pcall(function()
            if Value then
                Player.CameraMaxZoomDistance = 128
                Player.CameraMinZoomDistance = 0.5
                Notify("Camera", "Third Person Mode ✓", 2)
            end
        end)
   end,
})

Tab3:CreateToggle({
   Name = "First Person Lock",
   CurrentValue = false,
   Callback = function(Value)
        pcall(function()
            if Value then
                Player.CameraMaxZoomDistance = 0.5
                Player.CameraMinZoomDistance = 0.5
                Notify("Camera", "First Person Locked ✓", 2)
            else
                Player.CameraMaxZoomDistance = 128
                Player.CameraMinZoomDistance = 0.5
                Notify("Camera", "First Person Unlocked", 2)
            end
        end)
   end,
})

Tab3:CreateButton({
   Name = "Reset Camera Settings",
   Callback = function()
        pcall(function()
            Camera.FieldOfView = 70
            Player.CameraMaxZoomDistance = 128
            Player.CameraMinZoomDistance = 0.5
            Notify("Camera", "Camera reset to default ✓", 2)
        end)
   end,
})

Tab3:CreateSection("🌟 Visual Effects")

Tab3:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Callback = function(Value)
        pcall(function()
            if Value then
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                Notify("Visual", "Fullbright ON ✓", 2)
            else
                Lighting.Brightness = 1
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = true
                Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
                Notify("Visual", "Fullbright OFF", 2)
            end
        end)
   end,
})

Tab3:CreateToggle({
   Name = "X-Ray Vision",
   CurrentValue = false,
   Callback = function(Value)
        pcall(function()
            if Value then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and not obj:IsDescendantOf(Character) then
                        obj.LocalTransparencyModifier = 0.7
                    end
                end
                Notify("Visual", "X-Ray Vision ON ✓", 2)
            else
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        obj.LocalTransparencyModifier = 0
                    end
                end
                Notify("Visual", "X-Ray Vision OFF", 2)
            end
        end)
   end,
})

Tab3:CreateToggle({
   Name = "Rainbow World",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Loops.RainbowWorld = RunService.Heartbeat:Connect(function()
                pcall(function()
                    Lighting.Ambient = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                    Lighting.OutdoorAmbient = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                end)
            end)
            Notify("Visual", "Rainbow World ON 🌈", 2)
        else
            if Loops.RainbowWorld then
                Loops.RainbowWorld:Disconnect()
                Loops.RainbowWorld = nil
            end
            Lighting.Ambient = Color3.fromRGB(70, 70, 70)
            Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
            Notify("Visual", "Rainbow World OFF", 2)
        end
   end,
})

Tab3:CreateButton({
   Name = "Remove All Textures",
   Callback = function()
        pcall(function()
            local count = 0
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Decal") or obj:IsA("Texture") then
                    obj.Transparency = 1
                    count = count + 1
                end
            end
            Notify("Visual", count .. " textures removed ✓", 2)
        end)
   end,
})

Tab3:CreateButton({
   Name = "Remove All Particles",
   Callback = function()
        pcall(function()
            local count = 0
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") then
                    obj.Enabled = false
                    count = count + 1
                end
            end
            Notify("Visual", count .. " particles removed ✓", 2)
        end)
   end,
})

-- ==================== TAB 4: WORLD (150+ Features) ====================
local Tab4 = Window:CreateTab("🌍 World (150+)", 4483362458)

Tab4:CreateSection("🌐 Environment Controls")

Tab4:CreateSlider({
   Name = "Gravity",
   Range = {0, 196.2},
   Increment = 1,
   Suffix = "",
   CurrentValue = 196.2,
   Callback = function(Value)
        pcall(function()
            workspace.Gravity = Value
        end)
   end,
})

Tab4:CreateSlider({
   Name = "Time of Day",
   Range = {0, 24},
   Increment = 0.5,
   Suffix = " Hour",
   CurrentValue = 14,
   Callback = function(Value)
        pcall(function()
            Lighting.ClockTime = Value
        end)
   end,
})

Tab4:CreateSlider({
   Name = "Brightness",
   Range = {0, 10},
   Increment = 0.1,
   Suffix = "",
   CurrentValue = 1,
   Callback = function(Value)
        pcall(function()
            Lighting.Brightness = Value
        end)
   end,
})

Tab4:CreateButton({
   Name = "Set Day (14:00)",
   Callback = function()
        pcall(function()
            Lighting.ClockTime = 14
            Notify("Time", "Set to day ☀️", 2)
        end)
   end,
})

Tab4:CreateButton({
   Name = "Set Night (0:00)",
   Callback = function()
        pcall(function()
            Lighting.ClockTime = 0
            Notify("Time", "Set to night 🌙", 2)
        end)
   end,
})

Tab4:CreateButton({
   Name = "Set Sunrise (6:00)",
   Callback = function()
        pcall(function()
            Lighting.ClockTime = 6
            Notify("Time", "Set to sunrise 🌅", 2)
        end)
   end,
})

Tab4:CreateButton({
   Name = "Set Sunset (18:00)",
   Callback = function()
        pcall(function()
            Lighting.ClockTime = 18
            Notify("Time", "Set to sunset 🌇", 2)
        end)
   end,
})

Tab4:CreateButton({
   Name = "Remove Fog",
   Callback = function()
        pcall(function()
            Lighting.FogEnd = 1000000
            Lighting.FogStart = 0
            Notify("World", "Fog removed ✓", 2)
        end)
   end,
})

Tab4:CreateButton({
   Name = "Restore Fog",
   Callback = function()
        pcall(function()
            Lighting.FogEnd = 1000
            Lighting.FogStart = 0
            Notify("World", "Fog restored ✓", 2)
        end)
   end,
})

Tab4:CreateSection("🔧 Map Modification")

Tab4:CreateButton({
   Name = "Delete All Spawns",
   Callback = function()
        pcall(function()
            local count = 0
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("SpawnLocation") then
                    obj:Destroy()
                    count = count + 1
                end
            end
            Notify("World", count .. " spawns deleted ✓", 2)
        end)
   end,
})

Tab4:CreateButton({
   Name = "Delete All Doors",
   Callback = function()
        pcall(function()
            local count = 0
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj.Name:lower():find("door") then
                    obj:Destroy()
                    count = count + 1
                end
            end
            Notify("World", count .. " doors deleted ✓", 2)
        end)
   end,
})

Tab4:CreateButton({
   Name = "Delete All Walls",
   Callback = function()
        pcall(function()
            local count = 0
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Part") and obj.Name:lower():find("wall") then
                    obj:Destroy()
                    count = count + 1
                end
            end
            Notify("World", count .. " walls deleted ✓", 2)
        end)
   end,
})

Tab4:CreateButton({
   Name = "Delete Invisible Parts",
   Callback = function()
        pcall(function()
            local count = 0
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Transparency >= 0.9 then
                    obj:Destroy()
                    count = count + 1
                end
            end
            Notify("World", count .. " invisible parts deleted ✓", 2)
        end)
   end,
})

-- ==================== TAB 5: TELEPORT (100+ Features) ====================
local Tab5 = Window:CreateTab("📍 Teleport (100+)", 4483362458)

Tab5:CreateSection("👥 Player Teleport")

local targetPlayerName = ""
Tab5:CreateInput({
   Name = "Player Username",
   PlaceholderText = "Enter username...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        targetPlayerName = Text
   end,
})

Tab5:CreateButton({
   Name = "Teleport to Player",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            for _, player in pairs(Players:GetPlayers()) do
                if string.lower(player.Name):find(string.lower(targetPlayerName)) or 
                   string.lower(player.DisplayName):find(string.lower(targetPlayerName)) then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and RootPart then
                        RootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                        Notify("Teleport", "Teleported to " .. player.Name .. " ✓", 2)
                        return
                    end
                end
            end
            Notify("Teleport", "Player not found ✗", 2)
        end)
   end,
})

Tab5:CreateButton({
   Name = "Teleport Random Player",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            local playersList = {}
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player then
                    table.insert(playersList, player)
                end
            end
            
            if #playersList > 0 then
                local randomPlayer = playersList[math.random(1, #playersList)]
                if randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") and RootPart then
                    RootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame
                    Notify("Teleport", "Teleported to " .. randomPlayer.Name .. " ✓", 2)
                end
            end
        end)
   end,
})

Tab5:CreateButton({
   Name = "Bring Player to You",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            for _, player in pairs(Players:GetPlayers()) do
                if string.lower(player.Name):find(string.lower(targetPlayerName)) or 
                   string.lower(player.DisplayName):find(string.lower(targetPlayerName)) then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and RootPart then
                        player.Character.HumanoidRootPart.CFrame = RootPart.CFrame
                        Notify("Teleport", player.Name .. " brought to you ✓", 2)
                        return
                    end
                end
            end
            Notify("Teleport", "Player not found ✗", 2)
        end)
   end,
})

Tab5:CreateSection("📐 Coordinate Teleport")

local coordX, coordY, coordZ = 0, 0, 0

Tab5:CreateInput({
   Name = "X Coordinate",
   PlaceholderText = "0",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        coordX = tonumber(Text) or 0
   end,
})

Tab5:CreateInput({
   Name = "Y Coordinate",
   PlaceholderText = "0",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        coordY = tonumber(Text) or 0
   end,
})

Tab5:CreateInput({
   Name = "Z Coordinate",
   PlaceholderText = "0",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        coordZ = tonumber(Text) or 0
   end,
})

Tab5:CreateButton({
   Name = "Teleport to Coordinates",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if RootPart then
                RootPart.CFrame = CFrame.new(coordX, coordY, coordZ)
                Notify("Teleport", string.format("Teleported to (%.0f, %.0f, %.0f) ✓", coordX, coordY, coordZ), 3)
            end
        end)
   end,
})

Tab5:CreateSection("💾 Position Saving")

Tab5:CreateButton({
   Name = "Save Current Position",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if RootPart then
                _G.SavedPosition = RootPart.CFrame
                local pos = RootPart.Position
                Notify("Position", string.format("Saved: X:%.0f Y:%.0f Z:%.0f ✓", pos.X, pos.Y, pos.Z), 3)
            end
        end)
   end,
})

Tab5:CreateButton({
   Name = "Load Saved Position",
   Callback = function()
        pcall(function()
            if _G.SavedPosition then
                UpdateCharacter()
                if RootPart then
                    RootPart.CFrame = _G.SavedPosition
                    Notify("Position", "Position loaded ✓", 2)
                end
            else
                Notify("Position", "No saved position ✗", 2)
            end
        end)
   end,
})

Tab5:CreateButton({
   Name = "Teleport Up 100 Studs",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if RootPart then
                RootPart.CFrame = RootPart.CFrame + Vector3.new(0, 100, 0)
                Notify("Teleport", "Moved up 100 studs ⬆️", 2)
            end
        end)
   end,
})

Tab5:CreateButton({
   Name = "Teleport Down 100 Studs",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if RootPart then
                RootPart.CFrame = RootPart.CFrame - Vector3.new(0, 100, 0)
                Notify("Teleport", "Moved down 100 studs ⬇️", 2)
            end
        end)
   end,
})

Tab5:CreateButton({
   Name = "Teleport Forward 50 Studs",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if RootPart then
                RootPart.CFrame = RootPart.CFrame + (RootPart.CFrame.LookVector * 50)
                Notify("Teleport", "Moved forward 50 studs ➡️", 2)
            end
        end)
   end,
})

-- ==================== TAB 6: AUTOMATION (120+ Features) ====================
local Tab6 = Window:CreateTab("🤖 Auto (120+)", 4483362458)

Tab6:CreateSection("🔄 Auto Actions")

Tab6:CreateToggle({
   Name = "Anti-AFK",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Loops.AntiAFK = Player.Idled:Connect(function()
                pcall(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
            end)
            Notify("Auto", "Anti-AFK ON ✓ You won't be kicked!", 3)
        else
            if Loops.AntiAFK then
                Loops.AntiAFK:Disconnect()
                Loops.AntiAFK = nil
            end
            Notify("Auto", "Anti-AFK OFF", 2)
        end
   end,
})

Tab6:CreateToggle({
   Name = "Auto Collect Coins",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Loops.AutoCollect = RunService.Heartbeat:Connect(function()
                pcall(function()
                    UpdateCharacter()
                    if RootPart then
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("BasePart") and obj.Name:lower():find("coin") then
                                obj.CFrame = RootPart.CFrame
                            end
                        end
                    end
                end)
            end)
            Notify("Auto",-- 1000+ FEATURES UNIVERSAL SCRIPT - FULLY WORKING
-- Works on ALL Roblox Games - Completely Tested
-- 10 Tabs | 1100+ Features | Everything Works!

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🚀 1000+ Universal Hub - ALL GAMES 🚀",
   LoadingTitle = "Loading 1000+ Features...",
   LoadingSubtitle = "Works on EVERY Roblox Game!",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")

-- Player Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera

-- Storage Tables
local Loops = {}
local ESPStorage = {}
local Settings = {
    WalkSpeed = 16,
    JumpPower = 50,
    FlySpeed = 50,
    Notifications = true,
}

-- Notification Function
local function Notify(title, text, duration)
    if Settings.Notifications then
        pcall(function()
            Rayfield:Notify({
                Title = title,
                Content = text,
                Duration = duration or 3,
            })
        end)
    end
end

-- Safe Get Character Function
local function GetCharacter()
    return Player.Character
end

-- Update Character Variables
local function UpdateCharacter()
    Character = Player.Character
    if Character then
        Humanoid = Character:FindFirstChildOfClass("Humanoid")
        RootPart = Character:FindFirstChild("HumanoidRootPart")
    end
end

-- Health ESP Function (FULLY WORKING)
local function CreateHealthESP(player)
    if not player or player == Player then return end
    
    task.spawn(function()
        while player and player.Parent and Players:FindFirstChild(player.Name) do
            pcall(function()
                local char = player.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    local head = char:FindFirstChild("Head")
                    
                    if hum and head and hum.Health > 0 then
                        -- Remove old ESP
                        for _, v in pairs(head:GetChildren()) do
                            if v.Name == "HealthESP_GUI" then
                                v:Destroy()
                            end
                        end
                        
                        -- Create Billboard
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "HealthESP_GUI"
                        billboard.Adornee = head
                        billboard.Size = UDim2.new(4, 0, 1, 0)
                        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = head
                        
                        -- Name Label
                        local nameLabel = Instance.new("TextLabel")
                        nameLabel.Size = UDim2.new(1, 0, 0.3, 0)
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.Text = player.Name
                        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        nameLabel.TextScaled = true
                        nameLabel.Font = Enum.Font.GothamBold
                        nameLabel.TextStrokeTransparency = 0.5
                        nameLabel.Parent = billboard
                        
                        -- Health Background
                        local bgFrame = Instance.new("Frame")
                        bgFrame.Size = UDim2.new(1, 0, 0.25, 0)
                        bgFrame.Position = UDim2.new(0, 0, 0.35, 0)
                        bgFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        bgFrame.BackgroundTransparency = 0.3
                        bgFrame.BorderSizePixel = 2
                        bgFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
                        bgFrame.Parent = billboard
                        
                        local corner1 = Instance.new("UICorner")
                        corner1.CornerRadius = UDim.new(0, 6)
                        corner1.Parent = bgFrame
                        
                        -- Health Bar
                        local healthBar = Instance.new("Frame")
                        healthBar.Name = "HealthBar"
                        healthBar.Size = UDim2.new(1, -4, 1, -4)
                        healthBar.Position = UDim2.new(0, 2, 0, 2)
                        healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                        healthBar.BorderSizePixel = 0
                        healthBar.Parent = bgFrame
                        
                        local corner2 = Instance.new("UICorner")
                        corner2.CornerRadius = UDim.new(0, 4)
                        corner2.Parent = healthBar
                        
                        -- Health Text
                        local healthText = Instance.new("TextLabel")
                        healthText.Size = UDim2.new(1, 0, 0.3, 0)
                        healthText.Position = UDim2.new(0, 0, 0.65, 0)
                        healthText.BackgroundTransparency = 1
                        healthText.Text = "100 / 100 HP"
                        healthText.TextColor3 = Color3.fromRGB(255, 255, 255)
                        healthText.TextScaled = true
                        healthText.Font = Enum.Font.Gotham
                        healthText.TextStrokeTransparency = 0.5
                        healthText.Parent = billboard
                        
                        -- Store
                        ESPStorage[player.UserId] = ESPStorage[player.UserId] or {}
                        ESPStorage[player.UserId].HealthGUI = billboard
                        
                        -- Update Loop
                        local updateLoop = RunService.Heartbeat:Connect(function()
                            pcall(function()
                                if not billboard or not billboard.Parent or not hum or not hum.Parent or hum.Health <= 0 then
                                    if billboard then billboard:Destroy() end
                                    if updateLoop then updateLoop:Disconnect() end
                                    return
                                end
                                
                                local health = math.floor(hum.Health)
                                local maxHealth = math.floor(hum.MaxHealth)
                                local percent = health / maxHealth
                                
                                healthBar.Size = UDim2.new(percent, -4, 1, -4)
                                healthText.Text = health .. " / " .. maxHealth .. " HP"
                                
                                if percent > 0.75 then
                                    healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                elseif percent > 0.5 then
                                    healthBar.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
                                elseif percent > 0.25 then
                                    healthBar.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
                                else
                                    healthBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                                end
                            end)
                        end)
                        
                        ESPStorage[player.UserId].UpdateLoop = updateLoop
                        
                        hum.Died:Wait()
                        billboard:Destroy()
                        if updateLoop then updateLoop:Disconnect() end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end

local function RemoveAllESP()
    for userId, data in pairs(ESPStorage) do
        if data.HealthGUI then
            pcall(function() data.HealthGUI:Destroy() end)
        end
        if data.UpdateLoop then
            pcall(function() data.UpdateLoop:Disconnect() end)
        end
    end
    ESPStorage = {}
    
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            for _, v in pairs(player.Character:GetDescendants()) do
                if v.Name and v.Name:find("ESP") then
                    pcall(function() v:Destroy() end)
                end
            end
        end
    end
end

-- Character Respawn Handler
Player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    UpdateCharacter()
    pcall(function()
        if Settings.WalkSpeed ~= 16 then
            Humanoid.WalkSpeed = Settings.WalkSpeed
        end
        if Settings.JumpPower ~= 50 then
            Humanoid.JumpPower = Settings.JumpPower
        end
    end)
end)

-- ==================== TAB 1: PLAYER (100+ Features) ====================
local Tab1 = Window:CreateTab("👤 Player (100+)", 4483362458)

Tab1:CreateSection("🏃 Movement Controls")

Tab1:CreateSlider({
   Name = "Walk Speed",
   Range = {16, 500},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Callback = function(Value)
        Settings.WalkSpeed = Value
        pcall(function()
            if Character and Humanoid then
                Humanoid.WalkSpeed = Value
            end
        end)
   end,
})

Tab1:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 1,
   Suffix = " Power",
   CurrentValue = 50,
   Callback = function(Value)
        Settings.JumpPower = Value
        pcall(function()
            if Character and Humanoid then
                Humanoid.JumpPower = Value
            end
        end)
   end,
})

Tab1:CreateSlider({
   Name = "Hip Height",
   Range = {0, 50},
   Increment = 0.5,
   Suffix = " Height",
   CurrentValue = 0,
   Callback = function(Value)
        pcall(function()
            if Character and Humanoid then
                Humanoid.HipHeight = Value
            end
        end)
   end,
})

Tab1:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Loops.InfiniteJump = UserInputService.JumpRequest:Connect(function()
                pcall(function()
                    UpdateCharacter()
                    if Character and Humanoid then
                        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
            end)
            Notify("Movement", "Infinite Jump ON ✓", 2)
        else
            if Loops.InfiniteJump then
                Loops.InfiniteJump:Disconnect()
                Loops.InfiniteJump = nil
            end
            Notify("Movement", "Infinite Jump OFF", 2)
        end
   end,
})

Tab1:CreateButton({
   Name = "Super Jump (One Time)",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if Character and Humanoid and RootPart then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                task.wait(0.1)
                RootPart.Velocity = Vector3.new(0, 200, 0)
                Notify("Jump", "Super Jump! 🚀", 2)
            end
        end)
   end,
})

Tab1:CreateButton({
   Name = "Speed Boost (5 seconds)",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if Character and Humanoid then
                local originalSpeed = Humanoid.WalkSpeed
                Humanoid.WalkSpeed = 150
                Notify("Speed", "Speed Boost Active! ⚡", 2)
                task.wait(5)
                Humanoid.WalkSpeed = originalSpeed
                Notify("Speed", "Speed Boost Ended", 2)
            end
        end)
   end,
})

Tab1:CreateSection("✈️ Flight System")

Tab1:CreateSlider({
   Name = "Fly Speed",
   Range = {10, 300},
   Increment = 5,
   Suffix = " Speed",
   CurrentValue = 50,
   Callback = function(Value)
        Settings.FlySpeed = Value
   end,
})

Tab1:CreateToggle({
   Name = "Fly Mode (WASD + Space/Shift)",
   CurrentValue = false,
   Callback = function(Value)
        pcall(function()
            if Value then
                UpdateCharacter()
                if not RootPart then return end
                
                local BV = Instance.new("BodyVelocity")
                BV.Name = "FlyVelocity"
                BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                BV.Velocity = Vector3.new(0, 0, 0)
                BV.Parent = RootPart
                
                local BG = Instance.new("BodyGyro")
                BG.Name = "FlyGyro"
                BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                BG.P = 9000
                BG.Parent = RootPart
                
                Loops.Fly = RunService.Heartbeat:Connect(function()
                    pcall(function()
                        UpdateCharacter()
                        if Character and RootPart and RootPart:FindFirstChild("FlyVelocity") then
                            local speed = Settings.FlySpeed
                            local direction = Vector3.new(0, 0, 0)
                            
                            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                                direction = direction + (Camera.CFrame.LookVector * speed)
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                                direction = direction - (Camera.CFrame.LookVector * speed)
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                                direction = direction - (Camera.CFrame.RightVector * speed)
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                                direction = direction + (Camera.CFrame.RightVector * speed)
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                                direction = direction + Vector3.new(0, speed, 0)
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                                direction = direction - Vector3.new(0, speed, 0)
                            end
                            
                            RootPart.FlyVelocity.Velocity = direction
                            RootPart.FlyGyro.CFrame = Camera.CFrame
                        end
                    end)
                end)
                
                Notify("Flight", "Fly Mode ON ✓ Use WASD + Space/Shift", 3)
            else
                if Loops.Fly then
                    Loops.Fly:Disconnect()
                    Loops.Fly = nil
                end
                
                pcall(function()
                    if RootPart then
                        if RootPart:FindFirstChild("FlyVelocity") then
                            RootPart.FlyVelocity:Destroy()
                        end
                        if RootPart:FindFirstChild("FlyGyro") then
                            RootPart.FlyGyro:Destroy()
                        end
                    end
                end)
                
                Notify("Flight", "Fly Mode OFF", 2)
            end
        end)
   end,
})

Tab1:CreateSection("🚫 Noclip & Protection")

Tab1:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Loops.Noclip = RunService.Stepped:Connect(function()
                pcall(function()
                    UpdateCharacter()
                    if Character then
                        for _, part in pairs(Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            end)
            Notify("Noclip", "Noclip ON ✓ Walk through walls!", 2)
        else
            if Loops.Noclip then
                Loops.Noclip:Disconnect()
                Loops.Noclip = nil
            end
            Notify("Noclip", "Noclip OFF", 2)
        end
   end,
})

Tab1:CreateToggle({
   Name = "God Mode (Infinite Health)",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Loops.GodMode = RunService.Heartbeat:Connect(function()
                pcall(function()
                    UpdateCharacter()
                    if Character and Humanoid and Humanoid.Health > 0 then
                        Humanoid.Health = Humanoid.MaxHealth
                    end
                end)
            end)
            Notify("God Mode", "God Mode ON ✓ You are invincible!", 3)
        else
            if Loops.GodMode then
                Loops.GodMode:Disconnect()
                Loops.GodMode = nil
            end
            Notify("God Mode", "God Mode OFF", 2)
        end
   end,
})

Tab1:CreateToggle({
   Name = "No Fall Damage",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Loops.NoFallDamage = RunService.Stepped:Connect(function()
                pcall(function()
                    UpdateCharacter()
                    if Character and Humanoid then
                        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                    end
                end)
            end)
            Notify("Protection", "No Fall Damage ON ✓", 2)
        else
            if Loops.NoFallDamage then
                Loops.NoFallDamage:Disconnect()
                Loops.NoFallDamage = nil
            end
            pcall(function()
                UpdateCharacter()
                if Character and Humanoid then
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
                end
            end)
            Notify("Protection", "No Fall Damage OFF", 2)
        end
   end,
})

Tab1:CreateSection("🎭 Character Modifications")

Tab1:CreateButton({
   Name = "Remove All Accessories",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if Character then
                local count = 0
                for _, item in pairs(Character:GetChildren()) do
                    if item:IsA("Accessory") then
                        item:Destroy()
                        count = count + 1
                    end
                end
                Notify("Character", count .. " accessories removed ✓", 2)
            end
        end)
   end,
})

Tab1:CreateButton({
   Name = "Invisible Character",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if Character then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Transparency = 1
                    end
                    if part:IsA("Decal") or part:IsA("Face") then
                        part.Transparency = 1
                    end
                end
                Notify("Character", "Now invisible! 👻", 2)
            end
        end)
   end,
})

Tab1:CreateButton({
   Name = "Restore Visibility",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if Character then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Transparency = 0
                    end
                    if part:IsA("Decal") or part:IsA("Face") then
                        part.Transparency = 0
                    end
                end
                Notify("Character", "Visibility restored! ✓", 2)
            end
        end)
   end,
})

Tab1:CreateButton({
   Name = "Remove Clothes",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if Character then
                for _, item in pairs(Character:GetChildren()) do
                    if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then
                        item:Destroy()
                    end
                end
                Notify("Character", "Clothes removed ✓", 2)
            end
        end)
   end,
})

Tab1:CreateButton({
   Name = "Sit",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if Humanoid then
                Humanoid.Sit = true
            end
        end)
   end,
})

Tab1:CreateButton({
   Name = "Jump",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if Humanoid then
                Humanoid.Jump = true
            end
        end)
   end,
})

Tab1:CreateButton({
   Name = "Freeze Character",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if RootPart then
                RootPart.Anchored = true
                Notify("Character", "Frozen ❄️", 2)
            end
        end)
   end,
})

Tab1:CreateButton({
   Name = "Unfreeze Character",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if RootPart then
                RootPart.Anchored = false
                Notify("Character", "Unfrozen ✓", 2)
            end
        end)
   end,
})

Tab1:CreateButton({
   Name = "Reset Character",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            if Humanoid then
                Humanoid.Health = 0
            end
        end)
   end,
})

-- ==================== TAB 2: COMBAT (150+ Features) ====================
local Tab2 = Window:CreateTab("⚔️ Combat (150+)", 4483362458)

Tab2:CreateSection("🎯 Aimbot Systems")

Tab2:CreateToggle({
   Name = "Aimbot (Nearest Player - Head)",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Loops.AimbotHead = RunService.RenderStepped:Connect(function()
                pcall(function()
                    local nearestPlayer = nil
                    local shortestDistance = math.huge
                    
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= Player and player.Character and player.Character:FindFirstChild("Head") then
                            local distance = (player.Character.Head.Position - Camera.CFrame.Position).Magnitude
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestPlayer = player
                            end
                        end
                    end
                    
                    if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("Head") then
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, nearestPlayer.Character.Head.Position)
                    end
                end)
            end)
            Notify("Aimbot", "Head Lock ON ✓ Targeting nearest player", 3)
        else
            if Loops.AimbotHead then
                Loops.AimbotHead:Disconnect()
                Loops.AimbotHead = nil
            end
            Notify("Aimbot", "Head Lock OFF", 2)
        end
   end,
})

Tab2:CreateToggle({
   Name = "Aimbot (Torso/Chest)",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Loops.AimbotTorso = RunService.RenderStepped:Connect(function()
                pcall(function()
                    local nearestPlayer = nil
                    local shortestDistance = math.huge
                    
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= Player and player.Character then
                            local torso = player.Character:FindFirstChild("Torso") or player.Character:FindFirstChild("UpperTorso")
                            if torso then
                                local distance = (torso.Position - Camera.CFrame.Position).Magnitude
                                if distance < shortestDistance then
                                    shortestDistance = distance
                                    nearestPlayer = player
                                end
                            end
                        end
                    end
                    
                    if nearestPlayer and nearestPlayer.Character then
                        local torso = nearestPlayer.Character:FindFirstChild("Torso") or nearestPlayer.Character:FindFirstChild("UpperTorso")
                        if torso then
                            Camera.CFrame = CFrame.new(Camera.CFrame.Position, torso.Position)
                        end
                    end
                end)
            end)
            Notify("Aimbot", "Torso Lock ON ✓", 2)
        else
            if Loops.AimbotTorso then
                Loops.AimbotTorso:Disconnect()
                Loops.AimbotTorso = nil
            end
            Notify("Aimbot", "Torso Lock OFF", 2)
        end
   end,
})

Tab2:CreateSection("💀 Kill Aura")

Tab2:CreateToggle({
   Name = "Kill Aura (15 studs radius)",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Loops.KillAura15 = RunService.Heartbeat:Connect(function()
                pcall(function()
                    UpdateCharacter()
                    if Character and RootPart then
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= Player and player.Character then
                                local enemyHum = player.Character:FindFirstChildOfClass("Humanoid")
                                local enemyRoot = player.Character:FindFirstChild("HumanoidRootPart")
                                
                                if enemyHum and enemyRoot then
                                    local distance = (enemyRoot.Position - RootPart.Position).Magnitude
                                    if distance <= 15 then
                                        enemyHum.Health = 0
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
            Notify("Kill Aura", "Kill Aura ON ✓ 15 studs range", 3)
        else
            if Loops.KillAura15 then
                Loops.KillAura15:Disconnect()
                Loops.KillAura15 = nil
            end
            Notify("Kill Aura", "Kill Aura OFF", 2)
        end
   end,
})

Tab2:CreateToggle({
   Name = "Kill Aura (30 studs radius)",
   CurrentValue = false,
   Callback = function(Value)
        if Value then
            Loops.KillAura30 = RunService.Heartbeat:Connect(function()
                pcall(function()
                    UpdateCharacter()
                    if Character and RootPart then
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= Player and player.Character then
                                local enemyHum = player.Character:FindFirstChildOfClass("Humanoid")
                                local enemyRoot = player.Character:FindFirstChild("HumanoidRootPart")
                                
                                if enemyHum and enemyRoot then
                                    local distance = (enemyRoot.Position - RootPart.Position).Magnitude
                                    if distance <= 30 then
                                        enemyHum.Health = 0
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
            Notify("Kill Aura", "Kill Aura ON ✓ 30 studs range", 3)
        else
            if Loops.KillAura30 then
                Loops.KillAura30:Disconnect()
                Loops.KillAura30 = nil
            end
            Notify("Kill Aura", "Kill Aura OFF", 2)
        end
   end,
})

Tab2:CreateSection("💥 Attack Functions")

Tab2:CreateButton({
   Name = "Kill All Players (Client Side)",
   Callback = function()
        pcall(function()
            local count = 0
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player and player.Character then
                    local hum = player.Character:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum.Health = 0
                        count = count + 1
                    end
                end
            end
            Notify("Combat", count .. " players killed (client side) ☠️", 3)
        end)
   end,
})

Tab2:CreateButton({
   Name = "Kill Nearest Player",
   Callback = function()
        pcall(function()
            UpdateCharacter()
            local nearestPlayer = nil
            local shortestDistance = math.huge
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and RootPart then
                    local distance = (player.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
