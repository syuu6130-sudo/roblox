-- Rayfield UIロード
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/BlizTBr/scripts/main/Rayfield.lua"))()

local Window = Rayfield:CreateWindow({
	Name = "俺物人 Studio版",
	LoadingTitle = "読み込み中...",
	KeySystem = false
})

-- タブ作成
local Tab1 = Window:CreateTab("俺物人操作")
local Section1 = Tab1:CreateSection("基本動作")

-- 飛ぶボタン
Section1:CreateButton({
	Name = "飛ぶ",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.Velocity = Vector3.new(0,50,0) -- 上方向にジャンプ
	end
})

-- 移動速度スライダー
Section1:CreateSlider({
	Name = "移動速度",
	Range = {16,200},
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
	Range = {50,500},
	Increment = 5,
	Suffix = "",
	CurrentValue = 50,
	Flag = "JumpSlider",
	Callback = function(value)
		local player = game.Players.LocalPlayer
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.JumpPower = value
		end
	end
})

-- タブ2：フリング（Blitz FTAP）
local Tab2 = Window:CreateTab("フリング")
local Section2 = Tab2:CreateSection("Blitz FTAP")

Section2:CreateButton({
	Name = "フリング起動",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/BlizTBr/scripts/main/FTAP.lua"))()
	end
})

-- ここから他の俺物人用ボタン・ステッキ操作も追加可能
local Section3 = Tab1:CreateSection("特殊操作")

Section3:CreateButton({
	Name = "光るステッキ",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		-- 光るステッキ処理（例：パーティクルや光エフェクト）
		local part = Instance.new("Part")
		part.Size = Vector3.new(1,4,1)
		part.Anchored = false
		part.CanCollide = false
		part.BrickColor = BrickColor.new("Bright yellow")
		part.Material = Enum.Material.Neon
		part.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0,2,0)
		part.Parent = workspace
		game:GetService("Debris"):AddItem(part,2)
	end
})
