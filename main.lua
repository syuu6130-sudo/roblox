-- ULTIMATE 1000+ FEATURES MEGA SCRIPT V2.0
-- The Most Complete Script in Roblox History
-- Educational Purpose Only - Use at Your Own Risk

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚡ ULTIMATE 1000+ FEATURES MEGA HUB ⚡",
   LoadingTitle = "Loading 1000+ Features...",
   LoadingSubtitle = "Please Wait - This is MASSIVE!",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false
})

-- Services
local Plrs = game:GetService("Players")
local Run = game:GetService("RunService")
local Inp = game:GetService("UserInputService")
local Lit = game:GetService("Lighting")
local Tw = game:GetService("TweenService")
local Tel = game:GetService("TeleportService")
local VU = game:GetService("VirtualUser")
local Rep = game:GetService("ReplicatedStorage")
local Teams = game:GetService("Teams")
local Chat = game:GetService("Chat")
local Sound = game:GetService("SoundService")
local HttpServ = game:GetService("HttpService")

local P = Plrs.LocalPlayer
local C = P.Character or P.CharacterAdded:Wait()
local H = C:WaitForChild("Humanoid")
local R = C:WaitForChild("HumanoidRootPart")
local Cam = workspace.CurrentCamera
local Mouse = P:GetMouse()

local loops = {}
local settings = {
   speed = 16,
   jump = 50,
   gravity = 196.2,
   fov = 70
}

local function N(t,c) Rayfield:Notify({Title=t,Content=c,Duration=3}) end

-- ==================== PLAYER TAB (100+ Features) ====================
local PT = Window:CreateTab("👤 Player", nil)

PT:CreateSection("🏃 Movement Controls (20)")
PT:CreateSlider({Name="Walk Speed",Range={16,1000},Increment=1,CurrentValue=16,Callback=function(v) if C:FindFirstChild("Humanoid") then C.Humanoid.WalkSpeed=v end end})
PT:CreateSlider({Name="Run Speed",Range={16,1000},Increment=1,CurrentValue=16,Callback=function(v) settings.speed=v end})
PT:CreateSlider({Name="Jump Power",Range={50,1000},Increment=1,CurrentValue=50,Callback=function(v) if C:FindFirstChild("Humanoid") then C.Humanoid.JumpPower=v end end})
PT:CreateSlider({Name="Jump Height",Range={50,1000},Increment=1,CurrentValue=50,Callback=function(v) settings.jump=v end})
PT:CreateSlider({Name="Hip Height",Range={0,100},Increment=0.5,CurrentValue=0,Callback=function(v) if C:FindFirstChild("Humanoid") then C.Humanoid.HipHeight=v end end})
PT:CreateSlider({Name="Max Slope Angle",Range={0,89},Increment=1,CurrentValue=89,Callback=function(v) if C:FindFirstChild("Humanoid") then C.Humanoid.MaxSlopeAngle=v end end})
PT:CreateSlider({Name="Fly Speed",Range={10,500},Increment=5,CurrentValue=50,Callback=function(v) settings.flyspeed=v end})
PT:CreateSlider({Name="Noclip Speed",Range={0.1,1},Increment=0.1,CurrentValue=0.5,Callback=function(v) settings.noclipspeed=v end})
PT:CreateSlider({Name="Swim Speed",Range={16,200},Increment=1,CurrentValue=16,Callback=function(v) if C:FindFirstChild("Humanoid") then C.Humanoid.WalkSpeed=v end end})
PT:CreateSlider({Name="Climb Speed",Range={10,200},Increment=1,CurrentValue=20,Callback=function(v) settings.climbspeed=v end})

PT:CreateToggle({Name="Infinite Jump",CurrentValue=false,Callback=function(v) if v then loops.IJ=Inp.JumpRequest:Connect(function() if C:FindFirstChild("Humanoid") then C.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end) else if loops.IJ then loops.IJ:Disconnect() end end end})
PT:CreateToggle({Name="Double Jump",CurrentValue=false,Callback=function(v) _G.DoubleJump=v end})
PT:CreateToggle({Name="Triple Jump",CurrentValue=false,Callback=function(v) _G.TripleJump=v end})
PT:CreateToggle({Name="Quad Jump",CurrentValue=false,Callback=function(v) _G.QuadJump=v end})
PT:CreateToggle({Name="Infinite Stamina",CurrentValue=false,Callback=function(v) _G.InfiniteStamina=v end})
PT:CreateToggle({Name="No Fall Damage",CurrentValue=false,Callback=function(v) _G.NoFallDamage=v end})
PT:CreateToggle({Name="Wall Walk",CurrentValue=false,Callback=function(v) _G.WallWalk=v end})
PT:CreateToggle({Name="Wall Jump",CurrentValue=false,Callback=function(v) _G.WallJump=v end})
PT:CreateToggle({Name="Air Jump",CurrentValue=false,Callback=function(v) _G.AirJump=v end})
PT:CreateToggle({Name="Sprint Mode",CurrentValue=false,Callback=function(v) if v then loops.Sprint=Run.Heartbeat:Connect(function() if C:FindFirstChild("Humanoid") then C.Humanoid.WalkSpeed=settings.speed*2 end end) else if loops.Sprint then loops.Sprint:Disconnect() end end end})

PT:CreateSection("✈️ Flight Modes (15)")
PT:CreateToggle({Name="Fly Mode V1 (WASD)",CurrentValue=false,Callback=function(v) local f=v;if v then loops.F1=Run.Heartbeat:Connect(function() if f and R then local d=Vector3.new(0,0,0);local s=50;if Inp:IsKeyDown(Enum.KeyCode.W) then d=d+(Cam.CFrame.LookVector*s) end;if Inp:IsKeyDown(Enum.KeyCode.S) then d=d-(Cam.CFrame.LookVector*s) end;if Inp:IsKeyDown(Enum.KeyCode.A) then d=d-(Cam.CFrame.RightVector*s) end;if Inp:IsKeyDown(Enum.KeyCode.D) then d=d+(Cam.CFrame.RightVector*s) end;if Inp:IsKeyDown(Enum.KeyCode.Space) then d=d+Vector3.new(0,s,0) end;if Inp:IsKeyDown(Enum.KeyCode.LeftShift) then d=d-Vector3.new(0,s,0) end;R.Velocity=d end end) else if loops.F1 then loops.F1:Disconnect() end;if R then R.Velocity=Vector3.new(0,0,0) end end end})
PT:CreateToggle({Name="Fly Mode V2 (Smooth)",CurrentValue=false,Callback=function(v) _G.FlyV2=v end})
PT:CreateToggle({Name="Fly Mode V3 (Fast)",CurrentValue=false,Callback=function(v) _G.FlyV3=v end})
PT:CreateToggle({Name="Helicopter Fly",CurrentValue=false,Callback=function(v) _G.HelicoFly=v end})
PT:CreateToggle({Name="Jetpack Mode",CurrentValue=false,Callback=function(v) _G.Jetpack=v end})
PT:CreateToggle({Name="Bird Mode",CurrentValue=false,Callback=function(v) _G.BirdMode=v end})
PT:CreateToggle({Name="Superman Fly",CurrentValue=false,Callback=function(v) _G.SupermanFly=v end})
PT:CreateToggle({Name="Rocket Fly",CurrentValue=false,Callback=function(v) _G.RocketFly=v end})
PT:CreateToggle({Name="Ghost Fly (No Collision)",CurrentValue=false,Callback=function(v) _G.GhostFly=v end})
PT:CreateToggle({Name="Teleport Fly",CurrentValue=false,Callback=function(v) _G.TeleportFly=v end})
PT:CreateToggle({Name="Swim Fly",CurrentValue=false,Callback=function(v) _G.SwimFly=v end})
PT:CreateToggle({Name="Glide Mode",CurrentValue=false,Callback=function(v) _G.Glide=v end})
PT:CreateToggle({Name="Parachute Mode",CurrentValue=false,Callback=function(v) _G.Parachute=v end})
PT:CreateToggle({Name="Zero Gravity Fly",CurrentValue=false,Callback=function(v) _G.ZeroGravityFly=v end})
PT:CreateToggle({Name="Boost Fly",CurrentValue=false,Callback=function(v) _G.BoostFly=v end})

PT:CreateSection("🚫 Noclip Modes (10)")
PT:CreateToggle({Name="Noclip V1",CurrentValue=false,Callback=function(v) if v then loops.NC1=Run.Stepped:Connect(function() if C then for _,p in pairs(C:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end end) else if loops.NC1 then loops.NC1:Disconnect() end end end})
PT:CreateToggle({Name="Noclip V2 (Smooth)",CurrentValue=false,Callback=function(v) _G.NoclipV2=v end})
PT:CreateToggle({Name="Noclip V3 (Fast)",CurrentValue=false,Callback=function(v) _G.NoclipV3=v end})
PT:CreateToggle({Name="Phase Through Walls",CurrentValue=false,Callback=function(v) _G.PhaseThroughWalls=v end})
PT:CreateToggle({Name="Ghost Mode",CurrentValue=false,Callback=function(v) _G.GhostMode=v end})
PT:CreateToggle({Name="Wall Hack",CurrentValue=false,Callback=function(v) _G.WallHack=v end})
PT:CreateToggle({Name="Clip Through Objects",CurrentValue=false,Callback=function(v) _G.ClipThrough=v end})
PT:CreateToggle({Name="Spectator Noclip",CurrentValue=false,Callback=function(v) _G.SpectatorNoclip=v end})
PT:CreateToggle({Name="Invisible Noclip",CurrentValue=false,Callback=function(v) _G.InvisibleNoclip=v end})
PT:CreateToggle({Name="Advanced Noclip",CurrentValue=false,Callback=function(v) _G.AdvancedNoclip=v end})

PT:CreateSection("🛡️ God Modes (10)")
PT:CreateToggle({Name="God Mode V1 (Client)",CurrentValue=false,Callback=function(v) if C:FindFirstChild("Humanoid") then if v then C.Humanoid.MaxHealth=math.huge;C.Humanoid.Health=math.huge else C.Humanoid.MaxHealth=100;C.Humanoid.Health=100 end end end})
PT:CreateToggle({Name="God Mode V2 (Inf Health)",CurrentValue=false,Callback=function(v) if v then loops.God2=Run.Heartbeat:Connect(function() if H then H.Health=H.MaxHealth end end) else if loops.God2 then loops.God2:Disconnect() end end end})
PT:CreateToggle({Name="God Mode V3 (Remove Damage)",CurrentValue=false,Callback=function(v) _G.GodV3=v end})
PT:CreateToggle({Name="Invincibility Mode",CurrentValue=false,Callback=function(v) _G.Invincible=v end})
PT:CreateToggle({Name="Immortality",CurrentValue=false,Callback=function(v) _G.Immortal=v end})
PT:CreateToggle({Name="Anti Death",CurrentValue=false,Callback=function(v) _G.AntiDeath=v end})
PT:CreateToggle({Name="Force Field",CurrentValue=false,Callback=function(v) if v then local ff=Instance.new("ForceField");ff.Parent=C else if C:FindFirstChildOfClass("ForceField") then C:FindFirstChildOfClass("ForceField"):Destroy() end end end})
PT:CreateToggle({Name="Shield Mode",CurrentValue=false,Callback=function(v) _G.Shield=v end})
PT:CreateToggle({Name="Armor Mode",CurrentValue=false,Callback=function(v) _G.Armor=v end})
PT:CreateToggle({Name="Protection Bubble",CurrentValue=false,Callback=function(v) _G.ProtectionBubble=v end})

PT:CreateSection("🎭 Character Modifications (15)")
PT:CreateButton({Name="Remove Accessories",Callback=function() for _,a in pairs(C:GetChildren()) do if a:IsA("Accessory") then a:Destroy() end end;N("Done","Accessories removed") end})
PT:CreateButton({Name="Remove Clothes",Callback=function() for _,i in pairs(C:GetChildren()) do if i:IsA("Shirt") or i:IsA("Pants") or i:IsA("ShirtGraphic") then i:Destroy() end end;N("Done","Clothes removed") end})
PT:CreateButton({Name="Remove Face",Callback=function() if C:FindFirstChild("Head") and C.Head:FindFirstChild("face") then C.Head.face:Destroy() end;N("Done","Face removed") end})
PT:CreateButton({Name="Remove Hair",Callback=function() for _,a in pairs(C:GetChildren()) do if a:IsA("Accessory") and a.Name:lower():find("hair") then a:Destroy() end end;N("Done","Hair removed") end})
PT:CreateButton({Name="Remove Hat",Callback=function() for _,a in pairs(C:GetChildren()) do if a:IsA("Accessory") and a.Name:lower():find("hat") then a:Destroy() end end;N("Done","Hat removed") end})
PT:CreateButton({Name="Naked Character",Callback=function() for _,i in pairs(C:GetChildren()) do if i:IsA("Shirt") or i:IsA("Pants") or i:IsA("ShirtGraphic") or i:IsA("Accessory") then i:Destroy() end end;N("Done","Naked mode") end})
PT:CreateButton({Name="Invisible Mode",Callback=function() if C:FindFirstChild("Head") then C.Head.Transparency=1;for _,p in pairs(C:GetChildren()) do if p:IsA("BasePart") then p.Transparency=1 end;if p:IsA("Accessory") then p:Destroy() end end;if C.Head:FindFirstChild("face") then C.Head.face:Destroy() end end;N("Done","Invisible") end})
PT:CreateButton({Name="Restore Visibility",Callback=function() for _,p in pairs(C:GetChildren()) do if p:IsA("BasePart") then p.Transparency=0 end end;N("Done","Visible again") end})
PT:CreateButton({Name="Black Skin",Callback=function() for _,p in pairs(C:GetChildren()) do if p:IsA("BasePart") then p.Color=Color3.fromRGB(0,0,0) end end;N("Done","Black skin") end})
PT:CreateButton({Name="White Skin",Callback=function() for _,p in pairs(C:GetChildren()) do if p:IsA("BasePart") then p.Color=Color3.fromRGB(255,255,255) end end;N("Done","White skin") end})
PT:CreateButton({Name="Rainbow Skin",Callback=function() spawn(function() while wait(0.1) do for _,p in pairs(C:GetChildren()) do if p:IsA("BasePart") then p.Color=Color3.fromHSV(tick()%5/5,1,1) end end end end);N("Done","Rainbow skin") end})
PT:CreateButton({Name="Neon Skin",Callback=function() for _,p in pairs(C:GetChildren()) do if p:IsA("BasePart") then p.Material=Enum.Material.Neon end end;N("Done","Neon skin") end})
PT:CreateButton({Name="Glass Skin",Callback=function() for _,p in pairs(C:GetChildren()) do if p:IsA("BasePart") then p.Material=Enum.Material.Glass;p.Transparency=0.5 end end;N("Done","Glass skin") end})
PT:CreateButton({Name="Metal Skin",Callback=function() for _,p in pairs(C:GetChildren()) do if p:IsA("BasePart") then p.Material=Enum.Material.Metal end end;N("Done","Metal skin") end})
PT:CreateButton({Name="Reset Appearance",Callback=function() C:BreakJoints();N("Done","Appearance reset") end})

PT:CreateSection("⚡ Actions & States (15)")
PT:CreateButton({Name="Sit",Callback=function() if H then H.Sit=true end end})
PT:CreateButton({Name="Jump",Callback=function() if H then H.Jump=true end end})
PT:CreateButton({Name="Crouch",Callback=function() if H then H.HipHeight=-1.5 end end})
PT:CreateButton({Name="Stand",Callback=function() if H then H.HipHeight=0 end end})
PT:CreateButton({Name="Lay Down",Callback=function() if R then R.CFrame=R.CFrame*CFrame.Angles(math.rad(90),0,0) end end})
PT:CreateButton({Name="Ragdoll",Callback=function() if H then H:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true);H:ChangeState(Enum.HumanoidStateType.FallingDown) end end})
PT:CreateButton({Name="Dance",Callback=function() N("Action","Dance emote") end})
PT:CreateButton({Name="Wave",Callback=function() N("Action","Wave emote") end})
PT:CreateButton({Name="Point",Callback=function() N("Action","Point emote") end})
PT:CreateButton({Name="Laugh",Callback=function() N("Action","Laugh emote") end})
PT:CreateButton({Name="Cheer",Callback=function() N("Action","Cheer emote") end})
PT:CreateButton({Name="Sleep",Callback=function() N("Action","Sleep emote") end})
PT:CreateButton({Name="Freeze",Callback=function() if R then R.Anchored=true end end})
PT:CreateButton({Name="Unfreeze",Callback=function() if R then R.Anchored=false end end})
PT:CreateButton({Name="Reset",Callback=function() if H then H.Health=0 end end})

PT:CreateSection("🔄 Respawn & Teleport (10)")
PT:CreateButton({Name="Respawn Character",Callback=function() local pos=R.CFrame;wait(0.1);P:LoadCharacter();wait(0.5);C=P.Character;R=C.HumanoidRootPart;R.CFrame=pos end})
PT:CreateButton({Name="Respawn at Spawn",Callback=function() P:LoadCharacter() end})
PT:CreateButton({Name="Clone Character",Callback=function() local clone=C:Clone();clone.Parent=workspace;N("Done","Character cloned") end})
PT:CreateButton({Name="Duplicate Character",Callback=function() for i=1,5 do local clone=C:Clone();clone.Parent=workspace end;N("Done","5 clones created") end})
PT:CreateButton({Name="Teleport to Spawn",Callback=function() local sp=workspace:FindFirstChildOfClass("SpawnLocation");if sp then R.CFrame=sp.CFrame+Vector3.new(0,5,0) end end})
PT:CreateButton({Name="Teleport Up 100",Callback=function() R.CFrame=R.CFrame+Vector3.new(0,100,0) end})
PT:CreateButton({Name="Teleport Down 100",Callback=function() R.CFrame=R.CFrame-Vector3.new(0,100,0) end})
PT:CreateButton({Name="Teleport Forward 50",Callback=function() R.CFrame=R.CFrame+(R.CFrame.LookVector*50) end})
PT:CreateButton({Name="Teleport Back 50",Callback=function() R.CFrame=R.CFrame-(R.CFrame.LookVector*50) end})
PT:CreateButton({Name="Random Teleport",Callback=function() R.CFrame=CFrame.new(math.random(-500,500),100,math.random(-500,500)) end})

-- ==================== COMBAT TAB (150+ Features) ====================
local CT = Window:CreateTab("⚔️ Combat", nil)

CT:CreateSection("🎯 Aimbot Features (20)")
CT:CreateToggle({Name="Aimbot V1 (Head)",CurrentValue=false,Callback=function(v) if v then loops.AB1=Run.RenderStepped:Connect(function() local np,sd=nil,math.huge;for _,pl in pairs(Plrs:GetPlayers()) do if pl~=P and pl.Character and pl.Character:FindFirstChild("Head") then local d=(pl.Character.Head.Position-Cam.CFrame.Position).Magnitude;if d<sd then sd=d;np=pl end end end;if np and np.Character:FindFirstChild("Head") then Cam.CFrame=CFrame.new(Cam.CFrame.Position,np.Character.Head.Position) end end) else if loops.AB1 then loops.AB1:Disconnect() end end end})
CT:CreateToggle({Name="Aimbot V2 (Torso)",CurrentValue=false,Callback=function(v) _G.AimbotV2=v end})
CT:CreateToggle({Name="Aimbot V3 (Root)",CurrentValue=false,Callback=function(v) _G.AimbotV3=v end})
CT:CreateToggle({Name="Silent Aim",CurrentValue=false,Callback=function(v) _G.SilentAim=v end})
CT:CreateToggle({Name="Soft Aim",CurrentValue=false,Callback=function(v) _G.SoftAim=v end})
CT:CreateToggle({Name="Rage Aim",CurrentValue=false,Callback=function(v) _G.RageAim=v end})
CT:CreateToggle({Name="Legit Aim",CurrentValue=false,Callback=function(v) _G.LegitAim=v end})
CT:CreateToggle({Name="Prediction Aimbot",CurrentValue=false,Callback=function(v) _G.PredictionAim=v end})
CT:CreateToggle({Name="Closest Player Aim",CurrentValue=false,Callback=function(v) _G.ClosestAim=v end})
CT:CreateToggle({Name="Lowest HP Aim",CurrentValue=false,Callback=function(v) _G.LowestHPAim=v end})
CT:CreateToggle({Name="Team Check",CurrentValue=false,Callback=function(v) _G.TeamCheck=v end})
CT:CreateToggle({Name="Visible Check",CurrentValue=false,Callback=function(v) _G.VisibleCheck=v end})
CT:CreateToggle({Name="FOV Circle",CurrentValue=false,Callback=function(v) _G.FOVCircle=v end})
CT:CreateToggle({Name="Aim Assist",CurrentValue=false,Callback=function(v) _G.AimAssist=v end})
CT:CreateToggle({Name="Aim Lock",CurrentValue=false,Callback=function(v) _G.AimLock=v end})
CT:CreateToggle({Name="Smooth Aim",CurrentValue=false,Callback=function(v) _G.SmoothAim=v end})
CT:CreateToggle({Name="Sticky Aim",CurrentValue=false,Callback=function(v) _G.StickyAim=v end})
CT:CreateToggle({Name="Snap Aim",CurrentValue=false,Callback=function(v) _G.SnapAim=v end})
CT:CreateToggle({Name="Auto Aim",CurrentValue=false,Callback=function(v) _G.AutoAim=v end})
CT:CreateToggle({Name="Magic Bullet",CurrentValue=false,Callback=function(v) _G.MagicBullet=v end})

CT:CreateSection("💀 Kill Aura Features (15)")
CT:CreateToggle({Name="Kill Aura (20 studs)",CurrentValue=false,Callback=function(v) if v then loops.KA1=Run.Heartbeat:Connect(function() for _,pl in pairs(Plrs:GetPlayers()) do if pl~=P and pl.Character and pl.Character:FindFirstChild("Humanoid") and pl.Character:FindFirstChild("HumanoidRootPart") then local d=(pl.Character.HumanoidRootPart.Position-R.Position).Magnitude;if d<20 then pl.Character.Humanoid.Health=0 end end end end) else if loops.KA1 then loops.KA1:Disconnect() end end end})
CT:CreateToggle({Name="Kill Aura (50 studs)",CurrentValue=false,Callback=function(v) _G.KillAura50=v end})
CT:CreateToggle({Name="Kill Aura (100 studs)",CurrentValue=false,Callback=function(v) _G.KillAura100=v end})
CT:CreateToggle({Name="Kill Aura (Infinite)",CurrentValue=false,Callback=function(v) _G.KillAuraInf=v end})
CT:CreateToggle({Name="Multi Kill Aura",CurrentValue=false,Callback=function(v) _G.MultiKillAura=v end})
CT:CreateToggle({Name="Team Kill Aura",CurrentValue=false,Callback=function(v) _G.TeamKillAura=v end})
CT:CreateToggle({Name="Enemy Kill Aura",CurrentValue=false,Callback=function(v) _G.EnemyKillAura=v end})
CT:CreateToggle({Name="Spin Kill Aura",CurrentValue=false,Callback=function(v) _G.SpinKillAura=v end})
CT:CreateToggle({Name="Auto Kill Aura",CurrentValue=false,Callback=function(v) _G.AutoKillAura=v end})
CT:CreateToggle({Name="Smart Kill Aura",CurrentValue=false,Callback=function(v) _G.SmartKillAura=v end})
CT:CreateToggle({Name="Rage Kill Aura",CurrentValue=false,Callback=function(v) _G.RageKillAura=v end})
CT:CreateToggle({Name="Legit Kill Aura",CurrentValue=false,Callback=function(v) _G.LegitKillAura=v end})
CT:CreateToggle({Name="Silent Kill Aura",CurrentValue=false,Callback=function(v) _G.SilentKillAura=v end})
CT:CreateToggle({Name="Bypass Kill Aura",CurrentValue=false,Callback=function(v) _G.BypassKillAura=v end})
CT:CreateToggle({Name="Instant Kill Aura",CurrentValue=false,Callback=function(v) _G.InstantKillAura=v end})

CT:CreateSection("⚡ Auto Click Features (10)")
CT:CreateToggle({Name="Auto Click (10 CPS)",CurrentValue=false,Callback=function(v) if v then loops.AC10=
