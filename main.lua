-- Rayfield UIロード
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/BlizTBr/scripts/main/Rayfield.lua"))()

local Window = Rayfield:CreateWindow({
	Name = "俺物人 Studio版",
	LoadingTitle = "読み込み中...",
	KeySystem = false
})

-- =========================
-- タブ1：俺物人基本操作
-- =========================
local Tab1 = Window:CreateTab("俺物人操作")
local Section1 = Tab1:CreateSection("移動・ジャンプ")

-- 飛ぶボタン
Section1:CreateButton({
	Name = "飛ぶ",
	Callback = function()
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
		local hrp = char:WaitForChild("HumanoidRootPart")

		-- BodyVelocityで即座に上方向に飛ばす
		local bv = Instance.new("BodyVelocity")
		bv.Velocity = Vector3.new(0, 100, 0)
		bv.MaxForce = Vector3.new(0, math.huge, 0)
		bv.Parent = hrp
		game:GetService("Debris"):AddItem(bv, 0.3)
	end
})

-- 移動速度スライダー
Section1:CreateSlider({
	Name = "移動速度",
	Range = {16, 200},
	Increment = 1,
	Suffix = "studs/s",
	CurrentValue = 16,
	Flag = "SpeedSlider",
	Callback = function(value)
		local player = game.Players.LocalPlayer
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = value
		end
	end
})

-- ジャンプ力スライダー
Section1:CreateSlider({
	Name = "ジャンプ力",
	Range = {50, 500},
	Increment = 5,
	Suffix = "",
	CurrentValue = 50,
	Flag = "JumpSlider",
	Callback = function(value)
		local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.JumpPower = value
		end
	end
})

-- =========================
-- タブ2：特殊操作
-- =========================
local Tab2 = Window:CreateTab("特殊操作")
local Section2 = Tab2:CreateSection("ステッキ・フリング")

-- 光るステッキ
Section2:CreateButton({
	Name = "光るステッキ",
	Callback = function()
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
		local hrp = char:WaitForChild("HumanoidRootPart")

		local part = Instance.new("Part")
		part.Size = Vector3.new(1, 4, 1)
		part.Anchored = false
		part.CanCollide = false
		part.BrickColor = BrickColor.new("Bright yellow")
		part.Material = Enum.Material.Neon
		part.CFrame = hrp.CFrame * CFrame.new(0, 2, 0)
		part.Parent = workspace
		game:GetService("Debris"):AddItem(part, 2)
	end
})

-- Blitz FTAP統合
Section2:CreateButton({
	Name = "フリング起動",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/BlizTBr/scripts/main/FTAP.lua"))()
	end
})

-- =========================
-- タブ3：物理押す・ぶん投げ
-- =========================
local Tab3 = Window:CreateTab("俺物人フリング")
local Section3 = Tab3:CreateSection("フリング系")

-- 例：近くの物体を前方向に押す
Section3:CreateButton({
	Name = "前方に押す",
	Callback = function()
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
		local hrp = char:WaitForChild("HumanoidRootPart")

		for _, obj in pairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and (obj.Position - hrp.Position).Magnitude < 15 then
				local bv = Instance.new("BodyVelocity")
				bv.Velocity = hrp.CFrame.LookVector * 100
				bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				bv.Parent = obj
				game:GetService("Debris"):AddItem(bv, 0.5)
			end
		end
	end
})

-- Executor版っぽい即反応を意識してRenderSteppedで更新も可能
